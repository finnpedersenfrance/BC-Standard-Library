namespace FinnPedersenFrance.Tools.Library;

codeunit 50133 "Test Hex Int Conversion"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

    trigger OnRun()
    begin
        // [FEATURE] Converting between integer to hexadecimal
    end;

    [Test]
    procedure TestSimpleInt2Hex01()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #001] Small int to hex.
        // [GIVEN] 15
        // [WHEN] converting
        // [THEN] The resulting string is F.

        Int := 15;
        Hex := 'F';
        Assert.AreEqual(Hex, StandardLibrary.Int2Hex(Int), '');
    end;

    [Test]
    procedure TestSimpleInt2Hex02()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #002] Small int to hex.
        // [GIVEN] 255
        // [WHEN] converting
        // [THEN] The resulting string is FF.

        Int := 255;
        Hex := 'FF';
        Assert.AreEqual(Hex, StandardLibrary.Int2Hex(Int), '');
    end;

    [Test]
    procedure TestSimpleHex2Int03()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #003] Small hex to int.
        // [GIVEN] F
        // [WHEN] converting
        // [THEN] The resulting string is 15.

        Int := 15;
        Hex := 'F';
        Assert.AreEqual(Int, StandardLibrary.Hex2Int(Hex), '');
    end;

    [Test]
    procedure TestSimpleHex2Int04()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #004] Small hex to int.
        // [GIVEN] FF
        // [WHEN] converting
        // [THEN] The resulting string is 255.

        Int := 255;
        Hex := 'FF';
        Assert.AreEqual(Int, StandardLibrary.Hex2Int(Hex), '');
    end;

    [Test]
    procedure TestRandomDouble05()
    var
        ExpectedInt: BigInteger;
        Int: BigInteger;
        I: Integer;
    begin
        // [SCENARIO #005] Ensure that Int2Hex is the inverse function of Hex2Int.
        // [GIVEN] 10.000 random integers
        // [WHEN] converting them to hex and back to integer.
        // [THEN] We get the same value.

        for I := 1 to 10000 do begin
            Int := Random(999999999);
            ExpectedInt := StandardLibrary.Hex2Int(StandardLibrary.Int2Hex(Int));
            Assert.AreEqual(ExpectedInt, Int, 'Converting any integer to hex and back should result in the original value.');
        end;
    end;

    [Test]
    procedure TestRandomTrible06()
    var
        Int: BigInteger;
        I: Integer;
        ExpectedHex: Text;
        Hex: Text;
    begin
        // [SCENARIO #006] Ensure that Hex2Int is the inverse function of Int2Hex.
        // [GIVEN] 10.000 random hexadecimal numbers.
        // [WHEN] converting them to hex and back to integer.
        // [THEN] We get the same value.

        for I := 1 to 10000 do begin
            Int := Random(999999999);
            Hex := StandardLibrary.Int2Hex(Int);
            ExpectedHex := StandardLibrary.Int2Hex(StandardLibrary.Hex2Int(Hex));
            Assert.AreEqual(ExpectedHex, Hex, 'Converting any hex value to integer and back should result in the original value.');
        end;
    end;

    [Test]
    procedure Test15hexdigits07()
    var
        Int: BigInteger;
        I: Integer;
        J: Integer;
        ExpectedHex: Text;
        Hex: Text;
    begin
        // [SCENARIO #007] Converting 16^i-1 to hexadecimal should result in i times 'F'.
        // [GIVEN] i in [1..15].
        // [WHEN] converting 16^i  to hex
        // [THEN] We get a string with i times F.

        for I := 1 to 15 do begin
            Int := 1;
            for J := 1 to I do
                Int := Int * 16;
            Int := Int - 1;
            Hex := StandardLibrary.Int2Hex(Int);
            ExpectedHex := PadStr('', I, 'F');
            Assert.AreEqual(ExpectedHex, Hex, 'Converting 16^5-1 to hexadecimal should result in FFFFF. That is 5 times.');
        end;
    end;

    [Test]
    procedure TestMaxBigInteger08()
    var
        Int: BigInteger;
        ExpectedHex: Text;
        Hex: Text;
    begin
        // [SCENARIO #008] Converting a really big number.
        // [GIVEN] 9223372036854775807L natural number and maximum value for a 64-bit signed integer 2^63-1
        // [WHEN] converting it to hex
        // [THEN] We get a string with '7' followed by 15 times F.

        Int := 9223372036854775807L;
        Hex := StandardLibrary.Int2Hex(Int);
        ExpectedHex := PadStr('7', 16, 'F');
        Assert.AreEqual(ExpectedHex, Hex, '');
    end;

    [Test]
    procedure TestNegativeNumber2Hex09()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #009] Converting a negative number.
        // [GIVEN] -1
        // [WHEN] converting it to hex
        // [THEN] it fails.

        Int := -1;
        Assert.IsFalse(StandardLibrary.TryInt2Hex(Int, Hex), 'Converting negative numbers will fail.');
    end;

    [Test]
    procedure TestHex2IntIncorrectString10()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #010] Attempting to convert a non hex string.
        // [GIVEN] Nonsens
        // [WHEN] converting it to integer
        // [THEN] it fails.

        Hex := 'ABCDEFG';
        Assert.IsFalse(StandardLibrary.TryHex2Int(Hex, Int), 'Converting nonsens should fail.');
    end;

    [Test]
    procedure TestHex2IntIncorrectString11()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #011] Attempting to convert a non hex string.
        // [GIVEN] Nonsens
        // [WHEN] converting it to integer
        // [THEN] it fails.

        Hex := 'ABZDE';
        Assert.IsFalse(StandardLibrary.TryHex2Int(Hex, Int), 'Converting nonsens should fail.');
    end;

    [Test]
    procedure TestInt2HexWithDefaultPositive1()
    var
        DefaultHexValue: Text;
        Hex: Text;
    begin
        // [SCENARIO #011] Attempting to convert a negative integer, with a default value.
        // [GIVEN] -1 and a valid hex value
        // [WHEN] converting it to hex
        // [THEN] returns our default value.

        DefaultHexValue := '7E7';
        Hex := StandardLibrary.Int2HexWithDefault(-1, DefaultHexValue);
        Assert.AreEqual(DefaultHexValue, Hex, '');
    end;

    [Test]
    procedure TestInt2HexWithDefaultNegative1()
    var
        DefaultHexValue: Text;
        Hex: Text;
    begin
        // [SCENARIO #012] Attempting to convert a negative integer, with a non hex default value.
        // [GIVEN] -1 and a invalide hex value
        // [WHEN] converting it to hex
        // [THEN] returns 0. Int2HexWithDefault is guaranteed to return a valid hex value.

        DefaultHexValue := 'Nonsens';
        Hex := StandardLibrary.Int2HexWithDefault(-1, DefaultHexValue);
        Assert.AreEqual('0', Hex, '');
    end;

    [Test]
    procedure TestSTXkey2Property()
    var
        Int: Integer;
    begin
        // [SCENARIO #013] Converting this ID line from the fin.stx file.
        // [GIVEN] 00033-00181-030-0: CaptionML
        // [WHEN] converting 33 to hex and 181 to hex and then concatenting them
        // [THEN] we gett the  Property Number 8629 which is the CaptionML

        // T3-P8629-A1033-L999:Payment Terms
        // So now we know that "Payment Terms" is the CaptionML (ENU) of Table 3.

        Int := StandardLibrary.Hex2Int(StandardLibrary.Int2Hex(33) + StandardLibrary.Int2Hex(181));
        Assert.AreEqual(8629, Int, 'Expected 00033-00181 to become 8629.');
    end;

    [Test]
    procedure TestHex2IntWithDefaultPositive1()
    var
        DefaultIntValue: Integer;
        Int: Integer;
    begin
        // [SCENARIO #014] Attempting to convert a non hex string, with a default value.
        // [GIVEN] non hex value and an integer
        // [WHEN] converting it to integer
        // [THEN] returns our default value.

        DefaultIntValue := 2023;
        Int := StandardLibrary.Hex2IntWithDefault('Not a hex value', DefaultIntValue);
        Assert.AreEqual(DefaultIntValue, Int, '');
    end;

    [Test]
    procedure TestHex2IntWithDefaultNegative1()
    var
        DefaultIntValue: Integer;
        Int: Integer;
    begin
        // [SCENARIO #015] Attempting to convert a non hex string, with a default value.
        // [GIVEN] non hex value and a negative integer
        // [WHEN] converting it to hex
        // [THEN] returns zero because our default value was

        DefaultIntValue := -1;
        Int := StandardLibrary.Hex2IntWithDefault('Not a hex value', DefaultIntValue);
        Assert.AreEqual(0, Int, '');
    end;

    [Test]
    procedure TestHex2IntEmptyString()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #016] Attempting to convert an empty string.
        // [GIVEN] empty string
        // [WHEN] converting it to integer
        // [THEN] it fails.

        Hex := '';
        Assert.IsFalse(StandardLibrary.TryHex2Int(Hex, Int), 'Converting empty string should fail.');
    end;

    [Test]
    procedure TestHex2IntNumberTooBig()
    var
        Int: BigInteger;
        Hex: Text;
    begin
        // [SCENARIO #017] Attempting to convert a 17 character hex string.
        // [GIVEN]
        // [WHEN] converting it to integer
        // [THEN] it fails.

        Hex := PadStr('', 17, 'F');
        Assert.IsFalse(StandardLibrary.TryHex2Int(Hex, Int), 'Converting a 17 character hex string should fail.');
    end;

    [Test]
    procedure TestHex2IntWithDefaultInvalidHex()
    var
        DefaultIntValue: Integer;
        Int: Integer;
    begin
        // [SCENARIO #018] Attempting to convert an invalid hex string, with a default value.
        // [GIVEN] invalid hex value and an integer
        // [WHEN] converting it to integer
        // [THEN] returns our default value.

        DefaultIntValue := 2023;
        Int := StandardLibrary.Hex2IntWithDefault('InvalidHex', DefaultIntValue);
        Assert.AreEqual(DefaultIntValue, Int, '');
    end;
}
