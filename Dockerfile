FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    build-essential \
    socat \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /pwn

# Copy challenge files
COPY chall.c .
COPY flag.txt .
COPY ld-2.27.so .
COPY libc-2.27.so .

# Build the challenge without PIE, but keeping other protections off
# -no-pie: Ensure addresses are static
# -fno-stack-protector: Turn off stack canaries
RUN gcc -o chall chall.c -no-pie -fno-stack-protector -Wl,--dynamic-linker=/pwn/ld-2.27.so -Wl,-rpath=/pwn
RUN chmod +x chall

# Secure the flag
RUN chmod 444 flag.txt

# Expose port for netcat connection
EXPOSE 3001

# Start the challenge
CMD socat TCP-LISTEN:3001,reuseaddr,fork EXEC:/pwn/chall