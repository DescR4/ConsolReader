unit UniqueWordsModule;

interface

procedure CreateUniqueWordsFile(const inputFileName, outputFileName: string);

implementation

uses
  crt, Worde, Add, System.IO, System.Text;

procedure CreateUniqueWordsFile(const inputFileName, outputFileName: string);
var
  fileLines: array of string; // Объявление массива строк для хранения строк из входного файла
  wordInfoList: array of TWordInfo; // Объявление массива структур для хранения информации о словах
  uniqueWords: array of string; // Объявление массива строк для хранения уникальных слов
  writer: StreamWriter; // Объявление объекта для записи в выходной файл
  worde: string[255]; // Объявление переменной для хранения текущего слова
  isUnique: Boolean; // Объявление переменной для проверки уникальности слова
  i, j: Integer;
begin
  // Чтение входного файла
  fileLines := ReadFile(inputFileName);
  if Length(fileLines) = 0 then
  begin
    Writeln('Ошибка при чтении файла.');
    Exit;
  end;

  // Обработка слов
  ProcessWords(fileLines, wordInfoList);

  // Извлечение уникальных слов
  SetLength(uniqueWords, 0); // Инициализация пустого массива для уникальных слов
  for i := 0 to High(wordInfoList) do // Цикл по всем элементам wordInfoList
  begin
    worde := wordInfoList[i].Worde; // Извлечение текущего слова из wordInfoList
    isUnique := True;
    // Проверка, является ли текущее слово уникальным
    for j := 0 to High(uniqueWords) do // Цикл по всем элементам
    begin
      if worde = uniqueWords[j] then // Если текущее слово уже присутствует
      begin
        isUnique := False; // Флаг переключаем
        Break;
      end;
    end;
    // Если слово уникальное, добавляем его в массив уникальных слов
    if isUnique then
    begin
      SetLength(uniqueWords, Length(uniqueWords) + 1);
      uniqueWords[High(uniqueWords)] := worde; // Добавление текущего слова в массив
    end;
  end;

  // Запись уникальных слов в файл
  writer := new StreamWriter(outputFileName, false, Encoding.Default); // Создание объекта для записи в выходной файл в кодировке UTF-8
  for i := 0 to High(uniqueWords) do // Цикл по всем элементам
  begin
    writer.WriteLine(uniqueWords[i]); // Запись текущего уникального слова в выходной файл
  end;
  writer.Close;

  Writeln('Файл с уникальными словами успешно создан: ', outputFileName);
  ReadLn;
end;

end.
