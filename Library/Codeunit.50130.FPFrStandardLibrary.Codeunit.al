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

    procedure RegexIsMatch(String: Text; Pattern: Text): Boolean
    var
        Regex: Codeunit Regex;
    begin
        exit(Regex.IsMatch(String, Pattern, 0));
    end;

    procedure IsEmptyString(String: Text): Boolean
    begin
        exit(String = '');
    end;

    procedure IsCharacterString(String: Text): Boolean
    begin
        exit(StrLen(String) = 1);
    end;

    procedure RegexCharacterClass(String: Text) Pattern: Text
    begin
        if IsEmptyString(String) then
            exit('');

        exit('[' + String + ']');
    end;

    procedure RegexDisjunction2(String1: Text; String2: Text) Pattern: Text
    begin
        if IsEmptyString(String1) then
            exit(String2);
        if IsEmptyString(String2) then
            exit(String1);

        exit(String1 + '|' + String2);
    end;

    procedure RegexDisjunction3(String1: Text; String2: Text; String3: Text) Pattern: Text
    begin
        if IsEmptyString(String1) then
            exit(RegexDisjunction2(String2, String3));
        if IsEmptyString(String2) then
            exit(RegexDisjunction2(String1, String3));
        if IsEmptyString(String3) then
            exit(RegexDisjunction2(String1, String2));

        exit(String1 + '|' + String2 + '|' + String3);
    end;

    procedure RegexOptional(String: Text) Pattern: Text
    begin
        case true of
            IsEmptyString(String):
                exit('');
            IsCharacterString(String):
                exit(String + '?');
            else
                exit('(' + String + ')?');
        end;
    end;

    procedure RegexZeroOrMore(String: Text) Pattern: Text
    begin
        case true of
            IsEmptyString(String):
                exit('');
            IsCharacterString(String):
                exit(String + '*');
            else
                exit('(' + String + ')*');
        end;
    end;

    procedure RegexOneOrMore(String: Text) Pattern: Text
    begin
        case true of
            IsEmptyString(String):
                exit('');
            IsCharacterString(String):
                exit(String + '+');
            else
                exit('(' + String + ')+');
        end;
    end;

    procedure RegexNegation(String: Text) Pattern: Text
    begin
        if IsEmptyString(String) then
            exit('');

        exit('[^' + String + ']');
    end;

    procedure RegexStartLine(String: Text) Pattern: Text
    begin
        if String = '' then
            exit('^');

        if StrPos(String, '^') = 1 then
            String := CopyStr(String, 2);

        exit('^' + String);
    end;

    procedure RegexEndLine(String: Text) Pattern: Text
    begin
        exit(String + '$');
    end;


    procedure PatternPosition(String: Text; Pattern: Text; var Position: Integer; var MatchedString: Text)
    var
        TotalPattern: Text;
    begin
        Position := 0;
        MatchedString := '';

        if String = '' then
            exit;
        if Pattern = '' then
            exit;

        if RegexIsMatch(String, RegexStartLine(Pattern)) then begin
            Position := 1;
            MatchedString := String;
            TotalPattern := RegexStartLine(RegexEndLine(Pattern));
            while (not RegexIsMatch(MatchedString, TotalPattern)) or not IsEmptyString(MatchedString) do
                MatchedString := CopyStr(MatchedString, 1, StrLen(MatchedString) - 1);
        end else begin
            if StrLen(String) = 1 then
                String := ''
            else
                String := CopyStr(String, 2);
            PatternPosition(String, Pattern, Position, MatchedString);
            if Position > 0 then
                Position += 1;
        end;
    end;

    procedure EvaluateDateTimeFromXMLWithTimeZone(var FoundDateTime: DateTime; var FoundTimeZone: Time; Iso8601: Text): Boolean
    var
        myInt: Integer;
    begin

    end;

    procedure EvaluateDateTimeFromXML(var FoundDateTime: DateTime; Iso8601: Text): Boolean
    begin
        exit(Evaluate(FoundDateTime, Iso8601));
    end;

    procedure EvaluateDateTimeFromXML2(var FoundDateTime: DateTime; Iso8601: Text): Boolean
    var
        DefaultDate: Text;
        DefaultTime: Text;
        DefaultTimeZone: Text;
        DatePattern: Text;
        TimePattern: Text;
        TimeZonePattern: Text;
        FractionsPattern: Text;
        UtcPattern: Text;
        FoundDate: Date;
        FoundTime: Time;
        PositionZ: Integer;
        PositionT: Integer;
    begin
        DefaultDate := '1753-01-01';
        DefaultTime := 'T00:00:00.000';
        DefaultTimeZone := '+00:00';
        FoundDateTime := 0DT;
        // FoundTimeZone := 0T;

        DatePattern := '^(\d{4})-(\d{2})-(\d{2})$';
        TimePattern := '^T(\d{2}):(\d{2}):(\d{2})$';
        TimeZonePattern := '^(-|+)(\d{2}):(\d{2})$';
        FractionsPattern := '^(\.\d*)$';
        UtcPattern := 'Z$'; // Z has to be the last character.

        PositionT := StrPos(Iso8601, 'T');
        PositionZ := StrPos(Iso8601, 'Z');

        if StrLen(Iso8601) >= 10 then
            if not RegexIsMatch(CopyStr(Iso8601, 1, 10), DatePattern) then
                exit(false);



        // 2002-05-30T09:30:10Z
        // 2002-05-30T09:30:10.000-06:00
        // 1234567890123456789012345


        // case CopyStr(Iso8601, 11, 1) of
        //     'Z':
        //         if
        // end;

        //     if Evaluate(FoundDateTime, Iso8601, 9) then
        //         exit(FoundDateTime > 0DT);

        //     FoundDateTime := 0DT;
        // exit(false);

        // if StrLen(Iso8601) =

        // 2002-05-30T09:30:10Z
        // 2002-05-30T09:30:10-06:00
        // 1234567890123456789012345
        //          1         2    2

        // Time ranging from 00:00:00.000 to 23:59:59.999. An undefined or blank time is specified by 0T.
        // Date and time ranging from January 1, 1753, 00:00:00.000 to December 31, 9999, 23:59:59.999. An undefined or blank DateTime is specified by 0DT.
        // Date ranging from January 1, 1753 to December 31, 9999.


        // IF STRLEN(FieldValue) > 16 THEN
        //   FieldValue := COPYSTR(FieldValue,1,16) + ':00';
        // ResultOK := EVALUATE(DateTime,FieldValue,9);
        // IF ResultOK THEN BEGIN
        //   // We ignore TimeZones endings like Z and +01:00 in the DateTime
        //   DateOK := EVALUATE(Date,COPYSTR(FieldValue,1,10),9);
        //   IF STRLEN(FieldValue) = 19 THEN BEGIN
        //     TimeOK := EVALUATE(TimePart,COPYSTR(FieldValue,12,8),9);
        //   END ELSE BEGIN
        //     TimePart := 0T;
        //     TimeOK := TRUE;
        //   END;
        //   ResultOK := DateOK AND TimeOK;
        //   IF ResultOK THEN
        //     DateTime := CREATEDATETIME(Date,TimePart);
        // END;
        // IF NOT ResultOK THEN
        //   ResultOK := EVALUATE(DateTime,FieldValue);
        // IF ResultOK THEN
        //   FieldValue := FORMAT(DateTime,0,DateTimeFormatString);
        // IF ResultOK AND (COPYSTR(FieldValue,1,10) = '9999-12-31') THEN
        //   FieldValue := '';



    end;

    procedure EvaluateBooleanFromXML(var FoundBoolean: Boolean;
            BooleanXML:
                Text):
            Boolean
    begin
        if Evaluate(FoundBoolean, BooleanXML, 9) then
            exit(true);

        FoundBoolean := false;
        exit(false);
    end;

    procedure EvaluateIntegerFromXML(var FoundInteger: Integer; IntegerXML: Text): Boolean
    begin
        if Evaluate(FoundInteger, IntegerXML, 9) then
            exit(true);

        FoundInteger := 0;
        exit(false);
    end;

    procedure EvaluateDecimalFromXML(var FoundDecimal: Decimal; DecimalXML: Text): Boolean
    begin
        if Evaluate(FoundDecimal, DecimalXML, 9) then
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

