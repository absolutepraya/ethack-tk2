#!/bin/bash
# Create a directory to share with players
mkdir -p attachments

# Copy the binary from the container
docker cp pwn-challenge:/pwn/chall ./attachments/

# Copy the source code and libraries
cp chall.c ./attachments/
cp libc-2.27.so ./attachments/
cp ld-2.27.so ./attachments/

echo "Challenge files prepared in ./attachments/"
echo "Players can now download these files to analyze the challenge"