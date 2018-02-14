program RGR2(input, output); {Islamov Yahya PS-21  Организовать  в основной  памяти  с помощью указателей
очередь  из  стеков. Обеспечить  операции  ведения  стека  из
начала  очереди, дополнения  и  продвижения  очереди,  выдачи
содержимого очереди (9).}
type
  UkazS = ^Stack;
  Stack = record 
            Name: string;
            NextS: UkazS;
          end;
  UkazQ = ^Que;
  Que = record
          TopS: UkazS;
          NextQ: UkazQ;
        end;
var
  BegQ, KonQ, Last: UkazQ;
Procedure PurgeStack(var BegQ: UkazQ); {процедура очищения стека}
var
  KonS, Top: UkazS;
begin
  Top := BegQ^.TopS;
  if Top = Nil
  then 
    writeln('попытка удаление из пустого стека!')
  else
    while Top <> Nil
    do
      begin 
        KonS := Top;
        Top := Top^.NextS;
        dispose(KonS)
      end
end;

Procedure DelFromStack(var BegQ: UkazQ);{удаление одного элемента из стека}
var
  KonS, Top: UkazS;
begin
  Top := BegQ^.TopS;
  if Top = Nil
  then 
    writeln('попытка удаление из пустого стека!')
  else
    begin
      KonS := Top;
      Top := Top^.NextS;
      dispose(KonS);
      BegQ^.Tops := Top
    end
end;

Procedure AddEl(var KonQ: UkazQ); {добавление элементов в стек}
var
  Top, Kon: UkazS;
  Rname: string;
  B: boolean;
begin
  B := true;
  Top :=  nil;
  while B
  do
    begin
      writeln('введите очередной элемент');
      readln(Rname);
      if (Rname = 'End')
      then
        begin
          KonQ^.TopS := Top;
          B := false
        end
      else
        begin
          New(Kon);
          Kon^.NextS := Top;
          Kon^.Name := Rname;
          Top := Kon;
        end
    end
end;    

Procedure AddElToBg(var BegQ: UkazQ); {добавление элементов в стек от начала}
var
  Top, Kon: UkazS;
  Rname: string;
  B: boolean;
begin
  B := true;
  Top :=  nil;
  if BegQ <> nil
  then
  begin
    while B
    do
      begin
        writeln('введите очередной элемент');
        readln(Rname);
        if (Rname = 'End')
        then
          begin
            BegQ^.TopS := Top;
            B := false
          end
        else
          begin
            New(Kon);
            Kon^.NextS := Top;
            Kon^.Name := Rname;
            Top := Kon;
          end
      end
    end
  else
    writeln('очередь не создана');
end;    


Procedure OrgEmptStack(var BegQ, KonQ: UkazQ);  {организация очереди с пустым стеком}
var
  Last: UkazQ;
  Ch: char;
begin
  new(Last);
  If (BegQ = nil)
  then
    begin
      Last^.TopS := nil;
      BegQ := Last;
      BegQ^.NextQ := nil;
      KonQ := Last;
    end
  else
    begin
      KonQ^.NextQ := Last;
      Last^.TopS := nil;
      Last^.NextQ := nil;
      KonQ := Last  
    end;
end; 

Procedure OrgStackWithElements(var BegQ, KonQ: UkazQ);  {организация ячейки очереди со стеком и ее заполнение}
var 
  KonS: UkazS;
  Last: UkazQ;
begin
  new(Last);
  If (BegQ = nil)
  then
    begin
      BegQ := Last;
      KonQ := Last;
      writeln('вводите элементы стека(словом "End" вы завершите его заполнение)');
      AddEl(KonQ);
      KonQ^.NextQ := nil;
    end
  else
    begin
      Last^.NextQ := nil;
      KonQ^.NextQ := Last;
      KonQ := Last;
      writeln('вводите элементы стека(словом "End" вы завершите его заполнение)');
      AddEl(KonQ);
    end  
end;

Procedure PromQ(var BegQ: UkazQ); {продвижение очереди}
var
  Kon: UkazQ;
begin
  if BegQ = nil
  then
    writeln('пустая очередь!')
  else
    begin
      PurgeStack(BegQ);
      Kon := BegQ;
      dispose(Kon);
      BegQ := BegQ^.NextQ
    end  
end;

Procedure Out(var BegQ: UkazQ);  {выдача очереди}
var
  Top: UkazS;
  Kon: UkazQ;
begin
  Kon := BegQ;
  Top := BegQ^.TopS;
  if Kon = nil
  then
    writeln('очередь пуста')
  else
    begin
      while Kon <> nil
      do
        begin
          if Top = nil
          then
            begin
              write('стек пуст');
              Kon := Kon^.NextQ;
              if Kon <> nil
              then
                Top := Kon^.TopS;
            end
          else
            begin
              while Top <> nil
              do
                begin
                  write(Top^.Name, ' ');
                  Top := Top^.NextS
                end;
              Kon := Kon^.NextQ;
              if Kon <> nil
              then
                Top := Kon^.TopS;
            end;
        writeln
        end
    end
end;

Procedure StackFromBgQue(var BegQ: UkazQ); {стек от начала}
var
  Con: UkazQ;
  Top: UkazS;
begin
  Con := BegQ;
   
end;

Procedure FromStartQue(var BegQ: UkazQ; Var Variant2: char);
begin
  writeln('Выберите нужный вариант');
  writeln('1: Добавить эелемент в стек');
  writeln('2: Удалить эелемент из стека');
  writeln('3: очистить стек');
  writeln('4: вернуться в меню');
  readln(Variant2);
  case Variant2 of 
  '1':begin
        AddElToBg(BegQ);
        writeln;
        FromStartQue(BegQ, Variant2)
      end;
  '2':begin
        DelFromStack(BegQ);
        writeln;
        FromStartQue(BegQ, Variant2)
      end;
  '3':begin
        PurgeStack(BegQ);
        writeln;
        FromStartQue(BegQ, Variant2)
      end;
  '4': Variant2 := 'M';
    end;
end;

Procedure Menu(var BegQ, KonQ: UkazQ); {пункты меню для пользователя}
var
  Variant, Variant2: char;
  B: Boolean;
begin
Variant := ' ';
B := true;
while ((Variant > '5') or (Variant < '1') and B)
do
  begin
    writeln('Выберите нужное вам действие');
    writeln('1: Добавить элемент в очередь');
    writeln('2: продвижение очереди');
    writeln('3: Вывод очереди');
    writeln('4: Стек из начала очереди');
    writeln('5: конец');
    readln(Variant);
    case Variant of
      '1': begin
             writeln('выберите нужное вам действие:');
             writeln('1: Оргиназиовать ячейку очереди с пустым стеком');
             writeln('2: организовать  ячейку очериди со стеком и заполнять ее');
             writeln('3: вернуться в меню');
             readln(Variant2);
             case Variant2 of
             '1': begin 
                    OrgEmptStack(BegQ, KonQ);
                    Menu(BegQ, KonQ)
                  end;
             '2':begin
                   OrgStackWithElements(BegQ, KonQ);
                   Menu(BegQ, KonQ)  
                 end;
             '3': begin
                    Menu(BegQ, KonQ)
                  end;
              end;
           end;
      '2': begin
             PromQ(BegQ);
             writeln;
             Menu(BegQ, KonQ)  
           end;
      '3':begin
            Out(BegQ);
            writeln;
            Menu(BegQ, KonQ)
          end;
      '4':begin
            Variant2 := ' ';
             FromStartQue(BegQ, Variant2);
             if (Variant2 = 'M')
             then
               begin
                 writeln;
                 Menu(BegQ, KonQ)
               end  
          end;       
      '5': B := false;
    end
  end
end;

begin
  BegQ := nil;
  Menu(BegQ, KonQ)
end.
