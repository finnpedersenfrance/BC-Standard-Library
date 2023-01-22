codeunit 50138 "FPFr Test Regex Functions"
{
    Subtype = Test;

    var
        FPFrStandardLibrary: Codeunit "FPFr Standard Library";
        Assert: Codeunit "Library Assert";

    trigger OnRun()
    begin
        // [FEATURE] Pattern recognizion with Regex.
    end;

    [Test]
    procedure TestIsEmptyStringYes()
    begin
        // [SCENARIO #001] Is string empty or not
        // [GIVEN] Given an empty string
        // [WHEN] testing
        // [THEN] it is true

        Assert.IsTrue(FPFrStandardLibrary.IsEmptyString(''), '');
    end;

    [Test]
    procedure TestIsEmptyStringNo()
    begin
        // [SCENARIO #001] Is string empty or not
        // [GIVEN] Given a non empty string
        // [WHEN] testing
        // [THEN] it is false

        Assert.IsFalse(FPFrStandardLibrary.IsEmptyString('xxx'), '');
    end;

    [Test]
    procedure TestIsCharacterStringEmpty()
    begin
        // [SCENARIO #001] A character is a string with length 1
        // [GIVEN] Given an empty string
        // [WHEN] testing
        // [THEN] it is false

        Assert.IsFalse(FPFrStandardLibrary.IsCharacterString(''), '');
    end;

    [Test]
    procedure TestIsCharacterStringYes()
    begin
        // [SCENARIO #001] A character is a string with length 1
        // [GIVEN] Given a character
        // [WHEN] testing
        // [THEN] it is true

        Assert.IsTrue(FPFrStandardLibrary.IsCharacterString('X'), '');
    end;

    [Test]
    procedure TestIsCharacterStringNo()
    begin
        // [SCENARIO #001] A character is a string with length 1
        // [GIVEN] Given a longer string
        // [WHEN] testing
        // [THEN] it is false

        Assert.IsFalse(FPFrStandardLibrary.IsCharacterString('xxx'), '');
    end;

    [Test]
    procedure TestRegexCharacterClassEmpty()
    begin
        // [SCENARIO #001] A character class starts and ends with square brackets.
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', FPFrStandardLibrary.RegexCharacterClass(''), '');
    end;

    [Test]
    procedure TestRegexCharacterClass()
    begin
        // [SCENARIO #001] A character class starts and ends with square brackets.
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the string included in square brackets

        Assert.AreEqual('[xxx]', FPFrStandardLibrary.RegexCharacterClass('xxx'), '');
    end;

    [Test]
    procedure TestRegexDisjunction2()
    begin
        // [SCENARIO #001] Disjunction between two strings is marked by a pipe between the two.
        // [GIVEN] Given two non empty strings
        // [WHEN] creating a disjunction between the two
        // [THEN] it returns a string with a pipe between the two

        Assert.AreEqual('x|y', FPFrStandardLibrary.RegexDisjunction2('x', 'y'), '');
    end;

    [Test]
    procedure TestRegexDisjunction3()
    begin
        // [SCENARIO #001] Disjunction between three strings is marked by a pipe between the three.
        // [GIVEN] Given three non empty strings
        // [WHEN] creating a disjunction between the three
        // [THEN] it returns a string with a pipe between the three

        Assert.AreEqual('x|y|z', FPFrStandardLibrary.RegexDisjunction3('x', 'y', 'z'), '');
    end;

    [Test]
    procedure TestRegexOptionalEmpty()
    begin
        // [SCENARIO #001] A optional pattern is followed by a question mark
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', FPFrStandardLibrary.RegexOptional(''), '');
    end;

    [Test]
    procedure TestRegexOptionalChar()
    begin
        // [SCENARIO #001] A optional pattern is followed by a question mark
        // [GIVEN] Given a character
        // [WHEN] creating the pattern
        // [THEN] it returns the character followed by a question mark

        Assert.AreEqual('x?', FPFrStandardLibrary.RegexOptional('x'), '');
    end;

    [Test]
    procedure TestRegexOptionalString()
    begin
        // [SCENARIO #001] A optional pattern is followed by a question mark
        // [GIVEN] Given a longer string
        // [WHEN] creating the pattern
        // [THEN] it returns the string in parentheses followed by a question mark

        Assert.AreEqual('(xyz)?', FPFrStandardLibrary.RegexOptional('xyz'), '');
    end;

    [Test]
    procedure TestRegexZeroOrMoreEmpty()
    begin
        // [SCENARIO #001] Zero or more is indicated by a trailing asterisk
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', FPFrStandardLibrary.RegexZeroOrMore(''), '');
    end;

    [Test]
    procedure TestRegexZeroOrMoreChar()
    begin
        // [SCENARIO #001] Zero or more is indicated by a trailing asterisk
        // [GIVEN] Given a character
        // [WHEN] creating the pattern
        // [THEN] it returns the character followed by an asterisk


        Assert.AreEqual('x*', FPFrStandardLibrary.RegexZeroOrMore('x'), '');
    end;

    [Test]
    procedure TestRegexZeroOrMoreString()
    begin
        // [SCENARIO #001] Zero or more is indicated by a trailing asterisk
        // [GIVEN] Given a longer string
        // [WHEN] creating the pattern
        // [THEN] it returns the string in parentheses followed by an asterisk

        Assert.AreEqual('(xyz)*', FPFrStandardLibrary.RegexZeroOrMore('xyz'), '');
    end;

    [Test]
    procedure TestRegexOneOrMoreEmpty()
    begin
        // [SCENARIO #001] One or more is indicated by a trailing plus
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', FPFrStandardLibrary.RegexOneOrMore(''), '');
    end;

    [Test]
    procedure TestRegexOneOrMoreChar()
    begin
        // [SCENARIO #001] One or more is indicated by a trailing plus
        // [GIVEN] Given a character
        // [WHEN] creating the pattern
        // [THEN] it returns the character followed by a plus
        Assert.AreEqual('x+', FPFrStandardLibrary.RegexOneOrMore('x'), '');
    end;

    [Test]
    procedure TestRegexOneOrMoreString()
    begin
        // [SCENARIO #001] One or more is indicated by a trailing plus
        // [GIVEN] Given a longer string
        // [WHEN] creating the pattern
        // [THEN] it returns the string in parentheses followed by a plus

        Assert.AreEqual('(xyz)+', FPFrStandardLibrary.RegexOneOrMore('xyz'), '');
    end;

    [Test]
    procedure TestRegexNegationEmpty()
    begin
        // [SCENARIO #001] Negation is indicated by a preceding caret inside the square brackets
        // [GIVEN] Given an empty string
        // [WHEN] testing
        // [THEN] it returns an empty string

        Assert.AreEqual('', FPFrStandardLibrary.RegexNegation(''), '');
    end;

    [Test]
    procedure TestRegexNegation()
    begin
        // [SCENARIO #001] Negation is indicated by a preceding caret inside the square brackets
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the caret followed by the string, all included in square brackets

        Assert.AreEqual('[^xxx]', FPFrStandardLibrary.RegexNegation('xxx'), '');
    end;

    [Test]
    procedure TestRegexStartLineEmpty()
    begin
        // [SCENARIO #001] The annchor caret is used for finding patterns in the start of the line
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the caret

        Assert.AreEqual('^', FPFrStandardLibrary.RegexStartLine(''), '');
    end;

    [Test]
    procedure TestRegexStartLine()
    begin
        // [SCENARIO #001] The annchor caret is used for finding patterns in the start of the line
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the caret followed by the string

        Assert.AreEqual('^xxx', FPFrStandardLibrary.RegexStartLine('xxx'), '');
    end;

    [Test]
    procedure TestRegexEndLineEmpty()
    begin
        // [SCENARIO #001] The dollar is used for finding patterns in the end of the line
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the dollar sign

        Assert.AreEqual('$', FPFrStandardLibrary.RegexEndLine(''), '');
    end;

    [Test]
    procedure TestRegexEndLine()
    begin
        // [SCENARIO #001] The dollar is used for finding patterns in the end of the line
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the dollar sign followed by the string

        Assert.AreEqual('xxx$', FPFrStandardLibrary.RegexEndLine('xxx'), '');
    end;


    [Test]
    procedure TestRegexIsMatch()
    var
        Pattern: Text;
    begin
        // [SCENARIO #001] Testing pattern recognizion with iso 8601 datetime patterns
        // [GIVEN] Given correct iso 8601 datetime patterns
        // [WHEN] testing if the pattern is recognized
        // [THEN] it returns true

        // Documentation
        // https://www.regextester.com/112232
        // https://www.w3schools.com/xml/schema_dtypes_date.asp

        Pattern := '^(\d{4})-(\d{2})-(\d{2})((-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})|Z)?)$';
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-09-24', Pattern), 'Simple Date');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-09-24Z', Pattern), 'Date with UTC TimeZone');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-09-24-06:00', Pattern), 'Date with negative TimeZone');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-09-24+06:00', Pattern), 'Date with positive TimeZone');

        Pattern := '^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?)((-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})|Z)?)$';
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-05-30T09:00:00', Pattern), 'Simple DateTime');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-05-30T09:30:10.5', Pattern), 'DateTime with second fractions 1');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-05-30T09:30:10.56', Pattern), 'DateTime with second fractions 2');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-05-30T09:30:10.567', Pattern), 'DateTime with second fractions 3');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-05-30T09:30:10Z', Pattern), 'DateTime with UTC TimeZone');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-05-30T09:30:10-06:00', Pattern), 'DateTime with negative TimeZone');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('2002-05-30T09:30:10+06:00', Pattern), 'DateTime with positive TimeZone');

        Pattern := '^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$';
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('https://www.google.com', Pattern), 'Url checker');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('http://www.google.com', Pattern), 'Url checker');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('www.google.com', Pattern), 'Url checker');
        Assert.IsFalse(FPFrStandardLibrary.RegexIsMatch('htt://www.google.com', Pattern), 'Url checker');
        Assert.IsFalse(FPFrStandardLibrary.RegexIsMatch('://www.google.com', Pattern), 'Url checker');

        Pattern := '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('finnpedersenfrance@gmail.com', Pattern), 'Email checker');

        Pattern := '^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('(555)-555-5555', Pattern), 'US Phone number');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('555-555-5555', Pattern), 'US Phone number');
        Assert.IsTrue(FPFrStandardLibrary.RegexIsMatch('+1-555-532-3455', Pattern), 'US Phone number');
    end;

    [Test]
    procedure TestPatternPosition()
    var
        TotalPattern: Text;
    begin
        // PatternPosition(String: Text; Pattern: Text; var Position: Integer; var MatchedString: Text)
        Error('TestPatternPosition to be implemented.');
    end;

}
