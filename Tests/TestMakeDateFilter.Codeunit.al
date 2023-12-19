namespace FinnPedersenFrance.Tools.Library;

codeunit 50136 "Test Make Date Filter"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit "Standard Library";
        Assert: Codeunit "Assert";


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
        DateFilterTxt: Label '%1..%2', Comment = '%1 = Start Date, %2 = End Date';
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := CalcDate('<-10D>', Today);
        EndingDate := CalcDate('<20D>', StartingDate);
        ExpectedString := StrSubstNo(DateFilterTxt, StartingDate, EndingDate);

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
        DateFilterTxt: Label '%1..%2', Comment = '%1 = Start Date, %2 = End Date';
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := 0D;
        EndingDate := Today;
        ExpectedString := StrSubstNo(DateFilterTxt, '', EndingDate);

        Assert.AreEqual(ExpectedString, FPFrStandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterTillEndOfTime()
    var
        StartingDate: Date;
        EndingDate: Date;
        ExpectedString: Text;
        DateFilterTxt: Label '%1..%2', Comment = '%1 = Start Date, %2 = End Date';
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := Today;
        EndingDate := 0D;
        ExpectedString := StrSubstNo(DateFilterTxt, StartingDate, '');

        Assert.AreEqual(ExpectedString, FPFrStandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;


}
