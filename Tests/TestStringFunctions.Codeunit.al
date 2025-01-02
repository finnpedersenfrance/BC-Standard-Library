namespace FinnPedersenFrance.Tools.Library;

codeunit 50135 "Test String Functions"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

    [Test]
    procedure TestRemoveChar()
    begin
        // [SCENARIO #001] Removing charactes from string.
        // [GIVEN] A string
        // [WHEN] removing a set of characters
        // [THEN] The resulting string is without these characters.

        Assert.AreEqual('Sring', StandardLibrary.RemoveChar('StartingDate', 'Date'), '');
    end;

    [Test]
    procedure TestKeepChar()
    begin
        // [SCENARIO #001] Removing charactes from string.
        // [GIVEN] A string
        // [WHEN] keeping a set of characters
        // [THEN] The resulting string is only with these characters.

        Assert.AreEqual('tatDate', StandardLibrary.KeepChar('StartingDate', 'Date'), '');
    end;

    [Test]
    procedure TestRemoveCharEmptyString()
    begin
        // [SCENARIO #002] Removing characters from an empty string.
        // [GIVEN] An empty string
        // [WHEN] removing a set of characters
        // [THEN] The resulting string is still empty.

        Assert.AreEqual('', StandardLibrary.RemoveChar('', 'Date'), '');
    end;
}
