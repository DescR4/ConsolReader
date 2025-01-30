#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <stdio.h>
#include <stdbool.h>
#include <locale.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>
#include <windows.h>
#include <time.h>

//Определение кнопок управления
#define KEY_UP 72
#define KEY_DOWN 80
#define KEY_ENTER 13

#define MAX_WORD_LENGTH 100

static void set_console_encoding() {
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);
}

//Для глобальный перемен страницы и строки
typedef struct {
    int page;
    int line;
} WordPosition;

//Структура для позиции
typedef struct {
    char word[MAX_WORD_LENGTH];
    WordPosition *positions;
    int positionCount;
} WordInfo;

//Проверка открытия файла
bool fileExists(const char* filename);

//Анализ Текста
void analyzeText(const char *filename);

//Создание файла с уникальными словами
void createUniqueWordsFile(const char *input_filename, const char *output_filename);

//Очистка файла
void clearFile(const char *filename);

//Определение позиции слова
void addPosition(WordInfo *wordInfo, int page, int line);

//Добавление элемента
void addElementToFile(const char *filename);

//Удаление элемента
void removeElementFromFile(const char *filename, const char *element);

//Выбор пунктов меню
int getMenuChoice(int currentChoice);

//Функция для ключей доступа
void printUsage();

//Меню
void interactiveMode();

//Функция для работы с командной строкой
void handleCommandLineArgs(int argc, char *argv[]);

#endif