#include "functions.h"

void interactiveMode() {
    char input_filename[260];
    char output_filename[260];
    char element[100];

    // Вывод сообщения о выборе файла
    wprintf(L"Выбор файла для работы: ");
    fgets(input_filename, 260, stdin);
    // Удаление символа новой строки, если он есть
    size_t len = strlen(input_filename);
    if (len > 0 && input_filename[len - 1] == '\n') {
        input_filename[len - 1] = '\0';
    }

    // Проверка на существование файла
    while (!fileExists(input_filename)) {
        wprintf(L"Файл не найден. Пожалуйста, введите правильный путь к файлу: ");
        fgets(input_filename, 260, stdin);
        len = strlen(input_filename);
        if (len > 0 && input_filename[len - 1] == '\n') {
            input_filename[len - 1] = '\0';
        }
    }

    analyzeText(input_filename);
    Sleep(3000);
    system("cls");

    int choice = 0;
    do {
        choice = getMenuChoice(choice);

        switch (choice) {
            case 1:
                wprintf(L"Выберите название для файла со словами: ");
                scanf("%s", output_filename);
                createUniqueWordsFile(input_filename, output_filename);
                Sleep(3000);
                break;
            case 2:
                clearFile(output_filename);
                Sleep(3000);
                break;
            case 3:
                addElementToFile(input_filename);
                Sleep(3000);
                break;
            case 4:
                wprintf(L"Выберите файл: ");
                scanf("%s", input_filename);
                wprintf(L"Элемент для удаления: ");
                scanf("%s", element);
                removeElementFromFile(input_filename, element);
                Sleep(3000);
                break;
            case 5:
                analyzeText(input_filename);
                Sleep(3000);
                break;
            case 0:
                wprintf(L"Выход из программы.\n");
                Sleep(1000);
                break;
            default:
                wprintf(L"Неправильный выбор. Попробуйте ещё раз.\n");
        }
    } while (choice != 0);
}