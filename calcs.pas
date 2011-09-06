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

 //function CreateRandomCodes(AmountStringList, UniqueStringList: TStringList;
 //        IncludeDashes: Boolean; DashesStringAmount: TStrings) : TStrings;



function MakeCode(CharsPerCode: Integer; bULCase, bAvoidChars: Boolean; sCChars: String): String;

var
  //CharArray: array[1...64] of string;
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
 // defines from call
 // RemoveDefaultChars:=['B','8','0','O','o','1','l','i'];
 // RemoveCustomChars:=[sCChars];
 if not bAvoidChars then
 begin
     for i:=1 to CharsPerCode do
     repeat
     s[i]:=chr(random(128));
     until
     (s[i] in ['A'..'Z','a'..'z','0'..'9']);
 end else begin
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
  //dasheson, avoidchars, customchars: Boolean;
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
//ShowMessage(IntToStr(totalamount));
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
   //showmessage(IntToStr(charspercode));
 end;

// ***Main code call to get a string of random codes***
 AddToMemo:=TStringList.Create;
 AddToMemo.Clear;
 AddToMemo.Sorted:=False;
 randomize;
 for loop := 1 to totalamount do
  begin
       try
       sResult:=MakeCode(charspercode, upperlower, avoidcharson, customchars);
       // ***add/replace dashes inside string returned***
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

   //ShowMessage(sResult);
   //sleep(25);
   //ShowMessage(AddToMemo.Text);

   //AddToMemo.append(sResult);

 //result := TStringList.Create;
 //result.add(AddToMemo.Text);

 //ShowMessage(MakeCode(charspercode, cbUpperLowerCase, cbAvoidChars, customchars));
 //ShowMessage(AddToMemo.Text);
//finally
  Result:=AddToMemo;
//  AddToMemo.Free;
 //end;
//ShowMessage(AddToMemo.Text);
end;






end.

