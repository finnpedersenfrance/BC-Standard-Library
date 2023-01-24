codeunit 50137 "FPFr Test Dmy Function"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit "FPFr Standard Library";
        Assert: Codeunit "Library Assert";

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
        // [SCENARIO #007] The try-function with catch the error
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
        // [SCENARIO #008] The try-function with catch the error
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
        // [SCENARIO #009] Is a give day, month, year a realy date
        // [GIVEN] February 29th in a leap year
        // [WHEN] Evaluating it 
        // [THEN] We should get a Yes

        Assert.IsTrue(FPFrStandardLibrary.IsDmyValidDate(29, 2, 2020), 'Expected to making a date out of Febrary 29th, 2020.');
    end;

    [Test]
    procedure TestIsDmyValidDateNegative()
    begin
        // [SCENARIO #009] Is a give day, month, year a realy date
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
        // [SCENARIO #010] Given a wrong date, will it return the default value.
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it 
        // [THEN] We should get the default value

        DefaultDate := Today;
        CalculatedDate := FPFrStandardLibrary.Dmy2DateWithDefault(29, 2, 2019, DefaultDate);
        Assert.AreEqual(DefaultDate, CalculatedDate, '');
    end;

}
