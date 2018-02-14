program RGR5;{ Исламов Яхья ПС-21
8. В файле записаны фамилии студентов и их анкетные данные.
Организовать  на  основе  хеширования  вспомогательный   файл,
обеспечивающий быстрый поиск информации по указанному студенту
(10).}
const
  max = 100000;
  key = 3;
type
  Student = record
              Name, Group, CheckS: string;
            end;
  textF = File of Student;
var
  F1: text;
  F2: TextF; 
  S: student;
  nameF: string;
  i, g, N, M, L: integer;

procedure FindPrCh(var N: integer; var Check: boolean);{процедура нахождения простого числа} 
var
  i, j, m: integer;
begin
  Check := False;
  for j := 2 to max
  do
    if (n mod j = 0) and (n <> j) 
    then
      begin 
        Check := True;
        break;
      end;
end;

procedure FindM(var L, N: integer); {определение простого числа и определение числа m}
var
  Check: boolean;
  i, g: integer; 
begin
  check := True;
  i := 0;
  while Check
  do
    begin
      FindPrCh(N, Check);
      if Check
      then
        begin
          i := i + 1;
          N := N + i
        end;
    end;
    L := N;
end; 
  
procedure Kesh(var S: string; var KeshN: integer);{функция кеширования}
var
  i, j, stepen, modn, KeyS, count: integer;
begin
  i := length(S);
  stepen := 0;
  keys := 1;
  KeshN := 0;
  modn := 1;
  for count := 1 to i
  do
    modn := modn*2;
  For j := 1 to i
  do
    begin
      for count := 1 to j
      do
        KeyS := Keys * key;
      KeshN := KeshN + ((ord(S[j])*KeyS));
    end;;
end;
  
procedure CreatSp(var F1: text; var F2: TextF; var Ch: char; var N, M, L: integer);  {процедура создания справочника и введения в него фамилий из текстового документа}
var
  NameF1, NameF2: string;
  StudentS, StudentF: Student;
  count, KeshN, k, z, g: integer;
  Check: boolean;
begin
  KeshN := 0;
  writeln('введите название текстового документа из которого будем читать');
  readln(NameF1);
  writeln('введите название типизированного файла ');
  readln(NameF2);
  assign(F2, NameF2);
  assign(F1, NameF1);
  {$I-}
  reset(F1);
  {$I+}
  if IOResult <> 0
  then
    writeln('такого файла не существует');
  count := 0;
  while not EOF(F1)
  do
    begin
      count := count + 1;
      readln(F1)
    end;
  reset(F1);
  rewrite(F2);
  N := count;
  FindM(L, N);
  g := 0;
  while not eof(F1)
  do
    begin
      readln(F1, NameF1);
      StudentS.name := NameF1;
      kesh(NameF1, KeshN);
      readln(F1, NameF1);
      StudentS.Group := NameF1;
      k := KeshN mod L;
      StudentS.CheckS := 'n';
      seek(F2, k);
      z := 1;
      Check := False;
      if Not EOF(F2)
      then
        begin
          read(F2, StudentF);
          if (StudentF.Group <> '') or ((StudentS.CheckS = 'y') and (StudentF.name <> StudentS.name))
          then
            begin
              while (check = False) and (Not EOF(F2))
              do
                begin
                  g := 1; 
                  k := (k + z*z) mod L;
                  seek(F2, k);
                  if not Eof(F2)
                  then
                    read(F2, StudentF);
                  if StudentF.Group <> ''
                  then
                    begin
                      Check := false;
                      z := z + 1;
                    end
                  else
                    begin
                      Check := True;
                      seek(F2, k);
                      write(F2, StudentS);
                      //writeln('нашли новую позицию не дойдя EOF ', k, StudentS.name);
                    end
                end
            end
          else
            begin
              seek(F2, k);
              write(F2, StudentS);
              //writeln('изначально все было хорошо ',k, StudentS.name)
            end
        end
      else
        begin
          seek(F2, k);
          write(F2, StudentS);
          //writeln('сразу EOF ',k, StudentS.name)
        end
    end;
  if (g <> 0) and (EOF(F2))
  then
    begin
      seek(F2, k);
      write(F2, StudentS);
      //writeln('EOF ', k, StudentS.name)
    end;
  Ch := 'n';
end;

procedure SearchStudent(var F2: TextF; var L: integer; var Ch: char);   {процедура поиска студента в справочнике}
var
  s: string;
  k, KeshN, z: integer;
  StudentS: Student;
  Check: boolean;
begin
  reset(F2);
  writeln('введите фамилию студента, которого ищем: ');
  readln(S);
  Kesh(S, KeshN);
  k := KeshN mod L;
  seek(F2, k);
  Check := false;
  z := 0;
  while (not Check) and (not Eof(F2))
  do
    begin
      if not eof(F2)
      then
        read(F2, StudentS);
      if (StudentS.name = S) and (StudentS.CheckS = 'n')
      then
        begin
          writeln(StudentS.Group);
          Check := true;
        end
      else
        if (StudentS.name = S) and (StudentS.CheckS = 'y')
        then
          begin
            writeln('данных не обнаружено');
            Check := true;
          end
        else 
          if (StudentS.name <> S) and ((StudentS.CheckS = 'y') or (StudentS.CheckS = 'n'))
          then
            begin
              z := z + 1;
              k := k + z*z;
              seek(F2, k);
            end;
    end;
    if (Eof(F2)) and (not Check)
    then
      writeln('данных не обнаружено');
  ch := 'n'  
end;   

procedure OpenSp(var F2: textF; var ch: char; var L: integer);   {процедура открытия справочника}
var 
  s: string;
begin
  writeln('введите название справочнка: ');
  readln(s);
  assign(F2, S);
  {$I-}
  reset(F2);
  {$I+}
  if IOResult <> 0
  then
    writeln('такого файла не существует');
  ch := 'n'
end;  

procedure addStudent(var F2: TextF; var Ch: char; var L: integer);      {процедура добавления студента в справочник}
var
  KeshN, k, z, g: integer;
  S: string;
  StudentS, StudentF: Student;
  Check: boolean;
begin
  writeln('введите имя студента ');
  readln(s);
  StudentS.Name := s;
  Kesh(S, KeshN);
  writeln('введите группу студента ');
  readln(S);
  StudentS.Group := s;
  StudentS.CheckS := 'n';
  k := KeshN mod L;
  seek(F2, K);
  z := 1;
  Check := False;
  if Not EOF(F2)
  then
  begin
    read(F2, StudentF);
    if (StudentF.Group <> '') or ((StudentS.CheckS = 'y') and (StudentF.name <> StudentS.name))
    then
      begin
        while (check = False) and (Not EOF(F2))
        do
          begin
            g := 1; 
            k := (k + z*z) mod L;
            seek(F2, k);
            if not Eof(F2)
            then
              read(F2, StudentF);
            if StudentF.Group <> ''
            then
              begin
                Check := false;
                z := z + 1;
              end
            else
              begin
                Check := True;
                seek(F2, k);
                write(F2, StudentS);
                //writeln('нашли новую позицию не дойдя EOF ', k, StudentS.name);
              end
          end
      end
    else
      begin
        seek(F2, k);
        write(F2, StudentS);
        //writeln('изначально все было хорошо ',k, StudentS.name)
      end
  end
  else
    begin
      seek(F2, k);
      write(F2, StudentS);
      //writeln('сразу EOF ',k, StudentS.name)
    end;
  if (g <> 0) and (EOF(F2))
  then
    begin
      seek(F2, k);
      write(F2, StudentS);
      //writeln('EOF ', k, StudentS.name)
    end;
  ch := 'n'
end; 

procedure Name(var F2: TextF; var ch: char);             {процедура сохранения}
var
  newname: string;
begin
  writeln('введите название файла, под которым вы хотите сохранить');
  readln(newname);
  rename(F2, newname);
  ch := 'n'
end;

procedure DelS(var F2: TextF; var Ch: char; var L: integer);     {процедура удаления студента из справочника}
var
  name: string;
  KeshN, K, z, f: integer;
  StudentS: Student;
  Check: boolean;
begin
  writeln('введите имя студента, кооторого хотите удалить из справочника ');
  readln(name);
  Kesh(name, KeshN);
  k := KeshN mod L;
  seek(F2, k);
  f := 0;
  z := 1;
  Check := False;
  if Not EOF(F2)
  then
    begin
      read(F2, StudentS);
      if (StudentS.name <> name)
      then
        begin
          while (check = False) and (Not EOF(F2))
          do
            begin
              f := 1;
              writeln(z); 
              k := (k + z*z) mod L;
              seek(F2, k);
              If not eof(F2)
              then
                read(F2, StudentS);
              if StudentS.name <> name
              then
                begin
                  Check := false;
                  z := z + 1;
                end
              else
                begin
                  Check := true;
                  StudentS.CheckS := 'y';
                  seek(F2, k);
                  //writeln(k);
                  write(F2, StudentS);
                end
            end
        end
      else
        begin
          StudentS.CheckS := 'y';
          seek(F2, k);
          write(F2, StudentS)
        end
    end
  else
    writeln('такого студента нет в справочнике');
  if (f <> 0) and EOF(F2)
  then
    writeln('такого студента нет в справочнике');
  ch := 'n'
end;
  
procedure Menu(var F1: text; var F2: TextF; var N, M, L: integer);
var
  ch: char;
begin
  writeln('введите действие, которое хотите произвести: ');
  writeln('1: создать новый справочник ');
  writeln('2: открыть справочник ');
  writeln('3: справка о студенте ');
  writeln('4: дополнить справку');
  writeln('5: удалить из справки');
  writeln('6: выход ');
  //writeln('6: сохранить справку ');
  readln(ch);
  case ch of
    '1': begin 
           CreatSp(F1, F2, Ch, N, M, L);
           if ch = 'n'
           then
             Menu(F1, F2, N, M, L)
         end;
    '2': begin
           OpenSp(F2, Ch, L);
           if ch = 'n'
           then
             Menu(F1, F2, N, M, L)
         end;
    '3': begin
          SearchStudent(F2, L, Ch);
          if ch = 'n'
          then
            Menu(F1, F2, N, M, L)
        end;
    '4': begin
           addStudent(F2, Ch, L);
           if ch = 'n'
           then
             Menu(F1, F2, N, M, L)
         end;
    '5': begin
           delS(F2, Ch, L);
           if ch = 'n'
           then
             Menu(F1, F2, N, M, L)
         end;
    '6': begin
         end;
    else
      begin
        writeln('неправильный ввод');
        Menu(F1, F2, N, M, L)
      end;
    {'6': begin
           name(F2, Ch);
           if ch = 'n'
           then
             Menu(F1, F2, N, M, L)
         end;}
    end;  
end;
  
begin
  Menu(F1, F2, N, M, L);
end.
