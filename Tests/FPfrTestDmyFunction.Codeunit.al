namespace FinnPedersenFrance.Tools.Library;

codeunit 50137 "FPFr Test Dmy Function"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit "FPFr Standard Library";
        Assert: Codeunit "Standard Library Assert";

    trigger OnRun()
    begin
        // [FEATURE] Building Dates
    end;

    [Test]
    procedure TestTryDmy2Date1()
    var
        FoundDate: Date;
        ExpectedDate: Date;
    begin
        // [SCENARIO #001] The try-function with catch the error
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it
        // [THEN] We should not get a date

        ExpectedDate := 0D;
        Assert.IsFalse(FPFrStandardLibrary.TryDmy2Date(29, 2, 2019, FoundDate), 'Expected to evaluate fail making a date out of Febrary 29th, 2019.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;

    [Test]
    procedure TestTryDmy2Date2()
    var
        FoundDate: Date;
        ExpectedDate: Date;
    begin
        // [SCENARIO #002] The try-function with catch the error
        // [GIVEN] February 29th in a leap year
        // [WHEN] Evaluating it
        // [THEN] We should get a date

        ExpectedDate := DMY2Date(29, 2, 2020);
        Assert.IsTrue(FPFrStandardLibrary.TryDmy2Date(29, 2, 2020, FoundDate), 'Expected to making a date out of Febrary 29th, 2020.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected Febrary 29th, 2020 to be a date.');
    end;

    [Test]
    procedure TestIsDmyValidDatePositive()
    begin
        // [SCENARIO #003] Is a give day, month, year a realy date
        // [GIVEN] February 29th in a leap year
        // [WHEN] Evaluating it
        // [THEN] We should get a Yes

        Assert.IsTrue(FPFrStandardLibrary.IsDmyValidDate(29, 2, 2020), 'Expected to making a date out of Febrary 29th, 2020.');
    end;

    [Test]
    procedure TestIsDmyValidDateNegative()
    begin
        // [SCENARIO #004] Is a give day, month, year a realy date
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it
        // [THEN] We should get a No

        Assert.IsFalse(FPFrStandardLibrary.IsDmyValidDate(29, 2, 2019), 'Febrary 29th, 2019 is not a valid date.');
    end;

    [Test]
    procedure TestDmy2DateWithDefault()
    var
        DefaultDate: Date;
        CalculatedDate: Date;

    begin
        // [SCENARIO #005] Given a wrong date, will it return the default value.
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it
        // [THEN] We should get the default value

        DefaultDate := Today;
        CalculatedDate := FPFrStandardLibrary.Dmy2DateWithDefault(29, 2, 2019, DefaultDate);
        Assert.AreEqual(DefaultDate, CalculatedDate, '');
    end;

    [Test]
    procedure TestTryCreateDateTimeNegative()
    var
        CalculatedDateTime: DateTime;
        ExpectedDateTime: DateTime;
    begin
        // [SCENARIO #006] The try-function with catch the error
        // [GIVEN] a 0D with a time
        // [WHEN] Evaluating it
        // [THEN] We should fail

        ExpectedDateTime := 0DT;
        Assert.IsFalse(FPFrStandardLibrary.TryCreateDateTime(0D, 010000T, CalculatedDateTime), 'Expected TryCreateDateTime to fail making a datetime from a 0D and a non zero time.');
        Assert.AreEqual(ExpectedDateTime, CalculatedDateTime, 'Expected to evaluate a zero datetime.');
    end;

    [Test]
    procedure TestTryCreateDateTimePositive()
    var
        CalculatedDateTime: DateTime;
        ExpectedDateTime: DateTime;
    begin
        // [SCENARIO #006] The try-function with catch the error
        // [GIVEN] a 0D with a time
        // [WHEN] Evaluating it
        // [THEN] We should fail

        ExpectedDateTime := CreateDateTime(DMY2Date(29, 2, 2020), 123456T);
        Assert.IsTrue(FPFrStandardLibrary.TryCreateDateTime(DMY2Date(29, 2, 2020), 123456T, CalculatedDateTime), 'Expected TryCreateDateTime to succeed and return true.');
        Assert.AreEqual(ExpectedDateTime, CalculatedDateTime, 'Expected to evaluate a correct datetime.');
    end;

}
