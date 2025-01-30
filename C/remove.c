#include "functions.h"

void generateTempFileName(char *tempFileName) {
    // Генерируем уникальное имя временного файла на основе времени 
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);
    sprintf(tempFileName, "tempfile_%d%d%d%d%d%d", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
}

void removeElementFromFile(const char *filename, const char *element) {
    FILE *file = fopen(filename, "r"); // Открываем файл
    if (file == NULL) {
        wprintf(L"Ошибка открытия файла '%s' для чтения.\n", filename);
        return;
    }

    char tempFileName[100];
    generateTempFileName(tempFileName);

    FILE *tempFile = fopen(tempFileName, "w");// Открытие временного файла для записи
    if (tempFile == NULL) {
        wprintf(L"Ошибка создания временного файла.\n");
        fclose(file);
        return;
    }

    char buffer[100];
    int found = 0;

    //Запись слов в файл
    while (fgets(buffer, sizeof(buffer), file)) { 
        buffer[strcspn(buffer, "\n")] = '\0';
        if (strcmp(buffer, element) != 0) {
            fputs(buffer, tempFile);
            fputs("\n", tempFile);
        } else {
            found = 1;
        }
    }

    fclose(file); // Закрытие основного файла
    fclose(tempFile); // Закрытие временного файла

    // Проверка на возможность удаления оригинального файла
    if (remove(filename) != 0) {
        wprintf(L"Ошибка удаления оригинального файла '%s'.\n", filename);
        remove(tempFileName);
        return;
    }


    // Проверка на возможность удаления временного файла
    if (rename(tempFileName, filename) != 0) {
        wprintf(L"Ошибка переименнования файла '%s'.\n", filename);
        return;
    }

    // Вывод результата
    if (found) {
        wprintf(L"Элемент '%s' удалён из файла '%s' успешно.\n", element, filename);
    } else {
        wprintf(L"Элемент '%s' не найден в файле.'%s'.\n", element, filename);
    }
}