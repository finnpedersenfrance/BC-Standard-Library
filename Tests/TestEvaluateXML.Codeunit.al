namespace FinnPedersenFrance.Tools.Library;

codeunit 50132 "Test Evaluate XML"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

    trigger OnRun()
    begin
        // [FEATURE] Extract Date from XML DateTime
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML1()
    var
        ExpectedDate: DateTime;
        FoundDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #001] Converting text with a simple valid datetime at midnight.
        // [GIVEN] A datetime in XML format.
        // [WHEN] Evaluating it
        // [THEN] We get a date

        DateTimeText := '2019-05-07T00:00:00+01:00';
        ExpectedDate := CreateDateTime(20190507D, 000000T);
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to evaluate a date.');
        Assert.AreEqual(ExpectedDate, FoundDate, '');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML2()
    var
        ExpectedDate: DateTime;
        FoundDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #002] Converting text with a simple valid date without time.
        // [GIVEN] A date in XML format.
        // [WHEN] Evaluating it
        // [THEN] We get a date

        DateTimeText := '2019-05-07Z';
        ExpectedDate := CreateDateTime(20190507D, 000000T);
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to evaluate a date.');
        Assert.AreEqual(ExpectedDate, FoundDate, '');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML3()
    var
        ExpectedDate: DateTime;
        FoundDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #003] Converting text with a simple valid date with a non zero time.
        // [GIVEN] A datetime in XML format.
        // [WHEN] Evaluating it
        // [THEN] We get a date

        DateTimeText := '2019-02-28T12:34:56Z';
        ExpectedDate := CreateDateTime(20190228D, 123456T);
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to evaluate a date.');
        Assert.AreEqual(ExpectedDate, FoundDate, '');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML4()
    var
        ExpectedDate: DateTime;
        FoundDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #004] Converting text with a wrong date should fail
        // [GIVEN] A February 29th in a non leap year in XML format.
        // [WHEN] Evaluating it
        // [THEN] We should not get a date

        DateTimeText := '2019-02-29T12:34:56';
        ExpectedDate := 0DT;
        Assert.IsFalse(StandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to fail.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML5()
    var
        ExpectedDate: DateTime;
        FoundDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #005] Converting a text without a date should fail
        // [GIVEN] a string of the right length, but non-sense information
        // [WHEN] Evaluating it
        // [THEN] We should not get a date

        DateTimeText := 'YYYY-MM-DDT12:34:56';
        ExpectedDate := 0DT;
        Assert.IsFalse(StandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to fail.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXML6()
    var
        ExpectedDate: DateTime;
        FoundDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #006] Evaluating an empty string should fail
        // [GIVEN] an empty string
        // [WHEN] Evaluating it
        // [THEN] We should not get a date

        DateTimeText := '';
        ExpectedDate := 0DT;
        Assert.IsFalse(StandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), '');
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

        Assert.IsTrue(StandardLibrary.EvaluateBooleanFromXML(FoundBoolean, 'true'), 'Expected to succeed.');
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

        Assert.IsTrue(StandardLibrary.EvaluateBooleanFromXML(FoundBoolean, '1'), 'Expected to succeed.');
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

        Assert.IsTrue(StandardLibrary.EvaluateBooleanFromXML(FoundBoolean, 'false'), 'Expected to succeed.');
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

        Assert.IsTrue(StandardLibrary.EvaluateBooleanFromXML(FoundBoolean, '0'), 'Expected to succeed.');
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

        Assert.IsFalse(StandardLibrary.EvaluateBooleanFromXML(FoundBoolean, ''), 'Expected to fail.');
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

        Assert.IsFalse(StandardLibrary.EvaluateBooleanFromXML(FoundBoolean, 'nonsens'), 'Expected to fail.');
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

        Assert.IsTrue(StandardLibrary.EvaluateIntegerFromXML(FoundInteger, '7'), 'Expected to succeed.');
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

        Assert.IsFalse(StandardLibrary.EvaluateIntegerFromXML(FoundInteger, 'nonsens'), 'Expected to fail.');
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

        Assert.IsTrue(StandardLibrary.EvaluateDecimalFromXML(FoundDecimal, '3.1415926535897932'), 'Expected to succeed.');
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

        Assert.IsFalse(StandardLibrary.EvaluateDecimalFromXML(FoundDecimal, 'nonsens'), 'Expected to fail.');
        Assert.AreEqual(0.0, FoundDecimal, '');
    end;

    // https://github.com/arnau/ISO8601/blob/main/docs/duration.md

    // Test cases
    // https://github.com/arnau/ISO8601/tree/main/spec/iso8601

    // Specification
    // https://en.wikipedia.org/wiki/ISO_8601#Time_intervals

    [Test]
    procedure TestEvaluateDateTimeZoneFromXML()
    var
        FoundNegativeTimeZone: Boolean;
        FoundUtc: Boolean;
        FoundDate: Date;
        Iso8601: Text;
        FoundTime: Time;
        FoundZone: Time;
    begin
        // [SCENARIO #017] Evaluating correct Iso 8601 Date Time
        // [GIVEN] a  Iso 8601 Date Time string
        // [WHEN] Evaluating it
        // [THEN] We get expected Date, Time, and Time Zone / UTC marker

        Iso8601 := '2002-09-24';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), '');
        Assert.AreEqual(20020924D, FoundDate, Iso8601);

        Iso8601 := '2002-09-24Z';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020924D, FoundDate, Iso8601);
        Assert.IsTrue(FoundUtc, 'UTC detected.: ' + Iso8601);

        Iso8601 := '2002-09-24-06:00';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020924D, FoundDate, Iso8601);
        Assert.AreEqual(060000T, FoundZone, Iso8601);
        Assert.IsTrue(FoundNegativeTimeZone, 'Negative Time Zone: ' + Iso8601);

        Iso8601 := '2002-09-24+06:00';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020924D, FoundDate, Iso8601);
        Assert.AreEqual(060000T, FoundZone, Iso8601);
        Assert.IsFalse(FoundNegativeTimeZone, 'Positive Time Zone: ' + Iso8601);

        Iso8601 := '2002-05-30T09:00:00';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020530D, FoundDate, Iso8601);
        Assert.AreEqual(090000T, FoundTime, Iso8601);

        Iso8601 := '2002-05-30T09:30:10.5';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020530D, FoundDate, Iso8601);
        Assert.AreEqual(093010.5T, FoundTime, Iso8601);

        Iso8601 := '2002-05-30T09:30:10.56';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020530D, FoundDate, Iso8601);
        Assert.AreEqual(093010.56T, FoundTime, Iso8601);

        Iso8601 := '2002-05-30T09:30:10.567';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020530D, FoundDate, Iso8601);
        Assert.AreEqual(093010.567T, FoundTime, Iso8601);

        Iso8601 := '2002-05-30T09:30:10Z';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020530D, FoundDate, Iso8601);
        Assert.AreEqual(093010T, FoundTime, Iso8601);
        Assert.IsTrue(FoundUtc, 'UTC detected: ' + Iso8601);

        Iso8601 := '2002-05-30T09:30:10-06:00';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020530D, FoundDate, Iso8601);
        Assert.AreEqual(093010T, FoundTime, Iso8601);
        Assert.AreEqual(060000T, FoundZone, Iso8601);
        Assert.IsTrue(FoundNegativeTimeZone, 'Negative Time Zone: ' + Iso8601);

        Iso8601 := '2002-05-30T09:30:10+06:00';
        Assert.IsTrue(StandardLibrary.EvaluateDateTimeZoneFromXML(FoundDate, FoundTime, FoundUtc, FoundNegativeTimeZone, FoundZone, Iso8601), Iso8601);
        Assert.AreEqual(20020530D, FoundDate, Iso8601);
        Assert.AreEqual(093010T, FoundTime, Iso8601);
        Assert.AreEqual(060000T, FoundZone, Iso8601);
        Assert.IsFalse(FoundNegativeTimeZone, 'Positive Time Zone: ' + Iso8601);
    end;

    [Test]
    procedure TestEvaluateDateTimeFromXMLInvalid()
    var
        ExpectedDate: DateTime;
        FoundDate: DateTime;
        DateTimeText: Text;
    begin
        // [SCENARIO #018] Converting text with an invalid datetime
        // [GIVEN] An invalid datetime in XML format.
        // [WHEN] Evaluating it
        // [THEN] We should not get a date

        DateTimeText := '2019-02-30T12:34:56';
        ExpectedDate := 0DT;
        Assert.IsFalse(StandardLibrary.EvaluateDateTimeFromXML(FoundDate, DateTimeText), 'Expected to fail.');
        Assert.AreEqual(ExpectedDate, FoundDate, 'Expected to evaluate a zero date.');
    end;
}
