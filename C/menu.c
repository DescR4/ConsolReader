#include "functions.h"

int getMenuChoice(int choice) {
    int keyPressed;

    do {
        system("cls"); //Очистка в Windows
        wprintf(L"\nМеню:\n");
        for (int i = 0; i < 6; i++) {
            if (i == choice) {
                printf("\033[7m"); //Подсветка для выбранного элемента
            }
            switch (i) {
            case 0:
                wprintf(L"0 - Выход из программы\n");
                break;
            case 1:
                wprintf(L"1 - Создание файла для записи разных слов\n");
                break;
            case 2:
                wprintf(L"2 - Очистка содержимого файла с разными словами\n");
                break;
            case 3:
                wprintf(L"3 - Добавление элемента в файл\n");
                break;
            case 4:
                wprintf(L"4 - Удаление элемента\n");
                break;
            case 5:
                wprintf(L"5 - Вывод всех различных слов из файла\n");
                break;
            }
            if (i == choice) {
                printf("\033[0m");  // Сброс к стандартному цвету 
            }
        }
        keyPressed = getch();

        //Управление стрелочками
        switch (keyPressed) {
            case KEY_UP:
                if (choice > 0)
                    choice--;
                break;
            case KEY_DOWN:
                if (choice < 6)
                    choice++;
                break;
        }

    } while (keyPressed != KEY_ENTER);

    return choice;
}
