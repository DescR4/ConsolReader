unit Menu;

interface

uses crt;

const
  menuItems: array[0..5] of string = (
    '0 - Выход из программы',
    '1 - Создание файла для записи разных слов',
    '2 - Очистка содержимого файла с разными словами',
    '3 - Добавление элемента в файл',
    '4 - Удаление элемента',
    '5 - Вывод всех различных слов из файла'
  );

procedure DisplayMenu(var selectedIndex: byte);

implementation

procedure DisplayMenu(var selectedIndex: byte);
var
  key: char;
  i: integer;
begin
  repeat
    clrscr;
    writeln('Меню:');
    for i := Low(menuItems) to High(menuItems) do
    begin
      if i = selectedIndex then
      begin
        textbackground(LightGray);
        textcolor(Black);
      end
      else
      begin
        textbackground(Black);
        textcolor(White);
      end;
      writeln(menuItems[i]);
      textbackground(Black); // сброс фона на черный после каждой строки
      textcolor(White); // сброс цвета на белый после каждой строки
    end;
    key := ReadKey;
    if key = #0 then
    begin
      key := ReadKey;
      case key of
        #38: // Стрелка вверх
          begin
            if selectedIndex > Low(menuItems) then
              Dec(selectedIndex)
            else
              selectedIndex := High(menuItems);
          end;
        #40: // Стрелка вниз
          begin
            if selectedIndex < High(menuItems) then
              Inc(selectedIndex)
            else
              selectedIndex := Low(menuItems);
          end;
      end;
    end;
  until key = #13; // Enter
end;

end.
