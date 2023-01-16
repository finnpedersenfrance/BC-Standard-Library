Codeunit 50131 "FPFr Test Add Comment"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit FPFrStandardLibrary;

    trigger OnRun()
    begin
        // [FEATURE] Accumulate comments 
    end;

    procedure AddComment(var Comment: Text; NewComment: Text)
    begin
        FPFrStandardLibrary.AddCommentSeparator(Comment, NewComment, ';');
    end;

    [Test]
    procedure TestAddComment1()
    var
        Comments: Text;
    begin
        // [SCENARIO #0001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        Comments := '';
        AddComment(Comments, '');
        if not (Comments = '') then
            Error('Expected: Adding an empty string to an empty string should result in an empty string. Got: "%1"', Comments);
    end;

    [Test]
    procedure TestAddComment2()
    var
        Comment: Text;
        OriginalComment: Text;
    begin
        // [SCENARIO #0002] Testing adding an empty string to an existing string.
        // [GIVEN] An initial string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is the unchanged original string.

        Comment := 'OK';
        OriginalComment := Comment;
        AddComment(Comment, '');
        if not (Comment = OriginalComment) then
            Error('Expected: Adding an empty string to a non empty string should result in the original string. Got: "%1"', Comment);
    end;

    [Test]
    procedure TestAddComment3()
    var
        Comment: Text;
    begin
        // [SCENARIO #0003] Testing the starting scenario adding the first comment.
        // [GIVEN] An empty string
        // [WHEN] Adding a first comment
        // [THEN] The resulting string is the first comment.

        Comment := '';
        AddComment(Comment, 'OK');
        if not (Comment = 'OK') then
            Error('Expected: Adding a non empty string to an empty string should result in the added string. "%1"', Comment);
    end;

    [Test]
    procedure TestAddComment4()
    var
        Comment: Text;
        OriginalComment: Text;
    begin
        // [SCENARIO #0004] Testing adding a comment already present
        // [GIVEN] An orignal comment
        // [WHEN] Adding a comment already present
        // [THEN] The resulting string is the unchangde orignal string.

        Comment := 'OK';
        OriginalComment := Comment;
        AddComment(Comment, 'OK');
        if not (Comment = OriginalComment) then
            Error('Expected: Adding the identical comment again should not change the string. "%1"', Comment);
    end;

    [Test]
    procedure TestAddComment5()
    var
        Comment: Text;
        OriginalComment: Text;
    begin
        // [SCENARIO #0005] Testing adding a comment already present
        // [GIVEN] An orignal list of comments
        // [WHEN] Adding a comment already present
        // [THEN] The resulting string is the unchangde orignal string.

        Comment := 'OK1;OK2;OK3;OK4';
        OriginalComment := Comment;
        AddComment(Comment, 'OK3');
        if not (Comment = OriginalComment) then
            Error('Expected: Adding the same comment again should not change the string. "%1"', Comment);
    end;

    [Test]
    procedure TestAddComment6()
    var
        Comment: Text;
        OriginalComment: Text;
        ExpectedComment: Text;
    begin
        // [SCENARIO #0006] Adding a new comment to a list of comments 
        // [GIVEN] An orignal list of comments
        // [WHEN] Adding a new comment
        // [THEN] The resulting string is the orignal string with the new comment added

        Comment := 'OK1;OK2;OK3;OK4';
        OriginalComment := Comment;
        ExpectedComment := OriginalComment + ';OK5';
        AddComment(Comment, 'OK5');
        if not (Comment = ExpectedComment) then
            Error('Expected: Adding a new unique comment should change the string. Got "%1". Expected: "%2"', Comment, ExpectedComment);
    end;


}
