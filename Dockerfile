FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    build-essential \
    socat \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /pwn

# Copy challenge files
COPY chall.c .
COPY flag.txt .

# Build the challenge without PIE, but keeping other protections off
RUN gcc -o chall chall.c -no-pie -fno-stack-protector

# Copy system libc and ld for player download
RUN cp /lib/x86_64-linux-gnu/libc.so.6 /pwn/libc-2.27.so
RUN cp /lib64/ld-linux-x86-64.so.2 /pwn/ld-2.27.so

# Secure the flag
RUN chmod 444 flag.txt
RUN chmod +x chall

# Expose port for netcat connection
EXPOSE 3001

# Start the challenge
CMD socat TCP-LISTEN:3001,reuseaddr,fork EXEC:/pwn/chall