Codeunit 50135 "FPFr Test Power Function"
{
    // This test illustrates a bug in the standard POWER function in Dynamics NAV.
    // 16 to the power of 15 fails compared to simply multiplying 16 with itself 15 times.

    Subtype = Test;

    trigger OnRun()
    begin
    end;

    [Test]
    procedure TestNavisionPowerFunction1()
    var
        int1: BigInteger;
        int2: BigInteger;
        i: Integer;
        j: Integer;
    begin
        for i := 1 to 14 do begin
            int1 := 1;
            for j := 1 to i do
                int1 := int1 * 16;
            int1 := int1 - 1;
            int2 := Power(16, i) - 1;
            if not (int1 = int2) then
                Error('Expected: POWER(16,%1)-1 should result in (16^%1)-1. Got "%3" <> "%2"', i, int1, int2);
        end;
    end;

    [Test]
    procedure TestNavisionPowerFunction2()
    var
        int1: BigInteger;
        int2: BigInteger;
        i: Integer;
        j: Integer;
    begin
        i := 15;
        int1 := 1;
        for j := 1 to i do
            int1 := int1 * 16;
        int2 := Power(16, i);
        if not (int1 = int2) then
            asserterror Error('Expected: POWER(16,%1) - 16^%1 = 0. Got "%2"', i, int2 - int1);
        // This was not supposed to fail, but it does.
        // Remove the ASSERTERROR to see the error message.
    end;

    [Test]
    procedure TestNavisionPowerFunction3()
    var
        int1: BigInteger;
        int2: BigInteger;
    begin
        // https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/methods-auto/system/system-power-method
        int1 := 1152921504606846976L;
        int2 := System.Power(16, 15);
        if not (int1 = int2) then
            asserterror Error('Expected: POWER(16,15) - 16^15 = 0. Got "%1"', int2 - int1);
        // This was not supposed to fail, but it does.
        // Remove the ASSERTERROR to see the error message.
    end;

}

