unit Worde;

interface

type
  // Определяем запись для хранения информации о слове
  TWordInfo = record
    Worde: string[255];
    PageNumbers: array of Integer; // Номера страниц
    LineNumbers: array of Integer; // Номера строк
  end;

procedure ProcessWords(const fileLines: array of string; var wordInfoList: array of TWordInfo);
procedure OutputWordList(const wordInfoList: array of TWordInfo); // Процедура для вывода списка слов с номерами страниц и строк

implementation

// Функция для разделения строки на слова
function SplitString(const s: string): array of string;
var
  i, wordStart, wordLength: Integer;
begin
  SetLength(Result, 0);
  i := 1;
  while i <= Length(s) do
  begin
    // Пропуск пробелов и табуляций
    while (i <= Length(s)) and (s[i] in [' ', #9]) do
      Inc(i); 
    wordStart := i;
    // Поиск конца слова
    while (i <= Length(s)) and not (s[i] in [' ', #9]) do
      Inc(i); // Увеличение индекса, пока текущий символ не пробел или табуляция
    wordLength := i - wordStart; // Длина слова
    if wordLength > 0 then
    begin
      SetLength(Result, Length(Result) + 1); // Увеличение размера массива Result
      Result[High(Result)] := Copy(s, wordStart, wordLength); // Копирование слова в массив Result
    end;
  end;
end;

// Функция для поиска индекса слова в массиве wordInfoList
function FindWordIndex(const worde: string; const wordInfoList: array of TWordInfo): Integer;
var
  i: Integer;
begin
  Result := -1; // Инициализация результата значением -1 (слово не найдено)
  for i := 0 to High(wordInfoList) do // Цикл по всему массиву
  begin
    if wordInfoList[i].Worde = worde then
    begin
      Result := i;
      Break;
    end;
  end;
end;

// Процедура для обработки слов из массива строк и сохранения их
procedure ProcessWords(const fileLines: array of string; var wordInfoList: array of TWordInfo);
var
  i, j: Integer;
  words: array of string; // Объявление массива для хранения слов из строки
  currentWord: string[255]; // Объявление переменной для хранения слова
  lineCount: Integer; // Счетчик строк
begin
  SetLength(wordInfoList, 0); // Инициализация пустого массива
  lineCount := 1;
  for i := 0 to High(fileLines) do // Цикл по всем строкам из входного массива
  begin
    words := SplitString(fileLines[i]); // Разделение строки на слова
    for j := 0 to High(words) do // Цикл по всем словам в строке
    begin
      currentWord := words[j]; // Текущее слово
      // Проверяем, существует ли уже информация о текущем слове в массиве
      var found := False; // Флаг
      for var k := 0 to High(wordInfoList) do // Цикл по всему массиву
      begin
        if wordInfoList[k].Worde = currentWord then
        begin
          // Если слово уже существует, добавляем номера страницы и строки
          SetLength(wordInfoList[k].PageNumbers, Length(wordInfoList[k].PageNumbers) + 1); // Увеличение массива номеров страниц
          wordInfoList[k].PageNumbers[High(wordInfoList[k].PageNumbers)] := (lineCount div 50) + 1; // Добавление номера страницы (каждая 50 строк это новая страница)
          SetLength(wordInfoList[k].LineNumbers, Length(wordInfoList[k].LineNumbers) + 1); // Увеличение массива номеров строк
          wordInfoList[k].LineNumbers[High(wordInfoList[k].LineNumbers)] := lineCount; // Добавление номера строки
          found := True; // Установка флага в попадание
          Break;
        end;
      end;
      // Если слово новое, добавляем его в массив
      if not found then // Если слово не найдено в массиве
      begin
        SetLength(wordInfoList, Length(wordInfoList) + 1); // Увеличение массива
        wordInfoList[High(wordInfoList)].Worde := currentWord; // Добавление текущего слова
        SetLength(wordInfoList[High(wordInfoList)].PageNumbers, 1); // Инициализация массива номеров страниц
        wordInfoList[High(wordInfoList)].PageNumbers[0] := (lineCount div 50) + 1; // Добавление номера страницы (каждая 50 строк это новая страница)
        SetLength(wordInfoList[High(wordInfoList)].LineNumbers, 1); // Инициализация массива номеров строк
        wordInfoList[High(wordInfoList)].LineNumbers[0] := lineCount; // Добавление номера строки
      end;
    end;
    Inc(lineCount); // Увеличение счетчика строк
  end;
end;

// Процедура для вывода списка слов с номерами страниц и строк
procedure OutputWordList(const wordInfoList: array of TWordInfo);
var
  i, j: Integer;
begin
  for i := 0 to High(wordInfoList) do // Цикл по всем элементам массива
  begin
    Write('Слово: ', wordInfoList[i].Worde, ' | Страницы: ');
    for j := 0 to High(wordInfoList[i].PageNumbers) do
    begin
      Write(wordInfoList[i].PageNumbers[j], ' ');
    end;
    Write(' | Строки: ');
    for j := 0 to High(wordInfoList[i].LineNumbers) do
    begin
      Write(wordInfoList[i].LineNumbers[j], ' ');
    end;
    WriteLn; // Переход на новую строку после вывода информации о слове
  end;
end;

end.
