namespace FinnPedersenFrance.Tools.Library;

codeunit 50136 "Test Make Date Filter"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

    trigger OnRun()
    begin
        // [FEATURE] Correct Date Filters
    end;

    [Test]
    procedure TestDateFilterNormal()
    var
        EndingDate: Date;
        StartingDate: Date;
        DateFilterTxt: Label '%1..%2', Comment = '%1 = Start Date, %2 = End Date', Locked = true;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := CalcDate('<-10D>', Today());
        EndingDate := CalcDate('<20D>', StartingDate);
        ExpectedString := StrSubstNo(DateFilterTxt, StartingDate, EndingDate);

        Assert.AreEqual(ExpectedString, StandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterNoDates()
    var
        EndingDate: Date;
        StartingDate: Date;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := 0D;
        EndingDate := 0D;
        ExpectedString := '';

        Assert.AreEqual(ExpectedString, StandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterFromBeginningOfTime()
    var
        EndingDate: Date;
        StartingDate: Date;
        DateFilterTxt: Label '%1..%2', Comment = '%1 = Start Date, %2 = End Date', Locked = true;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := 0D;
        EndingDate := Today();
        ExpectedString := StrSubstNo(DateFilterTxt, '', EndingDate);

        Assert.AreEqual(ExpectedString, StandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterTillEndOfTime()
    var
        EndingDate: Date;
        StartingDate: Date;
        DateFilterTxt: Label '%1..%2', Comment = '%1 = Start Date, %2 = End Date', Locked = true;
        ExpectedString: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        StartingDate := Today();
        EndingDate := 0D;
        ExpectedString := StrSubstNo(DateFilterTxt, StartingDate, '');

        Assert.AreEqual(ExpectedString, StandardLibrary.MakeDateFilter(StartingDate, EndingDate), '');
    end;

    [Test]
    procedure TestDateFilterOnlyStartingDate()
    var
        StartingDate: Date;
        DateFilterTxt: Label '%1..%2', Comment = '%1 = Start Date, %2 = End Date', Locked = true;
        ExpectedString: Text;
    begin
        // [SCENARIO #005] Testing the scenario with only a starting date.
        // [GIVEN] A starting date
        // [WHEN] Adding only a starting date
        // [THEN] The resulting string is the starting date followed by ".."

        StartingDate := Today();
        ExpectedString := StrSubstNo(DateFilterTxt, StartingDate, '');

        Assert.AreEqual(ExpectedString, StandardLibrary.MakeDateFilter(StartingDate, 0D), '');
    end;
}
