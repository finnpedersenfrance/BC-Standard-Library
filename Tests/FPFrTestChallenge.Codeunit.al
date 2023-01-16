Codeunit 50134 "FPFr Test Challenge"
{
    Subtype = Test;

    trigger OnRun()
    begin
        // [FEATURE] 
    end;

    [Test]
    procedure TestFail()
    begin
        // [SCENARIO #0001]
        // [GIVEN]
        // [WHEN] 
        // [THEN]

        Error('%1', Format(CurrentDateTime, 0, 9));
    end;

}

