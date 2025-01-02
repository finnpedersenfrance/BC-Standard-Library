namespace FinnPedersenFrance.Tools.Library;

codeunit 50137 "Test Dmy Function"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

    trigger OnRun()
    begin
        // [FEATURE] Building Dates
    end;

    [Test]
    procedure TestTryDmy2Date1()
    var
        ExpectedDate: Date;
        FoundDate: Date;
    begin
        // [SCENARIO #001] The try-function with catch the error
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it
        // [THEN] We should not get a date

        ExpectedDate := 0D;
        Assert.IsFalse(StandardLibrary.TryDmy2Date(29, 2, 2019, FoundDate), 'Expected to evaluate fail making a date out of Febrary 29th, 2019.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;

    [Test]
    procedure TestTryDmy2Date2()
    var
        ExpectedDate: Date;
        FoundDate: Date;
    begin
        // [SCENARIO #002] The try-function with catch the error
        // [GIVEN] February 29th in a leap year
        // [WHEN] Evaluating it
        // [THEN] We should get a date

        ExpectedDate := DMY2Date(29, 2, 2020);
        Assert.IsTrue(StandardLibrary.TryDmy2Date(29, 2, 2020, FoundDate), 'Expected to making a date out of Febrary 29th, 2020.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected Febrary 29th, 2020 to be a date.');
    end;

    [Test]
    procedure TestIsDmyValidDatePositive()
    begin
        // [SCENARIO #003] Is a give day, month, year a realy date
        // [GIVEN] February 29th in a leap year
        // [WHEN] Evaluating it
        // [THEN] We should get a Yes

        Assert.IsTrue(StandardLibrary.IsDmyValidDate(29, 2, 2020), 'Expected to making a date out of Febrary 29th, 2020.');
    end;

    [Test]
    procedure TestIsDmyValidDateNegative()
    begin
        // [SCENARIO #004] Is a give day, month, year a realy date
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it
        // [THEN] We should get a No

        Assert.IsFalse(StandardLibrary.IsDmyValidDate(29, 2, 2019), 'Febrary 29th, 2019 is not a valid date.');
    end;

    [Test]
    procedure TestDmy2DateWithDefault()
    var
        CalculatedDate: Date;
        DefaultDate: Date;

    begin
        // [SCENARIO #005] Given a wrong date, will it return the default value.
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it
        // [THEN] We should get the default value

        DefaultDate := Today();
        CalculatedDate := StandardLibrary.Dmy2DateWithDefault(29, 2, 2019, DefaultDate);
        Assert.AreEqual(DefaultDate, CalculatedDate, '');
    end;

    [Test]
    procedure TestDmy2DateWithDefaultInvalidDate()
    var
        CalculatedDate: Date;
        DefaultDate: Date;

    begin
        // [SCENARIO #006] Given an invalid date, will it return the default value.
        // [GIVEN] An invalid date
        // [WHEN] Evaluating it
        // [THEN] We should get the default value

        DefaultDate := Today();
        CalculatedDate := StandardLibrary.Dmy2DateWithDefault(32, 13, 2023, DefaultDate);
        Assert.AreEqual(DefaultDate, CalculatedDate, '');
    end;

    [Test]
    procedure TestTryCreateDateTimeNegative()
    var
        CalculatedDateTime: DateTime;
        ExpectedDateTime: DateTime;
    begin
        // [SCENARIO #007] The try-function with catch the error
        // [GIVEN] a 0D with a time
        // [WHEN] Evaluating it
        // [THEN] We should fail

        ExpectedDateTime := 0DT;
        Assert.IsFalse(StandardLibrary.TryCreateDateTime(0D, 010000T, CalculatedDateTime), 'Expected TryCreateDateTime to fail making a datetime from a 0D and a non zero time.');
        Assert.AreEqual(ExpectedDateTime, CalculatedDateTime, 'Expected to evaluate a zero datetime.');
    end;

    [Test]
    procedure TestTryCreateDateTimePositive()
    var
        CalculatedDateTime: DateTime;
        ExpectedDateTime: DateTime;
    begin
        // [SCENARIO #008] The try-function with catch the error
        // [GIVEN] a 0D with a time
        // [WHEN] Evaluating it
        // [THEN] We should fail

        ExpectedDateTime := CreateDateTime(DMY2Date(29, 2, 2020), 123456T);
        Assert.IsTrue(StandardLibrary.TryCreateDateTime(DMY2Date(29, 2, 2020), 123456T, CalculatedDateTime), 'Expected TryCreateDateTime to succeed and return true.');
        Assert.AreEqual(ExpectedDateTime, CalculatedDateTime, 'Expected to evaluate a correct datetime.');
    end;
}
