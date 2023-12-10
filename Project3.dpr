program Project3;

{$APPTYPE CONSOLE}
{$R *.res}

uses
    System.SysUtils,
    Classes;

Type
    TWordsArr = Array Of String;
    TPosArr = Array Of Integer;

Function CheckWordsEquality(Const WordFromData, InputedWord: String): Boolean;
Var
    I, Pos: Integer;
Begin
    Pos := Length(InputedWord) + 1;
    For I := 1 To Length(WordFromData) Do
    Begin
        If Not(WordFromData[I] = InputedWord[Pos - I]) Then
        Begin
            CheckWordsEquality := False;
            Exit();
        End;
    End;
    CheckWordsEquality := True;
End;

Function FindWordPos(Const Arr: TWordsArr; InputedWord: String): Integer;
Var
    I: Integer;
Begin
    for I := Low(Arr) to High(Arr) do
    Begin
        if CompareText(Arr[I], InputedWord) = 0 then
        Begin
            FindWordPos := I;
            Exit();
        End;
    End;
    FindWordPos := -1;
End;

Function CheckWordsExistanceInArr(Const Arr, InputedWords: TWordsArr): Boolean;
Var
    I: Integer;
Begin
    for I := Low(InputedWords) to High(InputedWords) do
    Begin
        if FindWordPos(Arr, InputedWords[I]) = -1 then
        Begin
            CheckWordsExistanceInArr := False;
            Exit;
        End;
    End;
    CheckWordsExistanceInArr := True;
End;

Function ReadWordsFromFile(const FileName: string): TStringList;
var
    F: TextFile;
    S: string;
    Words: TStringList;
begin
    Words := TStringList.Create;
    AssignFile(F, FileName);
    Reset(F);
    while not Eof(F) do
    begin
        ReadLn(F, S);
        Words.Add(S);
    end;
    CloseFile(F);
    Result := Words;
end;

Function GetRandomWord(Words: TStringList): string;
var
    Index: Integer;
begin
    Index := Random(Words.Count);
    Result := Words[Index];
end;

Var
    WordsFromData, InputedWords: TWordsArr;
    FileNames: array [0 .. 3] of string = (
        'words-5.txt',
        'words-6.txt',
        'words-7.txt',
        'words-8.txt'
    );
    Words: TStringList;
    RandomWord: string;
    I, j, correctAnswers: Integer;

Begin
    // Initialize
    Randomize;
    correctAnswers := 0;

    // Etap 1
    for I := 0 to 3 do
    begin
        Words := ReadWordsFromFile(FileNames[I]);
        for j := 1 to 3 do
        begin
            RandomWord := GetRandomWord(Words);
            Writeln('Введите это слово в обратном порядке:');
            ReadLn(InputedWords[0]);
            if CheckWordsEquality(RandomWord, InputedWords[0]) then
            begin
                Writeln('ОТВЕТ ВЕРНЫЙ!');
                Inc(correctAnswers);
            end
            else
            begin
                Writeln('ОТВЕТ НЕВЕРНЫЙ!');
                correctAnswers := 0;
            end;
            if correctAnswers = 3 then
                break;
        end;
        if correctAnswers < 3 then
            break;
    end;

    // Reset for next stage
    correctAnswers := 0;

    // Etap 2
    // ... Similar structure as Etap 1, but with CheckWordsExistanceInArr instead of CheckWordsEquality

    // Etap 3
    // ... Similar structure as Etap 2, but checks for exact sequence match

    // Etap 4
    // ... Similar structure as Etap 1, but user inputs reversed words

    // Etap 5
    // ... Similar structure as Etap 4, but checks for exact reversed sequence match

    ReadLn;

End.
