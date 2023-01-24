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
        exit(strlen(String) = 1);
    end;


    procedure RegexIsCharacterString(String: Text): Boolean
    begin
        case strlen(String) of
            1:
                exit(true);
            2:
                exit(CopyStr(String, 1, 1) = '\');
            else
                exit(false);
        end;
    end;

    procedure RegexCharacterClass(String: Text) Pattern: Text
    begin
        if IsEmptyString(String) then
            exit('');

        exit('[' + String + ']');
    end;

    procedure RegexGroup(String: Text) Pattern: Text
    begin
        if IsEmptyString(String) then
            exit('');

        if StrLen(String) >= 3 then
            if (CopyStr(String, 1, 1) = '(') and (CopyStr(String, StrLen(String), 1) = ')') then
                exit(String);

        exit('(' + String + ')');
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
            RegexIsCharacterString(String):
                exit(String + '?');
            else
                exit(RegexGroup(String) + '?');
        end;
    end;

    procedure RegexZeroOrMore(String: Text) Pattern: Text
    begin
        case true of
            IsEmptyString(String):
                exit('');
            RegexIsCharacterString(String):
                exit(String + '*');
            else
                exit(RegexGroup(String) + '*');
        end;
    end;

    procedure RegexOneOrMore(String: Text) Pattern: Text
    begin
        case true of
            IsEmptyString(String):
                exit('');
            RegexIsCharacterString(String):
                exit(String + '+');
            else
                exit(RegexGroup(String) + '+');
        end;
    end;

    procedure RegexXOrMore(String: Text; Number: Integer) Pattern: Text
    begin
        exit(StrSubstNo('%1{%2,}', String, Number));
    end;

    procedure RegexExactly(String: Text; Number: Integer) Pattern: Text
    begin
        exit(StrSubstNo('%1{%2}', String, Number));
    end;

    procedure RegexInterval(String: Text; Min: Integer; Max: Integer) Pattern: Text
    begin
        exit(StrSubstNo('%1{%2,%3}', String, Min, Max));
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

    procedure RegexPassiveGroup(String: Text) Pattern: Text
    begin
        exit(RegexGroup(StrSubstNo('?:%1', String)));
    end;

    procedure RegexDigit(): Text
    begin
        exit('\d');
    end;

    procedure RegexPlus(): Text
    begin
        exit('\+');
    end;

    procedure RegexDecimalPoint(): Text
    begin
        exit('\.');
    end;

    procedure RegexAnyChar(): Text
    begin
        exit('.');
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
            while (not RegexIsMatch(MatchedString, TotalPattern)) do
                MatchedString := CopyStr(MatchedString, 1, StrLen(MatchedString) - 1);
        end else begin
            String := CopyStr(String, 2);
            PatternPosition(String, Pattern, Position, MatchedString);
            if Position > 0 then
                Position += 1;
        end;
    end;

    procedure EvaluateDateTimeFromXML(var FoundDateTime: DateTime; Iso8601: Text): Boolean
    begin
        exit(Evaluate(FoundDateTime, Iso8601, 9));
    end;

    procedure EvaluateDateTimeZoneFromXML(var FoundDate: Date; var FoundTime: Time; var FoundUtc: Boolean; var FoundNegativeTimeZone: Boolean; var FoundZone: Time; Iso8601: Text) Found: Boolean
    var
        Pattern: Text;
        String: Text;
        Position: Integer;
        MatchedString: Text;
    begin
        FoundDate := 0D;
        FoundTime := 0T;
        FoundZone := 0T;
        FoundUtc := false;

        Pattern := '(\d{4})-(\d{2})-(\d{2})'; // Date
        String := Iso8601;
        PatternPosition(String, Pattern, Position, MatchedString);
        if Position = 1 then begin
            Evaluate(FoundDate, MatchedString, 9);
            String := CopyStr(String, StrLen(MatchedString) + 1);
        end;

        Pattern := 'T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?)'; // Time
        PatternPosition(String, Pattern, Position, MatchedString);
        if Position = 1 then begin
            Evaluate(FoundTime, CopyStr(MatchedString, 2), 9);
            String := CopyStr(String, StrLen(MatchedString) + 1)
        end;

        Pattern := 'Z'; // UTC
        PatternPosition(String, Pattern, Position, MatchedString);
        if Position = 1 then begin
            FoundUtc := true;
        end;

        if Position = 0 then begin
            Pattern := '-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})'; // Time Zone
            PatternPosition(String, Pattern, Position, MatchedString);
            if Position = 1 then begin
                FoundNegativeTimeZone := CopyStr(MatchedString, 1, 1) = '-';
                Evaluate(FoundZone, CopyStr(MatchedString, 2) + ':00', 9);
            end;
        end;

        Pattern := '^(\d{4})-(\d{2})-(\d{2})(T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?))?((-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})|Z)?)$';
        Found := RegexIsMatch(Iso8601, Pattern);
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

