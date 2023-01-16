Codeunit 50130 "FPFrStandardLibrary"
{
    trigger OnRun()
    begin
    end;

    procedure AddCommentSeparator(var AllComments: Text; NewComment: Text; Separator: Text[10])
    begin
        // The function is supposed to append the NewComment to the AllComments variable and thus return it.
        // The comments are separated by the Separator text.
        // More details can be deducted from the test itself.
        // Implement your solution here.

        if StrLen(AllComments) + StrLen(NewComment) + StrLen(Separator) > MaxStrLen(AllComments) then
            exit;
        if StrPos(AllComments, NewComment) > 0 then
            exit;
        if AllComments = '' then begin
            AllComments := NewComment;
            exit;
        end;
        if NewComment = '' then
            exit;

        AllComments := AllComments + Separator + NewComment;
    end;


    procedure EvaluateDateFromXMLDateTime(var Date: Date; ISO8601DateTime: Text): Boolean
    var
        DT: DateTime;
    begin
        // The function is supposed to extract the date from an ISO 8601 DateTime and return it through the Date variable
        // If a valid date was found, the function returns TRUE otherwise FALSE.
        // More details can be deducted from the test itself.
        // Implement your solution here. You can use the TryDmy2Date function below.

        if Evaluate(DT, ISO8601DateTime, 9) then begin
            Date := DT2Date(DT);
            exit(Date > 0D);
        end;

        Date := 0D;
        exit(false);
    end;


    [TryFunction]
    procedure TryDmy2Date(Day: Integer; Month: Integer; Year: Integer; var Date: Date)
    begin
        Date := Dmy2date(Day, Month, Year);
    end;

    procedure Dmy2DateWithDefault(Day: Integer; Month: Integer; Year: Integer; Default: Date) Date: Date
    begin
        if not TryDmy2Date(Day, Month, Year, Date) then
            exit(Default);
    end;

    procedure Hex2Int(Hex: Text) Int: BigInteger
    begin
        // The function is supposed to convert a hex number to an integer.
        // More details can be deducted from the test itself.
        // Implement your solution here.

        if StrLen(Hex) = 0 then
            exit(0); // alternatively through an error
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
                    error('Expeted hex digit to be between 0 and F. Got %1', Hex);
            end;

        exit(Hex2Int(CopyStr(Hex, 1, StrLen(Hex) - 1)) * 16 + Hex2Int(CopyStr(Hex, StrLen(Hex), 1)));
    end;

    [TryFunction]
    procedure TryHex2Int(Hex: Text; var Int: BigInteger)
    begin
        Int := Hex2Int(Hex);
    end;

    procedure Hex2IntWithDefault(Hex: Text; Default: BigInteger) Int: BigInteger
    begin
        if not TryHex2Int(Hex, Int) then
            exit(Default);
    end;

    procedure Int2Hex(Int: BigInteger) Hex: Text
    begin
        // The function is supposed to convert an integer to hexadecimal.
        // More details can be deducted from the test itself.
        // Implement your solution here.

        if Int < 0 then
            exit(''); // alternatively through an error
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

}

