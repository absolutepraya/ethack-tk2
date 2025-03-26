#include <stdio.h>
#include <stdlib.h>

char *binsh = "/bin/sh";

void gift(long p1, long p2) { 
    if (p1 == 0x1234567812345678 && p2 == 0x8765432187654321) {
        printf("A random string????: %p\n", binsh); 
    } else if (p1 == 0x1337c0de1337c4f3 && p2 == 0x1337c4f31337c0d3) {
        printf("This might come in handy: %p\n", printf); 
    } 
}

void vuln() {
    char buf[69];
    printf("Tell me something interesting: ");
    gets(buf);
}

int main() {
    setvbuf(stdout, NULL, _IONBF, 0);
    vuln();
    return 0;
}