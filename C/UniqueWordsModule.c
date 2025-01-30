#include "functions.h"

// Функция для создания файла, содержащего различные слова из заданного файла
void createUniqueWordsFile(const char *input_filename, const char *output_filename) {
    FILE *input_file = fopen(input_filename, "r");
    if (input_file == NULL) {
        wprintf(L"Ошибка открытия файла %s для чтения.\n", input_filename);
        return;
    }

    FILE *output_file = fopen(output_filename, "w");
    if (output_file == NULL) {
        wprintf(L"Ошибка открытия файла %s для чтения.\n", output_filename);
        fclose(input_file);
        return;
    }

    set_console_encoding();

    char word[100];
    char unique_words[100][100];
    int unique_count = 0;

    while (fscanf(input_file, "%s", word) != EOF) {
        int found = 0;
        for (int i = 0; i < unique_count; i++) {
            if (strcmp(unique_words[i], word) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            fprintf(output_file, "%s\n", word);
            strcpy(unique_words[unique_count], word);
            unique_count++;
        }
    }

    fclose(input_file);
    fclose(output_file);

    wprintf(L"Файл %s создан с уникальным именем.\n", output_filename);
}