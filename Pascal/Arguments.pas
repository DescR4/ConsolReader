unit Arguments;

interface

procedure ProcessArguments;
procedure ShowHelp;

implementation

uses
  crt, Add, Worde, addToFile, Remove, Menu, UniqueWordsModule, Clear;

var
  fileName: string;
  fileLines: array of string;
  wordInfoList: array of TWordInfo;
  fileChosen: Boolean;
  selectedIndex: byte;
  outputFileName: string;

procedure ShowHelp;
begin
  writeln('Использование: программа [опции]');
  writeln('Опции:');
  writeln('  -f <входной файл>    Укажите входной файл');
  writeln('  -o <выходной файл>   Укажите выходной файл');
  writeln('  -a                   Добавить элемент в файл');
  writeln('  -c                   Очистить файл');
  writeln('  -r <элемент>         Удалить элемент из файла');
  writeln('  -u                   Создать файл с уникальными словами');
  writeln('  -h                   Показать это сообщение и выйти');
end;

procedure ProcessArguments;
var
  i: Integer;
  option: string;
begin
  i := 1;
  while i <= ParamCount do
  begin
    option := ParamStr(i);
    if option = '-f' then
    begin
      Inc(i);
      if i <= ParamCount then
        fileName := ParamStr(i)
      else
      begin
        writeln('Ошибка: не указано имя входного файла.');
        Exit;
      end;
    end
    else if option = '-o' then
    begin
      Inc(i);
      if i <= ParamCount then
        outputFileName := ParamStr(i)
      else
      begin
        writeln('Ошибка: не указано имя выходного файла.');
        Exit;
      end;
    end
    else if option = '-a' then
    begin
      AppendWordToFile(outputFileName);
      Exit;
    end
    else if option = '-c' then
    begin
      ClearUniqueWordsFile(outputFileName);
      Exit;
    end
    else if option = '-r' then
    begin
      Inc(i);
      if i <= ParamCount then
        RemoveWordFromFile(outputFileName)
      else
      begin
        writeln('Ошибка: не указано слово для удаления.');
        Exit;
      end;
    end
    else if option = '-u' then
    begin
      CreateUniqueWordsFile(fileName, outputFileName);
      Exit;
    end
    else if option = '-h' then
    begin
      ShowHelp;
      Exit;
    end
    else
    begin
      writeln('Неизвестный ключ: ', option);
      ShowHelp;
      Exit;
    end;
    Inc(i);
  end;
end;
begin
end.