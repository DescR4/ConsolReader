unit Add;

interface

function ReadFile(const fileName: string): array of string; // Объявление функции для чтения файла и возвращения его содержимого в виде массива строк

implementation

uses System.IO, System.Text, crt; // Импорт модулей  для работы с файлами и кодировкой

function ReadFile(const fileName: string): array of string;
var
  fileLines: array of string; // Объявление массива строк для хранения содержимого файла
  reader: StreamReader; // Объявление объекта для чтения файла
  line: string; // Объявление переменной для хранения текущей строки файла
  lineIndex: Integer; // Объявление переменной для индексации строк в массиве
begin
  reader := new StreamReader(fileName, Encoding.Default); // Создание объекта для чтения файла с указанным именем
  lineIndex := 0; // Инициализация индекса строки
  while not reader.EndOfStream do
  begin
    line := reader.ReadLine; // Чтение очередной строки файла
    SetLength(fileLines, lineIndex + 1); // Увеличение размера массива строк на 1
    fileLines[lineIndex] := line; // Запись строки в массив строк
    Inc(lineIndex); // Увеличение индекса строки
  end;
  reader.Close; // Закрытие объекта
  Result := fileLines; // Возвращение массива строк в качестве результата функции
end;

end.
