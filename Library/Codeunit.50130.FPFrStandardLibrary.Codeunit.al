Codeunit 50130 "FPFr Standard Library"
{
    trigger OnRun()
    begin
    end;

    procedure RemoveChar(String: Text; Which: Text): Text
    begin
        exit(DelChr(String, '=', Which))
    end;

    procedure KeepChar(String: Text; Which: Text): Text
    begin
        exit(RemoveChar(String, RemoveChar(String, Which)));
    end;

    procedure MakeDateFilter(StartingDate: Date; EndingDate: Date): Text
    begin
        // No starting date means from the beginning of time and no ending date means till the end of time.
        if (StartingDate = 0D) and (EndingDate = 0D) then
            exit('');
        if StartingDate = 0D then
            exit(StrSubstNo('..%1', EndingDate));
        if EndingDate = 0D then
            exit(StrSubstNo('%1..', StartingDate));
        exit(StrSubstNo('%1..%2', StartingDate, EndingDate));
    end;

    procedure XMLFormat(Value: Variant): Text
    begin
        exit(Format(Value, 0, 9));
    end;

    procedure EvaluateDateTimeFromXML(var FoundDateTime: DateTime; ISO8601DateTime: Text): Boolean
    begin
        if Evaluate(FoundDateTime, ISO8601DateTime, 9) then
            exit(FoundDateTime > 0DT);

        FoundDateTime := 0DT;
        exit(false);
    end;

    procedure EvaluateBooleanFromXML(var FoundBoolean: Boolean; ISO8601Boolean: Text): Boolean
    begin
        if Evaluate(FoundBoolean, ISO8601Boolean, 9) then
            exit(true);

        FoundBoolean := false;
        exit(false);
    end;

    procedure EvaluateIntegerFromXML(var FoundInteger: Integer; ISO8601Integer: Text): Boolean
    begin
        if Evaluate(FoundInteger, ISO8601Integer, 9) then
            exit(true);

        FoundInteger := 0;
        exit(false);
    end;

    procedure EvaluateDecimalFromXML(var FoundDecimal: Decimal; ISO8601Decimal: Text): Boolean
    begin
        if Evaluate(FoundDecimal, ISO8601Decimal, 9) then
            exit(true);

        FoundDecimal := 0;
        exit(false);
    end;

    procedure AddCommentSeparator(var AllComments: Text; NewComment: Text; Separator: Text[10])
    begin
        // The function is supposed to append the NewComment to the AllComments variable and thus return it.
        // The comments are separated by the Separator text.

        if StrPos(AllComments, NewComment) > 0 then
            exit;
        if AllComments = '' then begin
            AllComments := NewComment;
            exit;
        end;
        if NewComment = '' then
            exit;
        if StrLen(AllComments) + StrLen(NewComment) + StrLen(Separator) < MaxStrLen(AllComments) then
            AllComments := AllComments + Separator + NewComment;
    end;

    [TryFunction]
    procedure TryDmy2Date(Day: Integer; Month: Integer; Year: Integer; var NewDate: Date)
    begin
        NewDate := Dmy2date(Day, Month, Year);
    end;

    procedure IsDmyValidDate(Day: Integer; Month: Integer; Year: Integer): Boolean
    var
        NewDate: Date;
    begin
        exit(TryDmy2Date(Day, Month, Year, NewDate))
    end;

    procedure Dmy2DateWithDefault(Day: Integer; Month: Integer; Year: Integer; DefaultDate: Date) NewDate: Date
    begin
        if not TryDmy2Date(Day, Month, Year, NewDate) then
            NewDate := DefaultDate;
    end;


    procedure Hex2Int(Hex: Text) Int: BigInteger
    begin
        // Convert a hex number to an integer.
        if StrLen(Hex) = 0 then
            error('Expeted hex digit to be between 0 and F. Got an empty string.', Hex);
        if StrLen(Hex) > 16 then
            error('Hexadecimal number too big. Maximum 16 digits allowed. Got: %1, length %2.', Hex, StrLen(Hex));
        if StrLen(Hex) = 1 then
            case UpperCase(Hex) of
                '0' .. '9':
                    begin
                        Evaluate(Int, Hex);
                        exit(Int);
                    end;
                'A':
                    exit(10);
                'B':
                    exit(11);
                'C':
                    exit(12);
                'D':
                    exit(13);
                'E':
                    exit(14);
                'F':
                    exit(15);
                else
                    error('Expeted hex digit to be between 0 and F. Got "%1"', Hex);
            end;

        exit(Hex2Int(CopyStr(Hex, 1, StrLen(Hex) - 1)) * 16 + Hex2Int(CopyStr(Hex, StrLen(Hex), 1)));
    end;

    [TryFunction]
    procedure TryHex2Int(Hex: Text; var Int: BigInteger)
    begin
        Int := Hex2Int(Hex);
    end;

    procedure IsHexValue(Hex: Text): Boolean
    var
        Int: BigInteger;
    begin
        exit(TryHex2Int(Hex, Int));
    end;

    procedure Hex2IntWithDefault(Hex: Text; DefaultValue: BigInteger) Result: BigInteger
    begin
        if not TryHex2Int(Hex, Result) then
            if DefaultValue >= 0 then
                Result := DefaultValue
            else
                Result := 0;
    end;

    procedure Int2Hex(Int: BigInteger) Hex: Text
    begin
        // Convert an integer to hexadecimal.
        if Int < 0 then
            error('Expeted number to be positive. Got "%1"', Hex);
        if Int < 16 then
            case Int of
                0 .. 9:
                    exit(Format(Int));
                10:
                    exit('A');
                11:
                    exit('B');
                12:
                    exit('C');
                13:
                    exit('D');
                14:
                    exit('E');
                15:
                    exit('F');
            end;

        exit(Int2Hex(Int div 16) + Int2Hex(Int mod 16));
    end;

    [TryFunction]
    procedure TryInt2Hex(Int: BigInteger; var Hex: Text)
    begin
        Hex := Int2Hex(Int);
    end;

    procedure Int2HexWithDefault(Int: BigInteger; DefaultValue: Text) Result: Text
    begin
        if not TryInt2Hex(Int, Result) then
            if IsHexValue(DefaultValue) then
                Result := DefaultValue
            else
                Result := '0';
    end;

}

