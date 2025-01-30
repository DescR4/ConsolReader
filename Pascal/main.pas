program main;

uses
  crt, Add, Worde, addToFile, Remove, Menu, UniqueWordsModule, Clear, Arguments;

var
  fileName: string;
  fileLines: array of string;
  wordInfoList: array of TWordInfo;
  fileChosen: Boolean;
  selectedIndex: byte;
  outputFileName: string;


begin
  fileChosen := False;
  selectedIndex := 0; // Установим индекс на первый пункт меню
  outputFileName := 'output.txt'; // Установим имя выходного файла по умолчанию
  if ParamCount = 0 then
  begin
    // Выбор файла вручную
    repeat
      clrscr;
      writeln('Введите имя файла:');
      readln(fileName);
      // Очистка буфера ввода
      Flush(input);
      if not FileExists(fileName) then
      begin
        writeln('Файл не найден, попробуйте снова.');
        sleep(2000);
      end
      else
      begin
        fileChosen := True;
        fileLines := Add.ReadFile(fileName);
        if Length(fileLines) > 0 then
        begin
          Worde.ProcessWords(fileLines, wordInfoList);
          Writeln('Файл успешно обработан.');
          Sleep(2000);
          OutputWordList(wordInfoList); // Вывод списка различных слов сразу после обработки файла
          Sleep(2000);
        end
        else
        begin
          Writeln('Ошибка при чтении файла. Пожалуйста, укажите корректное имя файла.');
          fileChosen := False;
        end;
      end;
    until fileChosen;

    // Основное меню
    repeat
      Menu.DisplayMenu(selectedIndex);
      case selectedIndex of
        0: 
          begin
            Writeln('До свидания!');
            Exit;
          end;
        1: CreateUniqueWordsFile(fileName, outputFileName); // Создание файла с уникальными словами
        2: ClearUniqueWordsFile(outputFileName); // Очистка файла с уникальными словами
        3: AppendWordToFile(outputFileName); // Добавление слова в файл
        4: RemoveWordFromFile(outputFileName); // Удаление слова из файла
        5: begin
            if Length(wordInfoList) = 0 then
              Writeln('Сначала выберите файл и обработайте его.')
            else
              OutputWordList(wordInfoList);
          end;
      end;
      Sleep(2000);
      ClrScr;
    until False;
  end
  else
  begin
    ProcessArguments;
  end;
end.
