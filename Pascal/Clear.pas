unit Clear;

interface

procedure ClearUniqueWordsFile(const outputFileName: string); // Объявление процедуры для очистки содержимого файла

implementation

uses System.IO, System.Text; // Импорт модулей для работы с файлами и кодировкой

procedure ClearUniqueWordsFile(const outputFileName: string);
var
  writer: StreamWriter; // Объявление объекта для записи данных в файл
begin
  // Создание объекта для файла с указанным именем
  // Параметр false указывает на то, что файл будет перезаписан, а не дописан
  writer := new StreamWriter(outputFileName, false, Encoding.Default); 
  writer.Close; // Закрытие объекта StreamWriter
  // Вывод сообщения об успешном очищении файла
  Writeln('Содержимое файла "', outputFileName, '" успешно очищено.'); 
end;

end.
