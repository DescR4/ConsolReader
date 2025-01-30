#include "functions.h"

void handleCommandLineArgs(int argc, char *argv[]) {
    char input_filename[260] = {0};
    char output_filename[260] = {0};
    char element[100] = {0};
    int add_flag = 0, clear_flag = 0, unique_flag = 0, remove_flag = 0;

    // Разбор параметров командной строки
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-f") == 0 && i + 1 < argc) {
            strncpy(input_filename, argv[++i], sizeof(input_filename) - 1);
        } else if (strcmp(argv[i], "-o") == 0 && i + 1 < argc) {
            strncpy(output_filename, argv[++i], sizeof(output_filename) - 1);
        } else if (strcmp(argv[i], "-a") == 0) {
            add_flag = 1;
        } else if (strcmp(argv[i], "-c") == 0) {
            clear_flag = 1;
        } else if (strcmp(argv[i], "-r") == 0 && i + 1 < argc) {
            strncpy(element, argv[++i], sizeof(element) - 1);
            remove_flag = 1;
        } else if (strcmp(argv[i], "-u") == 0) {
            unique_flag = 1;
        } else if (strcmp(argv[i], "-h") == 0) {
            printUsage();
            return;
        } else {
            wprintf(L"Неверный параметр: %s\n", argv[i]);
            printUsage();
            return;
        }
    }

    // Проверка на существование файла, если указан входной файл
    if (input_filename[0] != '\0' && !fileExists(input_filename)) {
        wprintf(L"Файл не найден: %s\n", input_filename);
        return;
    }

    if (add_flag) {
        addElementToFile(input_filename);
    } else if (clear_flag) {
        if (output_filename[0] == '\0') {
            wprintf(L"Введите название выходного файла: ");
            fgets(output_filename, sizeof(output_filename), stdin);
            output_filename[strcspn(output_filename, "\n")] = '\0';
        }
        clearFile(output_filename);
    } else if (unique_flag) {
        if (output_filename[0] == '\0') {
            wprintf(L"Введите название выходного файла: ");
            fgets(output_filename, sizeof(output_filename), stdin);
            output_filename[strcspn(output_filename, "\n")] = '\0';
        }
        createUniqueWordsFile(input_filename, output_filename);
    } else if (remove_flag) {
        if (element[0] == '\0') {
            wprintf(L"Введите элемент для удаления: ");
            fgets(element, sizeof(element), stdin);
            element[strcspn(element, "\n")] = '\0';
        }
        removeElementFromFile(input_filename, element);
    } else {
        analyzeText(input_filename);
    }
}