#include "functions.h"

bool fileExists(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (file) {
        fclose(file);
        return true;
    }
    return false;
}

int main(int argc, char *argv[]) {
    system("chcp 1251");
    set_console_encoding();
    setlocale(LC_CTYPE, "Russian_Russia.1251");
    setlocale(LC_ALL, "Russian");

    if (argc == 1) {
        interactiveMode();
    } else {
        handleCommandLineArgs(argc, argv);
    }

    return 0;
}