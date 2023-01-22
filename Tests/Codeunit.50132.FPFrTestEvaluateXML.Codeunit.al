codeunit 50132 "FPFr Test Evaluate XML"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit "FPFr Standard Library";
        Assert: Codeunit "Library Assert";

    trigger OnRun()
    begin
        // [FEATURE] Extract Date from XML DateTime 
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML1()
    var
        FoundDate: DateTime;
        ExpectedDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #001] Converting text with a simple valid datetime at midnight.
        // [GIVEN] A datetime in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We get a date

        DateTimeText := '2019-05-07T00:00:00+01:00';
        ExpectedDate := CreateDateTime(20190507D, 0T);
        Assert.IsTrue(FPFrStandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to evaluate a date.');
        Assert.AreEqual(ExpectedDate, FoundDate, '');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML2()
    var
        FoundDate: DateTime;
        ExpectedDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #002] Converting text with a simple valid date without time.
        // [GIVEN] A date in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We get a date

        DateTimeText := '2019-05-07';
        ExpectedDate := CreateDateTime(20190507D, 0T);
        Assert.IsTrue(FPFrStandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to evaluate a date.');
        Assert.AreEqual(ExpectedDate, FoundDate, '');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML3()
    var
        FoundDate: DateTime;
        ExpectedDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #003] Converting text with a simple valid date with a non zero time.
        // [GIVEN] A datetime in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We get a date

        DateTimeText := '2019-02-28T12:34:56Z';
        ExpectedDate := CreateDateTime(20190228D, 123456T);
        Assert.IsTrue(FPFrStandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to evaluate a date.');
        Assert.AreEqual(ExpectedDate, FoundDate, '');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML4()
    var
        FoundDate: DateTime;
        ExpectedDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #004] Converting text with a wrong date should fail
        // [GIVEN] A February 29th in a non leap year in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        DateTimeText := '2019-02-29T12:34:56';
        ExpectedDate := 0DT;
        Assert.IsFalse(FPFrStandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to fail.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML5()
    var
        FoundDate: DateTime;
        ExpectedDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #005] Converting a text without a date should fail
        // [GIVEN] a string of the right length, but non-sense information 
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        DateTimeText := 'YYYY-MM-DDT12:34:56';
        ExpectedDate := 0DT;
        Assert.IsFalse(FPFrStandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to fail.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML6()
    var
        FoundDate: DateTime;
        ExpectedDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #006] Evaluating an empty string should fail
        // [GIVEN] an empty string
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        DateTimeText := '';
        ExpectedDate := 0DT;
        Assert.IsTrue(FPFrStandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), '');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;

    [Test]
    procedure TestEvaluateBooleanFromXML1()
    var
        FoundBoolean: Boolean;
    begin
        // [SCENARIO #007] Evaluating boolean
        // [GIVEN] 'true' 
        // [WHEN] Evaluating it 
        // [THEN] We get true

        Assert.IsTrue(FPFrStandardLibrary.EvaluateBooleanFromXML(FoundBoolean, 'true'), 'Expected to succeed.');
        Assert.IsTrue(FoundBoolean, '');
    end;

    [Test]
    procedure TestEvaluateBooleanFromXML2()
    var
        FoundBoolean: Boolean;
    begin
        // [SCENARIO #008] Evaluating boolean
        // [GIVEN] 'true' 
        // [WHEN] Evaluating it 
        // [THEN] We get true

        Assert.IsTrue(FPFrStandardLibrary.EvaluateBooleanFromXML(FoundBoolean, '1'), 'Expected to succeed.');
        Assert.IsTrue(FoundBoolean, '');
    end;

    [Test]
    procedure TestEvaluateBooleanFromXML3()
    var
        FoundBoolean: Boolean;
    begin
        // [SCENARIO #009] Evaluating boolean
        // [GIVEN] 'true' 
        // [WHEN] Evaluating it 
        // [THEN] We get true

        Assert.IsTrue(FPFrStandardLibrary.EvaluateBooleanFromXML(FoundBoolean, 'false'), 'Expected to succeed.');
        Assert.IsFalse(FoundBoolean, '');
    end;

    [Test]
    procedure TestEvaluateBooleanFromXML4()
    var
        FoundBoolean: Boolean;
    begin
        // [SCENARIO #010] Evaluating boolean
        // [GIVEN] 'true' 
        // [WHEN] Evaluating it 
        // [THEN] We get true

        Assert.IsTrue(FPFrStandardLibrary.EvaluateBooleanFromXML(FoundBoolean, '0'), 'Expected to succeed.');
        Assert.IsFalse(FoundBoolean, '');
    end;

    [Test]
    procedure TestEvaluateBooleanFromXML5()
    var
        FoundBoolean: Boolean;
    begin
        // [SCENARIO #011] Evaluating an empty string should fail
        // [GIVEN] an empty string
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        Assert.IsFalse(FPFrStandardLibrary.EvaluateBooleanFromXML(FoundBoolean, ''), 'Expected to fail.');
        Assert.IsFalse(FoundBoolean, '');
    end;

    [Test]
    procedure TestEvaluateBooleanFromXML6()
    var
        FoundBoolean: Boolean;
    begin
        // [SCENARIO #012] Evaluating a nonsens string should fail
        // [GIVEN] a nonsens string
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        Assert.IsFalse(FPFrStandardLibrary.EvaluateBooleanFromXML(FoundBoolean, 'nonsens'), 'Expected to fail.');
        Assert.IsFalse(FoundBoolean, '');
    end;

    [Test]
    procedure TestEvaluateIntegerFromXML1()
    var
        FoundInteger: Integer;
    begin
        // [SCENARIO #013] Evaluating Integer
        // [GIVEN] '7' 
        // [WHEN] Evaluating it 
        // [THEN] We get 7

        Assert.IsTrue(FPFrStandardLibrary.EvaluateIntegerFromXML(FoundInteger, '7'), 'Expected to succeed.');
        Assert.AreEqual(7, FoundInteger, '');
    end;

    [Test]
    procedure TestEvaluateIntegerFromXML2()
    var
        FoundInteger: Integer;
    begin
        // [SCENARIO #014] Evaluating nonsens string to integer
        // [GIVEN] 'nonsens' 
        // [WHEN] Evaluating it 
        // [THEN] We get false and 0

        Assert.IsFalse(FPFrStandardLibrary.EvaluateIntegerFromXML(FoundInteger, 'nonsens'), 'Expected to fail.');
        Assert.AreEqual(0, FoundInteger, '');
    end;

    [Test]
    procedure TestEvaluateDecimalFromXML1()
    var
        FoundDecimal: Decimal;
    begin
        // [SCENARIO #015] Evaluating Decimal
        // [GIVEN] '3.1415926535897932' 
        // [WHEN] Evaluating it 
        // [THEN] We get a value close to pi

        Assert.IsTrue(FPFrStandardLibrary.EvaluateDecimalFromXML(FoundDecimal, '3.1415926535897932'), 'Expected to succeed.');
        Assert.AreEqual(3.1415926535897932, FoundDecimal, 'Did we find pi?');
    end;

    [Test]
    procedure TestEvaluateDecimalFromXML2()
    var
        FoundDecimal: Decimal;
    begin
        // [SCENARIO #016] Evaluating nonsens string to Decimal
        // [GIVEN] 'nonsens' 
        // [WHEN] Evaluating it 
        // [THEN] We get false and 0

        Assert.IsFalse(FPFrStandardLibrary.EvaluateDecimalFromXML(FoundDecimal, 'nonsens'), 'Expected to fail.');
        Assert.AreEqual(0.0, FoundDecimal, '');
    end;

    // https://github.com/arnau/ISO8601/blob/main/docs/duration.md

    // Test cases
    // https://github.com/arnau/ISO8601/tree/main/spec/iso8601

    // Specification
    // https://en.wikipedia.org/wiki/ISO_8601#Time_intervals


}

