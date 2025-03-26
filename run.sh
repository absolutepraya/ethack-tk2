#!/bin/bash
echo "Building and starting the pwn challenge container..."
docker-compose down
docker-compose up --build -d
echo "Challenge is running!"
echo "Connect with: nc localhost 3001"
echo "Source code is at: ./chall.c"
echo "Binary can be downloaded using: ./share.sh"