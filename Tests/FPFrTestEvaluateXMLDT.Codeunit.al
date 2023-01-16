Codeunit 50132 "FPFr Test Evaluate XML DT"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit FPFrStandardLibrary;

    trigger OnRun()
    begin
        // [FEATURE] Extract Date from XML DateTime 
    end;

    [Test]
    procedure TestEvaluateDateFromXMLDateTime1()
    var
        FoundDate: Date;
        ExpectedDate: Date;
        DateTimeText: Text;
    begin
        // [SCENARIO #0001] Converting text with a simple valid datetime at midnight.
        // [GIVEN] A datetime in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We get a date

        DateTimeText := '2019-05-07T00:00:00';
        ExpectedDate := DMY2Date(7, 5, 2019);
        if not FPFrStandardLibrary.EvaluateDateFromXMLDateTime(FoundDate, DateTimeText) then
            Error('Expected to extracte a date from "%1"', DateTimeText);
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));
    end;

    [Test]
    procedure TestEvaluateDateFromXMLDateTime2()
    var
        FoundDate: Date;
        ExpectedDate: Date;
        DateTimeText: Text;
    begin
        // [SCENARIO #0002] Converting text with a simple valid date without time.
        // [GIVEN] A date in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We get a date

        DateTimeText := '2019-05-07';
        ExpectedDate := DMY2Date(7, 5, 2019);
        if not FPFrStandardLibrary.EvaluateDateFromXMLDateTime(FoundDate, DateTimeText) then
            Error('Expected to extracte a date from "%1"', DateTimeText);
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));
    end;

    [Test]
    procedure TestEvaluateDateFromXMLDateTime3()
    var
        FoundDate: Date;
        ExpectedDate: Date;
        DateTimeText: Text;
    begin
        // [SCENARIO #0003] Converting text with a simple valid date with a non zero time.
        // [GIVEN] A datetime in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We get a date

        DateTimeText := '2019-02-28T12:34:56';
        ExpectedDate := DMY2Date(28, 2, 2019);
        if not FPFrStandardLibrary.EvaluateDateFromXMLDateTime(FoundDate, DateTimeText) then
            Error('Expected to extracte a date from "%1"', DateTimeText);
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));
    end;

    [Test]
    procedure TestEvaluateDateFromXMLDateTime4()
    var
        FoundDate: Date;
        ExpectedDate: Date;
        DateTimeText: Text;
    begin
        // [SCENARIO #0004] Converting text with a wrong date should fail
        // [GIVEN] A February 29th in a non leap year in XML format. 
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        DateTimeText := '2019-02-29T12:34:56';
        ExpectedDate := 0D;
        if FPFrStandardLibrary.EvaluateDateFromXMLDateTime(FoundDate, DateTimeText) then
            Error('Expected to fail extracting a date from "%1"', DateTimeText);
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));
    end;

    [Test]
    procedure TestEvaluateDateFromXMLDateTime5()
    var
        FoundDate: Date;
        ExpectedDate: Date;
        DateTimeText: Text;
    begin
        // [SCENARIO #0005] Converting a text without a date should fail
        // [GIVEN] a string of the right length, but non-sense information 
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        DateTimeText := 'YYYY-MM-DDT12:34:56';
        ExpectedDate := 0D;
        if FPFrStandardLibrary.EvaluateDateFromXMLDateTime(FoundDate, DateTimeText) then
            Error('Expected to fail extracting a date from "%1"', DateTimeText);
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));
    end;

    [Test]
    procedure TestEvaluateDateFromXMLDateTime6()
    var
        FoundDate: Date;
        ExpectedDate: Date;
        DateTimeText: Text;
    begin
        // [SCENARIO #0006] Evaluating an empty string should fail
        // [GIVEN] an empty string
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        DateTimeText := '';
        ExpectedDate := 0D;
        if FPFrStandardLibrary.EvaluateDateFromXMLDateTime(FoundDate, DateTimeText) then
            Error('Expected to fail extracting a date from an empty string');
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));
    end;

    [Test]
    procedure TestTryDMY2DATE()
    var
        FoundDate: Date;
        ExpectedDate: Date;
    begin
        // [SCENARIO #0008] The try-function with catch the error
        // [GIVEN] February 29th in a non leap year
        // [WHEN] Evaluating it 
        // [THEN] We should not get a date

        ExpectedDate := 0D;
        if FPFrStandardLibrary.TryDMY2DATE(29, 2, 2019, FoundDate) then
            Error('Expected to fail evaluating 29/2/2019 to a date.');
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));

        // [SCENARIO #0007] The try-function with catch the error
        // [GIVEN] February 29th in a leap year
        // [WHEN] Evaluating it 
        // [THEN] We should get a date

        ExpectedDate := DMY2Date(29, 2, 2020);
        if not FPFrStandardLibrary.TryDMY2DATE(29, 2, 2020, FoundDate) then
            Error('Expected to evaluate 29/2/2020 to a date.');
        if FoundDate <> ExpectedDate then
            Error('Expected date to evaluate to %1. Got: %2', Format(ExpectedDate), Format(FoundDate));

    end;
}

