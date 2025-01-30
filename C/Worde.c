#include "functions.h"

void analyzeText(const char *filename) { 
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        wprintf(L"Ошибка открытия файла.\n");
        return;
    }

    char word[MAX_WORD_LENGTH];
    WordInfo *words = NULL;
    int wordCount = 0;
    int page = 1, line = 1;

    while (fgets(word, MAX_WORD_LENGTH, file) != NULL) {
        // Разделяем строку на слова
        char *token = strtok(word, " \t\n\r\f");
        while (token != NULL) {
            int i;
            for (i = 0; i < wordCount; i++) {
                if (strcmp(words[i].word, token) == 0) {
                    addPosition(&words[i], page, line);
                    break;
                }
            }

            if (i == wordCount) {
                words = realloc(words, (wordCount + 1) * sizeof(WordInfo));
                strcpy(words[wordCount].word, token);
                words[wordCount].positions = NULL;
                words[wordCount].positionCount = 0;
                addPosition(&words[wordCount], page, line);
                wordCount++;
            }

            token = strtok(NULL, " \t\n\r\f");
        }

        // Переход на новую строку
        line++;

        // Проверка на переход на новую страницу
        if (strchr(word, '\f') != NULL) {
            page++;
            line = 1;
        }
    }

    fclose(file);

    wprintf(L"Список всех различных слов и их позиции:\n");
    for (int i = 0; i < wordCount; i++) {
        set_console_encoding();
        wprintf(L"Слово: %s | ", words[i].word);
        for (int j = 0; j < words[i].positionCount; j++) {
            wprintf(L"Страница %d | строка %d\n", words[i].positions[j].page, words[i].positions[j].line);
        }
    }

    for (int i = 0; i < wordCount; i++) {
        free(words[i].positions);
    }
    free(words);
}
