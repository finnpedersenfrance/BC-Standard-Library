namespace FinnPedersenFrance.Tools.Library;

codeunit 50135 "Test String Functions"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        FPFrStandardLibrary: Codeunit "Standard Library";

    [Test]
    procedure TestRemoveChar()
    begin
        // [SCENARIO #001] Removing charactes from string.
        // [GIVEN] A string
        // [WHEN] removing a set of characters
        // [THEN] The resulting string is without these characters.

        Assert.AreEqual('Sring', FPFrStandardLibrary.RemoveChar('StartingDate', 'Date'), '');
    end;

    [Test]
    procedure TestKeepChar()
    begin
        // [SCENARIO #001] Removing charactes from string.
        // [GIVEN] A string
        // [WHEN] keeping a set of characters
        // [THEN] The resulting string is only with these characters.

        Assert.AreEqual('tatDate', FPFrStandardLibrary.KeepChar('StartingDate', 'Date'), '');
    end;
}
