namespace FinnPedersenFrance.Tools.Library;

codeunit 50136 "FPFr Test Make Date Filter"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit "FPFr Standard Library";
        Assert: Codeunit "Standard Library Assert";


    trigger OnRun()
    begin
        // [FEATURE] Correct Date Filters
    end;

    [Test]
    procedure TestDateFilterNormal()
    var
        StartingDate: Date;
        EndingDate: Date;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := CalcDate('<-10D>', Today);
        EndingDate := CalcDate('<20D>', StartingDate);
        ExpectedString := StrSubstNo('%1..%2', StartingDate, EndingDate);

        Assert.AreEqual(ExpectedString, FPFrStandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterNoDates()
    var
        StartingDate: Date;
        EndingDate: Date;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := 0D;
        EndingDate := 0D;
        ExpectedString := '';

        Assert.AreEqual(ExpectedString, FPFrStandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterFromBeginningOfTime()
    var
        StartingDate: Date;
        EndingDate: Date;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := 0D;
        EndingDate := Today;
        ExpectedString := StrSubstNo('..%1', EndingDate);

        Assert.AreEqual(ExpectedString, FPFrStandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterTillEndOfTime()
    var
        StartingDate: Date;
        EndingDate: Date;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := Today;
        EndingDate := 0D;
        ExpectedString := StrSubstNo('%1..', StartingDate);

        Assert.AreEqual(ExpectedString, FPFrStandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;


}
