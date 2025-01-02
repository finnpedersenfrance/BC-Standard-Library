namespace FinnPedersenFrance.Tools.Library;

codeunit 50131 "Test Add Comment"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

    trigger OnRun()
    begin
        // [FEATURE] Accumulate comments
    end;

    procedure AddComment(var Comment: Text; NewComment: Text)
    begin
        StandardLibrary.AddCommentSeparator(Comment, NewComment, ';');
    end;

    [Test]
    procedure TestAddComment1()
    var
        Comments: Text;
    begin
        // [SCENARIO #001] Testing the starting scenario with an empty string.
        // [GIVEN] An empty string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is empty.

        Comments := '';
        AddComment(Comments, '');
        Assert.AreEqual('', Comments, 'Adding an empty string to an empty string should result in an empty string.');
    end;

    [Test]
    procedure TestAddComment2()
    var
        Comment: Text;
        OriginalComment: Text;
    begin
        // [SCENARIO #002] Testing adding an empty string to an existing string.
        // [GIVEN] An initial string
        // [WHEN] Adding an empty string
        // [THEN] The resulting string is the unchanged original string.

        Comment := 'OK';
        OriginalComment := Comment;
        AddComment(Comment, '');
        Assert.AreEqual(OriginalComment, Comment, 'Adding an empty string to a non empty string should result in the original string.');
    end;

    [Test]
    procedure TestAddComment3()
    var
        Comment: Text;
    begin
        // [SCENARIO #003] Testing the starting scenario adding the first comment.
        // [GIVEN] An empty string
        // [WHEN] Adding a first comment
        // [THEN] The resulting string is the first comment.

        Comment := '';
        AddComment(Comment, 'OK');
        Assert.AreEqual('OK', Comment, 'Adding a non empty string to an empty string should result in the added string.')
    end;

    [Test]
    procedure TestAddComment4()
    var
        Comment: Text;
        OriginalComment: Text;
    begin
        // [SCENARIO #004] Testing adding a comment already present
        // [GIVEN] An orignal comment
        // [WHEN] Adding a comment already present
        // [THEN] The resulting string is the unchangde orignal string.

        Comment := 'OK';
        OriginalComment := Comment;
        AddComment(Comment, 'OK');
        Assert.AreEqual(OriginalComment, Comment, 'Adding the identical comment again should not change the string.')
    end;

    [Test]
    procedure TestAddComment5()
    var
        Comment: Text;
        OriginalComment: Text;
    begin
        // [SCENARIO #005] Testing adding a comment already present
        // [GIVEN] An orignal list of comments
        // [WHEN] Adding a comment already present
        // [THEN] The resulting string is the unchangde orignal string.

        Comment := 'OK1;OK2;OK3;OK4';
        OriginalComment := Comment;
        AddComment(Comment, 'OK3');
        Assert.AreEqual(OriginalComment, Comment, 'Adding the same comment again should not change the string.')
    end;

    [Test]
    procedure TestAddComment6()
    var
        Comment: Text;
        ExpectedComment: Text;
        OriginalComment: Text;
    begin
        // [SCENARIO #006] Adding a new comment to a list of comments
        // [GIVEN] An orignal list of comments
        // [WHEN] Adding a new comment
        // [THEN] The resulting string is the orignal string with the new comment added

        Comment := 'OK1;OK2;OK3;OK4';
        OriginalComment := Comment;
        ExpectedComment := OriginalComment + ';OK5';
        AddComment(Comment, 'OK5');
        Assert.AreEqual(ExpectedComment, Comment, 'Adding a new unique comment should change the string.')
    end;

    [Test]
    procedure TestAddCommentWithDifferentSeparator()
    var
        Comment: Text;
        ExpectedComment: Text;
    begin
        // [SCENARIO #007] Adding a new comment with a different separator
        // [GIVEN] An original list of comments
        // [WHEN] Adding a new comment with a different separator
        // [THEN] The resulting string is the original string with the new comment added

        Comment := 'OK1|OK2|OK3|OK4';
        ExpectedComment := Comment + '|OK5';
        StandardLibrary.AddCommentSeparator(Comment, 'OK5', '|');
        Assert.AreEqual(ExpectedComment, Comment, 'Adding a new unique comment with a different separator should change the string.')
    end;
}
