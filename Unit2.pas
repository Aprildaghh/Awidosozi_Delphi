unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, ClipBrd;

type
  TForm2 = class(TForm)
    generateBtn: TButton;
    Label1: TLabel;
    copyBtn: TButton;
    Label2: TLabel;
    length: TEdit;
    generatedLabel: TLabel;
    errorText: TLabel;
    procedure generateBtnClick(Sender: TObject);
    procedure copyBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lengthKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  newText: string;
  vowels : array[0..4] of char = ('a', 'e', 'i', 'o', 'u');
  notVowels : array[0..21] of char;


implementation

{$R *.dfm}

procedure TForm2.copyBtnClick(Sender: TObject);
begin
  Clipboard.AsText := newText;       // copy the new text to clipboard
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i, j, k : integer;
  contains : boolean;
begin
  k := 0;

  for i := 97 to 122 do
    begin
      contains := false;
      for j := 0 to 4 do
      begin
        if(vowels[j] = char(i)) then
        begin
          contains := true;
          break;
        end;
      end;

      if(contains) then
        continue;

      notVowels[k] := char(i);
      k := k+1;
    end;

end;

procedure TForm2.generateBtnClick(Sender: TObject);
var
  randomIndex, nameLength, i   : integer;
  isVowel   : boolean;
begin
  nameLength := StrToInt(length.Text);   // get the length from user

  { validate the length create an error if there is a problem }
   if nameLength > 16 then
   begin
      errorText.Caption := 'Input too large!';
      errorText.Visible := true;
      Exit;
   end
   else if nameLength <= 0 then
   begin
      errorText.Caption := 'Input is invalid!';
      errorText.Visible := true;
      Exit;     
   end
   else
      errorText.Visible := false;


  { generate random name }
  newText := '';
  isVowel := false;

  for  i := 0 to nameLength-1 do
  begin
    randomize();
    if(isVowel) then
    begin
      randomIndex := random(5);
      newText := newText + vowels[randomIndex]
    end
    else
    begin
      randomIndex := random(21);
      newText := newText + notVowels[randomIndex];
    end;
    isVowel := not isVowel;  
  end;

  { show the random name to user }
  newText[1] := char(integer(newText[1]) - 32);
  generatedLabel.Caption := newText;

end;

procedure TForm2.lengthKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key = 13 ) then
  begin
     generateBtnClick(length);
  end;
  
end;

end.
