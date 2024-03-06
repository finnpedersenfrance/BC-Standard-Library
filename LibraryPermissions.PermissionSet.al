permissionset 50131 "Library Permissions"
{
    Assignable = true;
    Caption = 'Library Permissions', MaxLength = 30, Locked = true;
    Permissions = codeunit Assert = X,
        codeunit "Standard Library" = X,
        codeunit "Test Add Comment" = X,
        codeunit "Test Dmy Function" = X,
        codeunit "Test Evaluate XML" = X,
        codeunit "Test Hex Int Conversion" = X,
        codeunit "Test Make Date Filter" = X,
        codeunit "Test Regex Functions" = X,
        codeunit "Test String Functions" = X,
        codeunit "Test XML Format" = X;
}