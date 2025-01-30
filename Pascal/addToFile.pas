unit addToFile;

interface

procedure AppendToFile(const fileName, data: string); // Объявление процедуры для добавления данных в файл
procedure AppendWordToFile(const outputFileName: string); // Объявление процедуры для добавления слова в файл

implementation

uses System.IO, System.Text; // Импорт модулей для работы с файлами и кодировкой

procedure AppendToFile(const fileName, data: string);
var
  writer: StreamWriter; // Объявление объекта для записи данных в файл
begin
  writer := new StreamWriter(fileName, true, Encoding.UTF8); // Создание объекта для файла с указанным именем
  writer.WriteLine(data); // Запись строки в файл
  writer.Close; // Закрытие объекта
end;

procedure AppendWordToFile(const outputFileName: string);
var
  wordToAdd: string; // Объявление переменной для слова, которое будет добавлено в файл
begin
  Write('Введите слово для добавления в файл: ');
  ReadLn(wordToAdd); // Чтение введенного слова
  AppendToFile(outputFileName, wordToAdd); // Добавление слова в файл с помощью процедуры
  Writeln('Слово успешно добавлено в файл.');
  ReadLn; // Ожидание нажатия клавиши для паузы перед завершением
end;

end.
