program RGR3(input, output);{Islamov Yahya PS-21         16. «адано бинарное  дерево.  ѕостроить  прошитое   дерево,
соответствующее обходу сверху вниз. —оставить программу удале-
ни€ поддерева с  корнем  в  заданной  вершине  без  повторного
построени€ дерева.  онечное дерево должно оставатьс€ прошитым. 
¬ыдать информацию о нит€х исходного и конечного деревьев (12).}
Type 
  ptr = ^uzel;
  uzel = Record
           Key: char;
           Fath: ptr;
           Check: Boolean;
           Left, Right, LeftTag, RightTag: ptr;
         end;
var
  Head, Body: Ptr;
  F1: Text;
  i: string;
  
procedure CreatTree(var Head: ptr; var F1: Text);    {создание и прошивка дерева с файла}
var
  Kon, Body, zero: ptr;
  i, k, t,g: integer;
  s, r: string;
  ch: char;
  check: boolean;
  Bukva: set of 'A' .. 'z';
begin
  Bukva := ['A' .. 'Z', 'a' .. 'z'];
  g := 0; 
  i := 0;
  k := 0;
  new(Kon);
  Head := Kon;
  Body := Kon;
  readln(F1, s);
  Head^.Key := s[1];
  Head^.LeftTag := Nil;
  Head^.Left := Nil;
  Head^.Right := Nil;
  Head^.Check := True;
  Head^.Fath := Nil;
  while not EOF(F1)
  Do
    begin
      i := 0;
      readln(F1, s);
      g := length(s);
      while s[i+1] = '.'
      do
        i := i + 1;
      if g > i
      then
        R := copy(s, i+1, g-i)
      else
        R := ' ';
      if r[1] in Bukva 
      then
        begin
        ch := R[1];
        end
      else
        begin 
          ch := ' ';
        end;
      if ((i > k) and (ch in Bukva))
      then
        begin
          new(Kon);
          Kon^.LeftTag := Nil;
          Kon^.Fath := Body;
          Kon^.Check := True;
          Kon^.Key := ch;
          Kon^.Left := Nil;
          Kon^.Right := Nil;
          Body^.Left := Kon;
          Body := Body^.Left;
        end
      else
        if (i = k) AND (ch in Bukva)
        then
          begin
            if Body^.Fath <> Nil
            then
              if Body^.Fath^.Right  <> Body
              then
                Zero := Body^.Fath
              else
                Zero := Body
            else
              Zero := Body^.Fath;
            if Zero = Nil
            then
              begin
                New(Kon);
                Kon^.Fath := Body;
                Kon^.Left := Nil;
                Kon^.Key := Ch;
                Kon^.Check := False;
                Kon^.Right := Nil;
                Kon^.LeftTag := Nil;
                Body^.Right := Kon;
                Body := Body^.Right;
              end
            else
              if (Zero <> Nil) And (Zero^.Left = Nil)
              then
                begin
                  New(Kon);
                  Kon^.Fath := Body;
                  Kon^.Key := Ch;
                  Kon^.Left := Nil;
                  Kon^.Check := False;
                  Kon^.Right := Nil;
                  Kon^.LeftTag := Nil;
                  Body^.Right := Kon;
                  Body := Body^.Right;
                end
            else
              if (Zero <> Nil) and (Zero^.Left <> Nil)
              then
                begin
                  New(Kon);
                  Kon^.Fath := Body^.Fath;   
                  Kon^.Left := Nil;
                  Kon^.Check := False;
                  Kon^.Right := Nil;
                  Kon^.Key := ch;
                  Kon^.LeftTag := Body;
                  Body^.Right := Kon;
                  Body := Body^.Fath;
                  Body^.Right := Kon;
                  Body := Body^.Right;
                end
          end
        else
          if ((K > i) and (ch in Bukva))
          then
            begin
              New(Kon);
              Kon^.LeftTag := Body;
              Body^.Right := Kon;
              For t := 0 to k-i do
                Body := Body^.Fath;
              Body^.RightTag := Kon;
              Kon^.Fath := Body;
              Kon^.Key := ch;
              Body^.Right := Kon;
              Body := Body^.Right;
              Body^.Left := Nil;
              Body^.Right := Nil;
            end;         
      k := i;
    end;     
end;

procedure Firmware(Head: ptr);
var
  Kon, Zero, Check: ptr;
begin
Kon := Head;
if (Kon = nil)
then
  writeln('дерева нет')
else
  begin
    while Kon <> Nil
    do
      Begin
        while Kon^.Left <> Nil
        do
          begin
            If Kon^.Fath <> Nil
            then
              begin
                Zero := Kon^.Fath;
                if Zero^.Right <> Nil
                then
                  Kon^.RightTag := Zero^.Right
                else
                  begin
                    while ((Zero^.Right = Nil) and (Zero <> Nil))
                    do
                      Zero := Zero^.Fath;
                    if Zero <> Nil
                    then
                      Kon^.RightTag := Zero^.Right
                  end;
                Kon := Kon^.Left
              end
            else
              Kon := Kon^.Left  
          end;
        If Kon^.Left = Nil
        then
          begin
            If Kon^.Fath <> Nil
            then
              begin
                Zero := Kon^.Fath;
                if Zero^.RightTag <> Nil
                then
                  Kon^.RightTag := Zero^.RightTag;
                Kon := Kon^.Right
              end
            else
              Kon := Kon^.Right          
          end
      end    
  end
end;


procedure RightTreeDel(Kon: ptr);
var
  Zero: ptr;
begin
  if Kon^.LeftTag <> Nil
  then
    Kon^.LeftTag^.Right := Nil;
  Kon^.Fath^.Right := Nil;
  Zero := Kon;
  while Kon <> Nil
  do
    begin
      while Kon^.Left <> Nil
      do
        begin
          Zero := Kon;
          Kon := Kon^.Left;
          Dispose(Zero);
        end;
        if Kon^.Left = Nil
        then
          begin
            Zero := Kon;
            Kon := Kon^.Right;
            Dispose(Zero);
          end;
    end;  
end;

procedure DelLeftSt(Head: ptr);           {удаление с 1 св€зью}
var
  Kon, Zero, CheckFath: ptr;
begin
  writeln;
  Kon := Head;
  if (Kon^.Fath^.Right <> Kon)
  then
    begin
      Zero := Kon^.Fath;
      Zero^.Right := Kon^.Right;
      Zero^.Left := nil;
      CheckFath := Kon^.Right;
      if (Zero <> CheckFath^.Fath)
      then
        CheckFath^.LeftTag := Zero
      else
        CheckFath^.LeftTag := Nil;
      Dispose(Kon);
    end
  else
    RightTreeDel(Kon)
end;

procedure Dell2sv(Head: ptr);              {удаление с 2 св€зами}
var
  Kon, Zero, CheckFath: ptr;
  check: boolean;
begin
  writeln;
  Kon := Head;
  Check := False;
  if Kon^.Right <> Nil
  then
    if Kon^.Right^.leftTag <> Kon
    then
      Check := True;
  if Check = False
  then
    begin
      writeln;
      Zero := Kon^.LeftTag;
      Zero^.Right := Kon^.Right;
      CheckFath := Kon^.Right;
      if CheckFath <> Nil
      then
        CheckFath^.LeftTag := Zero;
      CheckFath := Kon^.Fath;
      CheckFath^.Right := Nil;
      Dispose(Kon)
    end
  else
    RightTreeDel(Kon);
end; 

procedure Dell2SvPoDR(Head: Ptr);         {удаление простых}
var
  Kon, Zero, CheckFath: ptr;
begin
  writeln;
  if (Kon^.Fath^.Right <> Kon)
  then
    begin
      writeln;
      Kon := Head;
      Zero := Kon^.Fath;
      if Zero^.Right <> Nil
      then
        begin
          CheckFath := Kon^.RightTag;
          CheckFath^.LeftTag := Nil;
          Zero^.Left := Nil;
          Dispose(Kon);
        end
      else
        begin
          CheckFath := Kon^.RightTag;
          Zero^.Right := Kon^.RightTag;
          Zero^.Left := Nil;
          CheckFath^.LeftTag := Zero;
          Dispose(Kon)
        end
    end
  else
    RightTreeDel(Kon)
end; 

procedure OsnDel(Head: ptr);   {основное центральное}
var
  Kon, Zero, CheckFath, CheckN: ptr;
begin 
  writeln;
  Kon := Head;
  Zero := Kon^.Fath;
  Zero^.Right := Nil;
  CheckFath := Kon;
  while (CheckFath^.Check = False)
  do
    CheckFath := CheckFath^.Fath;
  Zero := Kon^.LeftTag;
  Zero^.Right := CheckFath^.RightTag;
  CheckFath := Zero^.RIght;
  CheckFath^.LeftTag := Zero;
  Dispose(Kon)
end;

procedure absClear(var Head: ptr);      {удаление отца}
var
  Kon, Zero: ptr;
begin
  Kon := Head;
  if (Kon = nil)
  then
    writeln('дерева нет!')
  else
    begin
      while Kon <> nil
      do
        begin
          while Kon^.Left <> nil
          do
            begin
              Zero := Kon;
              Kon := Kon^.Left;
              Dispose(Zero);
            end;
          if Kon^.Left = nil
          then
            begin
              Zero := Kon;
              Kon := Kon^.Right;
              Dispose(Zero)
            end
        end;
    end;
    Head := Nil;
    writeln
end;

     
procedure DelTree(var Head: ptr); {удаление н-ой вершины дерева}
var
  Kon, Zero, CheckFath: ptr;
  ch: char;
begin
  writeln('напишите им€ вершины');
  readln(ch);
  Kon := Head;
  if ch = Kon^.Key
  then
    AbsClear(Head);
  if (Kon = nil)
  then
    writeln('дерева нет!')
  else
    begin
      while Kon <> Nil
      do
        begin
          while Kon^.Left <> Nil
          do
            begin
              if ((Kon^.Left <> Nil) and (Kon^.LeftTag = Nil) and (Kon^.Key = ch))  
              then
                Dell2SvPoDR(Kon);
              if (((Kon^.Left <> Nil) Or (Kon^.Left = Nil)) and (Kon^.LeftTag <> Nil) and (Kon^.Key = ch))
              then
                OsnDel(Kon);            
              Kon := Kon^.Left
            end;
          if Kon^.Left = Nil
          then
            If ((Kon^.Left = Nil) and (Kon^.LeftTag = Nil) and (Kon^.Key = ch))
              then
                DelLeftSt(Kon)
          else
          If ((Kon^.Left = Nil) and (Kon^.LeftTag <> Nil) and (Kon^.Key = ch))
          then
            Dell2sv(Kon);
          Kon := Kon^.Right
        end
    end  
end;       

procedure PechTree(Head: ptr);  {печать дерева}
var
  Kon: ptr;
begin
  Kon := Head;
  if (Kon = nil)
  then
    writeln('дерева нет!')
  else
    begin
      while Kon <> nil
      do
        begin
          while Kon^.Left <> nil
          do
            begin
              write(Kon^.Key);  
              Kon := Kon^.Left;
            end;
          if Kon^.Left = nil
          then
            begin
              write(Kon^.Key);
              Kon := Kon^.Right;
            end
        end;
    end;
    writeln
end;

procedure PrSvyaz(Head: Ptr);           {печать св€зей}
var
  Kon, Zero, CheckFath: Ptr;
begin
  writeln;
  Kon := Head;
  if (Kon = nil)
  then
    writeln('дерева нет!')
  else
    begin
      while Kon <> nil
      do
        begin
          while Kon^.Left <> nil
          do
            begin
              If Kon^.LeftTag <> Nil
              then
                begin
                  Zero := Kon^.LeftTag;
                  write(Zero^.Key, '-', Kon^.Key, ' ')
                end;
              Kon := Kon^.Left;
            end;
          if Kon^.Left = nil
          then
            begin
              If Kon^.LeftTag <> Nil
              then
                begin
                  Zero := Kon^.LeftTag;
                  write(Zero^.Key, '-', Kon^.Key, ' ')
                end;
              Kon := Kon^.Right;
            end
        end;
    end;
    writeln
end;

procedure PechPoint(Head: ptr);  {вывод точками}
var 
  Kon, zero, CheckFath: Ptr;
  i, j, k: integer;
begin
   writeln;
   i := 0;
   j := 0;
   Kon := Head;
   while (Kon <> Nil)
   do
     begin
       while Kon^.Left <> Nil
       do
         begin
            if kon^.Fath <> Nil
            then
            if (Kon^.LeftTag = Nil) and (Kon^.Fath^.Right = Kon)  
            then
              begin
               for i := 1 to i
               do
                 write('.');
               writeln 
              end;
            for i :=1 to i
            do
              write('.');
            writeln(Kon^.Key);
            i := i + 1;
            Kon := Kon^.Left
         end;
         if Kon^.Left = nil
         then
           Begin
             j := 0; 
             For i := 1 to i
             do
               write('.'); 
               writeln(Kon^.Key);
             if (Kon = Head) and (Kon^.Right <> Nil)
             then
              writeln('.');
             i := i + 1;
             if Kon^.Right <> Nil
             then
             begin
             zero := Kon^.Right;
             CheckFath := Kon;
             Zero := Zero^.Fath;
             while (Zero <> CheckFath) and (CheckFath <> Nil)
             do
               begin
                 j := j + 1;
                 CheckFath := CheckFath^.Fath
               end;
             i := i - j;
             end;
             Kon := Kon^.Right  
           End
     end;
end;

  
Procedure Menu(var Head: ptr);
var
  Ch: char;
begin
  writeln('1: показать нити');
  writeln('2: удалить вершину');
  writeln('3: показать дерево');
  writeln('4: выход');
  readln(Ch);
 case Ch of
 '1':Begin
       PrSvyaz(Head);
       Menu(Head)
     end;
 '2': begin
        DelTree(Head);
        Menu(Head)
      end;
 '3': begin
        PechTree(Head);
        PechPoint(Head);
        Menu(Head)
      end
 end; 
end;  
begin
  writeln('введите название файла, с которого будем читать');
  readln(i);
  assign(F1, i);
  {$I-}
  reset(F1);
  {$I+}
  if IOResult <> 0
  then
    writeln('такого файла не существует');
  CreatTree(Head, F1);
  Firmware(Head);
  //sm(head);
  Menu(Head);
end.

