unit calcs;

{$mode objfpc}

interface

uses
  Classes, SysUtils, Dialogs;


function MakeCode(CharsPerCode: Integer; bULCase, bAvoidChars: Boolean; sCChars: String): String;
function CreateRandomCodes(sAmountStringList,
                           sUniqueStringList,
                           sDashesStringAmount,
                           sCustomChars: String;
                           cbUpperLowerCase,
                           cbIncludeDashes,
                           cbAvoidChars,
                           cbCustomChars: Boolean)
                           : TStringList;



implementation

function MakeCode(CharsPerCode: Integer; bULCase, bAvoidChars: Boolean; sCChars: String): String;

var
  i: integer;
  s, s1, s2: string;
  allchars: string;
  sUpperonly: string;
  sAvoid: string;
  sCustom: string;
  bCustomCharsOn: boolean;
  RemoveDefaultChars:  Set of Char;
  RemoveCustomChars:  Set of Char;
  scan: 1..64; // all chars A-Z,a-z,0-9   (62)
begin

 s[0]:=chr(CharsPerCode);
 if not bAvoidChars then
 begin
     for i:=1 to CharsPerCode do
     repeat
     s[i]:=chr(random(128));
     until
     (s[i] in ['A'..'Z','a'..'z','0'..'9']);
 end else begin
     // RemoveDefaultChars:=['B','8','0','O','o','1','l','i'];
     // RemoveCustomChars:=[sCChars];
     for i:=1 to CharsPerCode do
     repeat
     s[i]:=chr(random(128));
     until
     (s[i] in ['A', 'C'..'N', 'P'..'Z','a'..'k','m'..'n','p'..'z','2'..'9']);
 end;
 if not bULCase then
 begin
   for scan:= 1  to Length(s) Do
   s[scan] := upcase(s[scan]);
 end;
 Result:=s;
end;

function CreateRandomCodes(sAmountStringList,
                           sUniqueStringList,
                           sDashesStringAmount,
                           sCustomChars: String;
                           cbUpperLowerCase,
                           cbIncludeDashes,
                           cbAvoidChars,
                           cbCustomChars: Boolean)
                           : TStringList;
 {Engine for Codes}
var
  AddToMemo: TStringList;
  totalamount: LongInt;
  charspercode: Integer;
  charsperdash: Integer;
  totaldashesrounded: Integer;
  customchars: String;
  sResult: String;
  loop: Integer;
  upperlower: Boolean;
  uniques: String;
  customcharson: Boolean;
  dasheschecked: Boolean;
  avoidcharson: Boolean;
  dashloop: Integer;


begin
 loop:=0;
 dashloop:=0;
 totalamount:=StrToInt(sAmountStringList);
 charspercode:=StrToInt(sUniqueStringList);
 customchars:=sCustomChars;
 uniques:=sUniqueStringList;
 upperlower:=cbUpperLowerCase;
 dasheschecked:=cbIncludeDashes;
 avoidcharson:=cbAvoidChars;
 customcharson:=cbCustomChars;
 if cbIncludeDashes = True then
 begin
   charsperdash:=(StrToInt(sDashesStringAmount));
   charspercode:=charspercode+(round(charspercode/charsperdash)-1);
 end;

// ***get a string of random codes***
 AddToMemo:=TStringList.Create;
 AddToMemo.Clear;
 AddToMemo.Sorted:=False;
 randomize;
 for loop := 1 to totalamount do
  begin
       try
       sResult:=MakeCode(charspercode, upperlower, avoidcharson, customchars);
       // ***add/replace dashes inside string returned if needed***
          if cbIncludeDashes = True then
             begin
                  for dashloop := 1 to (charspercode - 1) do
                    if (dashloop mod (charsperdash+1)) = 0 then
                      sResult[(dashloop)] := '-';
             end;

       AddToMemo.add(sResult);



       except on e: exception do
       showmessage(e.message);
       end;
  end;

//finally
  Result:=AddToMemo;
//  AddToMemo.Free;
 //end;
end;

end.
