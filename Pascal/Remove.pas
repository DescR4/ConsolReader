unit Remove;

interface

procedure RemoveWordFromFile(const outputFileName: string); // Объявление процедуры для удаления слова из файла

implementation

uses System.IO, System.Text; // Импорт модулей для работы с файлами и кодировкой

procedure RemoveFromFile(const fileName, data: string); // Определение процедуры для удаления строки из файла
var
  reader: StreamReader; // Объявление объекта для чтения файла
  writer: StreamWriter; // Объявление объекта для записи во временный файл
  tempFileName: string; // Объявление переменной для хранения имени временного файла
  line: string; // Объявление переменной для хранения текущей строки из файла
begin
  tempFileName := 'temp.txt'; // Установка имени временного файла
  reader := new StreamReader(fileName, Encoding.Default); // Создание объекта для чтения файла в кодировке UTF-8
  writer := new StreamWriter(tempFileName, false, Encoding.Default); // Создание объекта для записи во временный файл в кодировке UTF-8

  while not reader.EndOfStream do // Цикл продолжается до тех пор, пока не достигнут конец файла
  begin
    line := reader.ReadLine; // Чтение очередной строки из файла
    if line <> data then // Проверка, не совпадает ли текущая строка с удаляемыми данными
      writer.WriteLine(line); // Запись строки во временный файл, если она не совпадает с удаляемыми данными
  end;

  reader.Close;
  writer.Close;

  DeleteFile(fileName); // Удаление исходного файла
  RenameFile(tempFileName, fileName); // Переименование временного файла в имя исходного файла
end;

procedure RemoveWordFromFile(const outputFileName: string); // Определение процедуры для удаления слова из файла
var
  wordToRemove: string; // Объявление переменной для хранения удаляемого слова
begin
  Write('Введите слово для удаления из файла: ');
  ReadLn(wordToRemove); // Чтение введенного слова
  RemoveFromFile(outputFileName, wordToRemove); // Вызов процедуры удаления строки из файла с указанным именем
  Writeln('Слово успешно удалено из файла.');
  ReadLn; // Ожидание ввода для паузы
end;

end.
