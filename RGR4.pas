program RGR4(input, output);{{������� ���� �� - 21
17. ����������� �������� ������ ���������� �����  ������  �
����������������� �� ����� ����� ��� ���������� (9). }
const
  max = 255;
  min = 1;
  NotRoad = 1000000;
Type
  Graf = array [min .. max, min .. max] of integer;
var
  MatSm: graf;
  F1: text;
  LenGraf: integer;
  k: string;

procedure inicialization(var MatSm: Graf);
var
  i, j: integer;
begin
  For i := min to max
  do
    For j := min to max
    do
      MatSm[i,j] := 0
end;

procedure ReadGraf(var MatSm: Graf; var F1: text; LenGraf: integer);
var
  i, j ,n, z, k, f, s, g: integer;
  check: boolean;
begin
  readln(F1, LenGraf);
  while not Eof(F1)
  do
    begin
      read(F1, n);
      i := n;
      read(F1, n);
      j := n;
      readln(F1, n);
      if i = j
      then
        n := 0;
      MatSm[i, j] := n;
    end;
  For i := min to LenGraf
  do
    For j := min to LenGraf
    do
      if (MatSm[i, j] = 0) and (i <> j)
      then
        MatSm[i, j] := NotRoad;
  writeln('������� �������� ������� �� ������� ���� �������� ���� ');
  readln(k);
  writeln('������� �������� ������� � ������� ����� ������');
  readln(z);
  writeln('��� 0: ');
  writeln;
  for g := 1 to LenGraf
  do
    write('  ', g);
  writeln;
  writeln;
  for i := 1 to LenGraf
  do
    begin
      write(i);
      for j := 1 to LenGraf
      do
        if MatSm[i, j] <> NotRoad
        then
          write(' ',MatSm[i, j], ' ')
        else
          write(' - ');
      writeln
    end;
  writeln;
  For n := min to LenGraf
  do
    begin
      For i := min to LenGraf
      do
        For j := min to LenGraf
        do
          begin
            if (MatSm[i, j]) > (MatSm[i, n] + MatSm[n, j])
            then
              MatSm[i, j] := (MatSm[i, n] + MatSm[n, j]);
          end;
      writeln('��� ', n, ': ');
      writeln;
      check := True;
      for g := 1 to LenGraf
      do
        write('  ', g);
      writeln;
      writeln;
      for s := 1 to LenGraf
      do
        begin
          write(s);
          for f := 1 to LenGraf
          do
              if MatSm[s, f] <> NotRoad
              then
                write(' ',MatSm[s, f], ' ')
              else
                write(' - ');
          writeln;
        end
    end;
  writeln('�� ������� ', k, ' � ������� ', z, ' ����� �������� ���� = ', MatSm[k, z]);
end;

begin
  writeln('������� �������� �����');
  readln(k);
  assign(F1, k);
  {$-}
  reset(F1);
  {$+}
  if IOResult <> 0
  then
    writeln('������ ����� �� ����������');
  inicialization(MatSm);
  ReadGraf(MatSm, F1, LenGraf);
  readln
end.
