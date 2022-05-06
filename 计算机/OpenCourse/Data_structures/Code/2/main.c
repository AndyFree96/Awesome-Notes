#include <stdio.h>

int globalX = 0;

void printFunc(int n){
    if (n > 0){
        printf("%d ", n);
        printFunc(n - 1);
    }
}


int sumFunc(int n){
    if (n > 0) {
        return sumFunc(n - 1) + n;
    }
    return 0;
}



int useStaticFunc(int n){
    static int x = 0;
    if (n > 0) {
        x++;
        return useStaticFunc(n - 1) + x;
    }
    return 0;
}

int useGlobalFunc(int n){
    if (n > 0) {
        globalX++;
        return globalX + useGlobalFunc(n - 1) ;
    }
    return 0;
}

int main() {
    int r = useGlobalFunc(5);
    printf("%d ", r);
    return 0;
}
