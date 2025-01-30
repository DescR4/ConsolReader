#include "functions.h"

//Определение позиции в файле
void addPosition(WordInfo *wordInfo, int page, int line) {
    WordPosition *new_positions = realloc(wordInfo->positions, (wordInfo->positionCount + 1) * sizeof(WordPosition));
    if (new_positions == NULL) {
        // Обработка ошибки
        wprintf(L"Ошибка выделения памяти.\n");
        return;
    }
    wordInfo->positions = new_positions;
    wordInfo->positions[wordInfo->positionCount].page = page;
    wordInfo->positions[wordInfo->positionCount].line = line;
    wordInfo->positionCount++;
}
