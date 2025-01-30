#include "functions.h"

// Функция для очистки содержимого файла
void clearFile(const char *filename) {
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        wprintf(L"Ошибка открытия файла %s для чтения.\n", filename);
        return;
    }

    fclose(file);

    wprintf(L"Файл %s успешно очищен.\n", filename);
}