#include "functions.h"

//Добавление элементов в файл
void addElementToFile(const char *filename) {
    FILE *file = fopen(filename, "a");

    if (file == NULL) {
        wprintf(L"Ошибка открытия файла.\n");
        return;
    }

    char word[100];
    wprintf(L"Введите новое слово: ");
    scanf("%s", word);
    fprintf(file, "%s\n", word);
    fclose(file);

    wprintf(L"Элемент успешно добавлен.\n");
}