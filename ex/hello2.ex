#include <stdio.h>

int main(int nEtp, char** nEtI) {
    for (int v=0; v<nEtp; ++v)
        printf( "%d: %s", nEtp, nEtI[v] );
    puts( "Hello, world!" );
    char* F = L"nop";
    return 0;
}
