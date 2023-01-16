Codeunit 50133 "FPFr Test Hex Int Conversion"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit FPFrStandardLibrary;

    trigger OnRun()
    begin
        // [FEATURE] Converting hexadecimal to integer
        // [FEATURE] Converting integer to hexadecimal
    end;

    [Test]
    procedure TestSimpleInt2Hex01()
    var
        Int: Integer;
        Hex: Text;
    begin
        Int := 15;
        Hex := 'F';
        if not (FPFrStandardLibrary.Int2Hex(Int) = Hex) then
            Error('Expected: int2hex("%1") = %2', Int, Hex);
    end;

    [Test]
    procedure TestSimpleInt2Hex02()
    var
        Int: Integer;
        Hex: Text;
    begin
        Int := 255;
        Hex := 'FF';
        if not (FPFrStandardLibrary.Int2Hex(Int) = Hex) then
            Error('Expected: int2hex("%1") = %2', Int, Hex);
    end;

    [Test]
    procedure TestSimpleHex2Int03()
    var
        Int: Integer;
        Hex: Text;
    begin
        Int := 15;
        Hex := 'F';
        if not (int = FPFrStandardLibrary.Hex2Int(Hex)) then
            Error('Expected: hex2int("%1") = %2', Hex, Int);
    end;

    [Test]
    procedure TestSimpleHex2Int04()
    var
        Int: Integer;
        Hex: Text;
    begin
        Int := 255;
        Hex := 'FF';
        if not (int = FPFrStandardLibrary.Hex2Int(Hex)) then
            Error('Expected: hex2int("%1") = %2', Hex, Int);
    end;

    [Test]
    procedure TestRandomDouble05()
    var
        Int: Integer;
        ExpectedInt: Integer;
        I: Integer;
    begin
        for I := 1 to 100000 do begin
            Int := Random(999999999);
            ExpectedInt := FPFrStandardLibrary.Hex2Int(FPFrStandardLibrary.Int2Hex(Int));
            if not (ExpectedInt = Int) then
                Error('Expected: converting "%1" to hex and back should result in the original value. Got %2', Int, ExpectedInt);
        end;
    end;

    [Test]
    procedure TestRandomTrible06()
    var
        Int: Integer;
        Hex: Text;
        ExpectedHex: Text;
        I: Integer;
    begin
        for I := 1 to 100000 do begin
            Int := Random(999999999);
            Hex := FPFrStandardLibrary.Int2Hex(Int);
            ExpectedHex := FPFrStandardLibrary.Int2Hex(FPFrStandardLibrary.Hex2Int(Hex));
            if not (ExpectedHex = Hex) then
                Error('Expected: converting "%1" to int and back should result in the original value. Got %2', Hex, ExpectedHex);
        end;
    end;

    [Test]
    procedure Test15hexdigits07()
    var
        Int: BigInteger;
        Hex: Text;
        ExpectedHex: Text;
        I: Integer;
        J: Integer;
    begin
        for I := 1 to 15 do begin
            Int := 1;
            for J := 1 to i do
                Int := Int * 16;
            Int := Int - 1;
            Hex := FPFrStandardLibrary.Int2Hex(Int);
            ExpectedHex := PadStr('', I, 'F');
            if not (ExpectedHex = Hex) then
                Error('Expected: (16^%1)-1 should result in F %1 times. Got "%2" <> "%3"', I, Hex, ExpectedHex);
        end;
    end;

    [Test]
    procedure TestMaxBigInteger08()
    var
        Int: BigInteger;
        Hex: Text;
        ExpectedHex: Text;
    begin
        Int := 9223372036854775807L;
        Hex := FPFrStandardLibrary.Int2Hex(Int);
        ExpectedHex := PadStr('7', 16, 'F');
        if not (ExpectedHex = Hex) then
            Error('Expected: int2hex %1 should result in %3 (%5). Got %2 (%4)', Int, Hex, ExpectedHex, StrLen(Hex), StrLen(ExpectedHex));
    end;

    [Test]
    procedure TestNegativeNumber2Hex09()
    var
        Int: BigInteger;
        Hex: Text;
        ExpectedHex: Text;
    begin
        Int := -1;
        Hex := FPFrStandardLibrary.Int2Hex(Int);
        ExpectedHex := '';
        if not (ExpectedHex = Hex) then
            Error('Expected: int2hex %1 should result in the empty string. Got "%2"', Int, Hex);
    end;

    [Test]
    procedure TestHex2IntIncorrectString10()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        Hex := 'ABCDEFG';
        if FPFrStandardLibrary.TryHex2Int(Hex, Int) then
            Error('I expected the hex2int("%1") to fail, but it returned %2', Hex, Int);
    end;

    [Test]
    procedure TestHex2IntIncorrectString11()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        Hex := 'ABZDE';
        if FPFrStandardLibrary.TryHex2Int(Hex, Int) then
            Error('I expected the hex2int("%1") to fail, but it returned %2', Hex, Int);
    end;

    [Test]
    procedure TestSTXkey2Property()
    var
        Int: BigInteger;
        ExpectedInt: BigInteger;
    begin
        // This is a line from the fin.stx file.
        // 00033-00181-030-0: CaptionML

        // You notice the first part: 00033-00181
        // Let us convert each of the two numbers to HEX put it together and reconvert it to INTEGER
        // It should become 8629. That is a Property Number.

        // This is a line from the Translation file
        // T3-P8629-A1033-L999:Payment Terms
        // So now we know that "Payment Terms" is the CaptionML (ENU) of Table 3.

        Int := FPFrStandardLibrary.Hex2Int(FPFrStandardLibrary.Int2Hex(33) + FPFrStandardLibrary.Int2Hex(181));
        ExpectedInt := 8629;
        if not (Int = ExpectedInt) then
            Error('I expeced to get %1 when converting 00033-00181. I got %2', ExpectedInt, Int);
    end;
}

