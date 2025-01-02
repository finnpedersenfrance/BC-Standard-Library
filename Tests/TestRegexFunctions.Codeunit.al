namespace FinnPedersenFrance.Tools.Library;

codeunit 50138 "Test Regex Functions"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

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

        Assert.IsTrue(StandardLibrary.IsEmptyString(''), '');
    end;

    [Test]
    procedure TestIsEmptyStringNo()
    begin
        // [SCENARIO #001] Is string empty or not
        // [GIVEN] Given a non empty string
        // [WHEN] testing
        // [THEN] it is false

        Assert.IsFalse(StandardLibrary.IsEmptyString('xxx'), '');
    end;

    [Test]
    procedure TestIsCharacterStringEmpty()
    begin
        // [SCENARIO #001] A character is a string with length 1
        // [GIVEN] Given an empty string
        // [WHEN] testing
        // [THEN] it is false

        Assert.IsFalse(StandardLibrary.IsCharacterString(''), '');
    end;

    [Test]
    procedure TestIsCharacterStringYes()
    begin
        // [SCENARIO #001] A character is a string with length 1
        // [GIVEN] Given a character
        // [WHEN] testing
        // [THEN] it is true

        Assert.IsTrue(StandardLibrary.IsCharacterString('X'), '');
    end;

    [Test]
    procedure TestIsCharacterStringNo()
    begin
        // [SCENARIO #001] A character is a string with length 1
        // [GIVEN] Given a longer string
        // [WHEN] testing
        // [THEN] it is false

        Assert.IsFalse(StandardLibrary.IsCharacterString('xxx'), '');
    end;

    [Test]
    procedure TestRegexIsCharacterStringSpecial()
    begin
        // [SCENARIO #001] A character is a string with length 1
        // [GIVEN] Given a character
        // [WHEN] testing
        // [THEN] it is true

        Assert.IsTrue(StandardLibrary.RegexIsCharacterString('\d'), '');
    end;

    [Test]
    procedure TestRegexCharacterClassEmpty()
    begin
        // [SCENARIO #001] A character class starts and ends with square brackets.
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', StandardLibrary.RegexCharacterClass(''), '');
    end;

    [Test]
    procedure TestRegexCharacterClass()
    begin
        // [SCENARIO #001] A character class starts and ends with square brackets.
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the string included in square brackets

        Assert.AreEqual('[xxx]', StandardLibrary.RegexCharacterClass('xxx'), '');
    end;

    [Test]
    procedure TestRegexGroup()
    begin
        // [SCENARIO #001] A group starts and ends with brackets.
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the string included in brackets

        Assert.AreEqual('(xxx)', StandardLibrary.RegexGroup('xxx'), '');
    end;

    [Test]
    procedure TestRegexGroupEmpty()
    begin
        // [SCENARIO #001] A group starts and ends with brackets.
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the empty string

        Assert.AreEqual('', StandardLibrary.RegexGroup(''), '');
    end;

    [Test]
    procedure TestRegexDisjunction2()
    begin
        // [SCENARIO #001] Disjunction between two strings is marked by a pipe between the two.
        // [GIVEN] Given two non empty strings
        // [WHEN] creating a disjunction between the two
        // [THEN] it returns a string with a pipe between the two

        Assert.AreEqual('x|y', StandardLibrary.RegexDisjunction2('x', 'y'), '');
    end;

    [Test]
    procedure TestRegexDisjunction2Empty()
    begin
        // [SCENARIO #001] Disjunction between two strings is marked by a pipe between the two.
        // [GIVEN] Given one or two empty strings
        // [WHEN] creating a disjunction between the two
        // [THEN] it returns the non empty string or in case they both are empty an empty string

        Assert.AreEqual('x', StandardLibrary.RegexDisjunction2('x', ''), '');
        Assert.AreEqual('y', StandardLibrary.RegexDisjunction2('', 'y'), '');
        Assert.AreEqual('', StandardLibrary.RegexDisjunction2('', ''), '');
    end;

    [Test]
    procedure TestRegexDisjunction3()
    begin
        // [SCENARIO #001] Disjunction between three strings is marked by a pipe between the three.
        // [GIVEN] Given three non empty strings
        // [WHEN] creating a disjunction between the three
        // [THEN] it returns a string with a pipe between the three

        Assert.AreEqual('x|y|z', StandardLibrary.RegexDisjunction3('x', 'y', 'z'), '');
    end;

    [Test]
    procedure TestRegexDisjunction3Empty()
    begin
        // [SCENARIO #001] Disjunction between three strings is marked by a pipe between the three.
        // [GIVEN] Given one, two or three empty strings
        // [WHEN] creating a disjunction between the three
        // [THEN] it ignores the empty strings

        Assert.AreEqual('x|y', StandardLibrary.RegexDisjunction3('x', 'y', ''), '');
        Assert.AreEqual('x|z', StandardLibrary.RegexDisjunction3('x', '', 'z'), '');
        Assert.AreEqual('y|z', StandardLibrary.RegexDisjunction3('', 'y', 'z'), '');
        Assert.AreEqual('x', StandardLibrary.RegexDisjunction3('x', '', ''), '');
        Assert.AreEqual('y', StandardLibrary.RegexDisjunction3('', 'y', ''), '');
        Assert.AreEqual('z', StandardLibrary.RegexDisjunction3('', '', 'z'), '');
        Assert.AreEqual('', StandardLibrary.RegexDisjunction3('', '', ''), '');
    end;

    [Test]
    procedure TestRegexOptionalEmpty()
    begin
        // [SCENARIO #001] A optional pattern is followed by a question mark
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', StandardLibrary.RegexOptional(''), '');
    end;

    [Test]
    procedure TestRegexOptionalChar()
    begin
        // [SCENARIO #001] A optional pattern is followed by a question mark
        // [GIVEN] Given a character
        // [WHEN] creating the pattern
        // [THEN] it returns the character followed by a question mark

        Assert.AreEqual('x?', StandardLibrary.RegexOptional('x'), '');
    end;

    [Test]
    procedure TestRegexOptionalString()
    begin
        // [SCENARIO #001] A optional pattern is followed by a question mark
        // [GIVEN] Given a longer string
        // [WHEN] creating the pattern
        // [THEN] it returns the string in parentheses followed by a question mark

        Assert.AreEqual('(xyz)?', StandardLibrary.RegexOptional('xyz'), '');
    end;

    [Test]
    procedure TestRegexZeroOrMoreEmpty()
    begin
        // [SCENARIO #001] Zero or more is indicated by a trailing asterisk
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', StandardLibrary.RegexZeroOrMore(''), '');
    end;

    [Test]
    procedure TestRegexZeroOrMoreChar()
    begin
        // [SCENARIO #001] Zero or more is indicated by a trailing asterisk
        // [GIVEN] Given a character
        // [WHEN] creating the pattern
        // [THEN] it returns the character followed by an asterisk

        Assert.AreEqual('x*', StandardLibrary.RegexZeroOrMore('x'), '');
    end;

    [Test]
    procedure TestRegexZeroOrMoreString()
    begin
        // [SCENARIO #001] Zero or more is indicated by a trailing asterisk
        // [GIVEN] Given a longer string
        // [WHEN] creating the pattern
        // [THEN] it returns the string in parentheses followed by an asterisk

        Assert.AreEqual('(xyz)*', StandardLibrary.RegexZeroOrMore('xyz'), '');
    end;

    [Test]
    procedure TestRegexOneOrMoreEmpty()
    begin
        // [SCENARIO #001] One or more is indicated by a trailing plus
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns an empty string

        Assert.AreEqual('', StandardLibrary.RegexOneOrMore(''), '');
    end;

    [Test]
    procedure TestRegexOneOrMoreChar()
    begin
        // [SCENARIO #001] One or more is indicated by a trailing plus
        // [GIVEN] Given a character
        // [WHEN] creating the pattern
        // [THEN] it returns the character followed by a plus
        Assert.AreEqual('x+', StandardLibrary.RegexOneOrMore('x'), '');
    end;

    [Test]
    procedure TestRegexOneOrMoreString()
    begin
        // [SCENARIO #001] One or more is indicated by a trailing plus
        // [GIVEN] Given a longer string
        // [WHEN] creating the pattern
        // [THEN] it returns the string in parentheses followed by a plus

        Assert.AreEqual('(xyz)+', StandardLibrary.RegexOneOrMore('xyz'), '');
    end;

    [Test]
    procedure TestRegexNegationEmpty()
    begin
        // [SCENARIO #001] Negation is indicated by a preceding caret inside the square brackets
        // [GIVEN] Given an empty string
        // [WHEN] testing
        // [THEN] it returns an empty string

        Assert.AreEqual('', StandardLibrary.RegexNegation(''), '');
    end;

    [Test]
    procedure TestRegexNegation()
    begin
        // [SCENARIO #001] Negation is indicated by a preceding caret inside the square brackets
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the caret followed by the string, all included in square brackets

        Assert.AreEqual('[^xxx]', StandardLibrary.RegexNegation('xxx'), '');
    end;

    [Test]
    procedure TestRegexStartLineEmpty()
    begin
        // [SCENARIO #001] The annchor caret is used for finding patterns in the start of the line
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the caret

        Assert.AreEqual('^', StandardLibrary.RegexStartLine(''), '');
    end;

    [Test]
    procedure TestRegexStartLine()
    begin
        // [SCENARIO #001] The annchor caret is used for finding patterns in the start of the line
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the caret followed by the string

        Assert.AreEqual('^xxx', StandardLibrary.RegexStartLine('xxx'), '');
    end;

    [Test]
    procedure TestRegexStartLineAlready()
    begin
        // [SCENARIO #001] The annchor caret is used for finding patterns in the start of the line
        // [GIVEN] Given a non empty pattern matching the beginning of a line
        // [WHEN] creating the pattern
        // [THEN] it returns the same string

        Assert.AreEqual('^xxx', StandardLibrary.RegexStartLine('^xxx'), '');
    end;

    [Test]
    procedure TestRegexEndLineEmpty()
    begin
        // [SCENARIO #001] The dollar is used for finding patterns in the end of the line
        // [GIVEN] Given an empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the dollar sign

        Assert.AreEqual('$', StandardLibrary.RegexEndLine(''), '');
    end;

    [Test]
    procedure TestRegexEndLine()
    begin
        // [SCENARIO #001] The dollar is used for finding patterns in the end of the line
        // [GIVEN] Given a non empty string
        // [WHEN] creating the pattern
        // [THEN] it returns the dollar sign followed by the string

        Assert.AreEqual('xxx$', StandardLibrary.RegexEndLine('xxx'), '');
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

        Pattern := '^(\d{4})-(\d{2})-(\d{2})(T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?))?((-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})|Z)?)$';
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-09-24', Pattern), 'Simple Date');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-09-24Z', Pattern), 'Date with UTC TimeZone');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-09-24-06:00', Pattern), 'Date with negative TimeZone');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-09-24+06:00', Pattern), 'Date with positive TimeZone');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-05-30T09:00:00', Pattern), 'Simple DateTime');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-05-30T09:30:10.5', Pattern), 'DateTime with second fractions 1');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-05-30T09:30:10.56', Pattern), 'DateTime with second fractions 2');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-05-30T09:30:10.567', Pattern), 'DateTime with second fractions 3');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-05-30T09:30:10Z', Pattern), 'DateTime with UTC TimeZone');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-05-30T09:30:10-06:00', Pattern), 'DateTime with negative TimeZone');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('2002-05-30T09:30:10+06:00', Pattern), 'DateTime with positive TimeZone');

        Pattern := '^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$';
        Assert.IsTrue(StandardLibrary.RegexIsMatch('https://www.google.com', Pattern), 'Url checker');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('http://www.google.com', Pattern), 'Url checker');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('www.google.com', Pattern), 'Url checker');
        Assert.IsFalse(StandardLibrary.RegexIsMatch('htt://www.google.com', Pattern), 'Url checker');
        Assert.IsFalse(StandardLibrary.RegexIsMatch('://www.google.com', Pattern), 'Url checker');

        Pattern := '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
        Pattern := '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // Calculated by ChatGPT
        Assert.IsTrue(StandardLibrary.RegexIsMatch('finnpedersenfrance@gmail.com', Pattern), 'Email checker');

        Pattern := '^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';
        Assert.IsTrue(StandardLibrary.RegexIsMatch('(555)-555-5555', Pattern), 'US Phone number');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('555-555-5555', Pattern), 'US Phone number');
        Assert.IsTrue(StandardLibrary.RegexIsMatch('+1-555-532-3455', Pattern), 'US Phone number');
    end;

    [Test]
    procedure TestPatternPositionTime()
    var
        Position: Integer;
        MatchedString: Text;
        Pattern: Text;
        String: Text;
    begin
        // [SCENARIO #001] Finding a pattern in a string and bringing back the position and the substring matching the pattern
        // [GIVEN] Given correct iso 8601 datetime string
        // [WHEN] searching for the time
        // [THEN] it returns the time

        String := '2002-05-30T09:30:10+06:00';
        Pattern := 'T\d{2}:\d{2}:\d{2}';
        StandardLibrary.PatternPosition(String, Pattern, Position, MatchedString);
        Assert.AreEqual(11, Position, '');
        Assert.AreEqual('T09:30:10', MatchedString, '');
    end;

    [Test]
    procedure TestPatternPositionTimeZonePlus()
    var
        Position: Integer;
        MatchedString: Text;
        Pattern: Text;
        String: Text;
    begin
        // [SCENARIO #001] Finding a pattern in a string and bringing back the position and the substring matching the pattern
        // [GIVEN] Given correct iso 8601 datetime string
        // [WHEN] searching for the time
        // [THEN] it returns the time

        String := '2002-05-30T09:30:10+06:00';
        Pattern := '(-|\+)\d{2}:\d{2}';
        StandardLibrary.PatternPosition(String, Pattern, Position, MatchedString);
        Assert.AreEqual(20, Position, '');
        Assert.AreEqual('+06:00', MatchedString, '');
    end;

    [Test]
    procedure TestPatternPositionTimeZoneMinus()
    var
        Position: Integer;
        MatchedString: Text;
        Pattern: Text;
        String: Text;
    begin
        // [SCENARIO #001] Finding a pattern in a string and bringing back the position and the substring matching the pattern
        // [GIVEN] Given correct iso 8601 datetime string
        // [WHEN] searching for the time
        // [THEN] it returns the time

        String := '2002-05-30T09:30:10-06:00';
        Pattern := '(-|\+)\d{2}:\d{2}';
        StandardLibrary.PatternPosition(String, Pattern, Position, MatchedString);
        Assert.AreEqual(20, Position, '');
        Assert.AreEqual('-06:00', MatchedString, '');
    end;

    [Test]
    procedure TestPatternPositionDate()
    var
        Position: Integer;
        MatchedString: Text;
        Pattern: Text;
        String: Text;
    begin
        // [SCENARIO #001] Finding a pattern in a string and bringing back the position and the substring matching the pattern
        // [GIVEN] Given correct iso 8601 datetime string
        // [WHEN] searching for the date
        // [THEN] it returns the date

        String := '2002-05-30T09:30:10+06:00';
        Pattern := '\d{4}-\d{2}-\d{2}';
        StandardLibrary.PatternPosition(String, Pattern, Position, MatchedString);
        Assert.AreEqual(1, Position, '');
        Assert.AreEqual('2002-05-30', MatchedString, '');
    end;

    [Test]
    procedure TestPatternPositionEmptyString()
    var
        Position: Integer;
        MatchedString: Text;
        Pattern: Text;
        String: Text;
    begin
        // [SCENARIO #001] Finding a pattern in a string and bringing back the position and the substring matching the pattern
        // [GIVEN] Given correct iso 8601 datetime string
        // [WHEN] searching for the date
        // [THEN] it returns the date

        String := '';
        Pattern := '\d{4}-\d{2}-\d{2}';
        StandardLibrary.PatternPosition(String, Pattern, Position, MatchedString);
        Assert.AreEqual(0, Position, '');
        Assert.AreEqual('', MatchedString, '');
    end;

    [Test]
    procedure TestPatternPositionEmptyPattern()
    var
        Position: Integer;
        MatchedString: Text;
        Pattern: Text;
        String: Text;
    begin
        // [SCENARIO #001] Finding a pattern in a string and bringing back the position and the substring matching the pattern
        // [GIVEN] Given correct iso 8601 datetime string
        // [WHEN] searching for the date
        // [THEN] it returns the date

        String := '2002-05-30T09:30:10+06:00';
        Pattern := '';
        StandardLibrary.PatternPosition(String, Pattern, Position, MatchedString);
        Assert.AreEqual(0, Position, '');
        Assert.AreEqual('', MatchedString, '');
    end;

    [Test]
    procedure TestRegexXOrMore()
    begin
        Assert.AreEqual('xxx{3,}', StandardLibrary.RegexXOrMore('xxx', 3), '');
    end;

    [Test]
    procedure TestRegexExactly()
    begin
        Assert.AreEqual('xxx{3}', StandardLibrary.RegexExactly('xxx', 3), '');
    end;

    [Test]
    procedure TestRegexInterval()
    begin
        Assert.AreEqual('xxx{3,5}', StandardLibrary.RegexInterval('xxx', 3, 5), '');
    end;

    [Test]
    procedure TestRegexPassiveGroup()
    begin
        Assert.AreEqual('(?:xxx)', StandardLibrary.RegexPassiveGroup('xxx'), '');
    end;

    [Test]
    procedure TestRegexDigit()
    begin
        Assert.AreEqual('\d', StandardLibrary.RegexDigit(), '');
    end;

    [Test]
    procedure TestRegexPlus()
    begin
        Assert.AreEqual('\+', StandardLibrary.RegexPlus(), '');
    end;

    [Test]
    procedure TestRegexDecimalPoint()
    begin
        Assert.AreEqual('\.', StandardLibrary.RegexDecimalPoint(), '');
    end;

    [Test]
    procedure TestRegexAnyChar()
    begin
        Assert.AreEqual('.', StandardLibrary.RegexAnyChar(), '');
    end;

    procedure DigitGroup(Number: Integer) Pattern: Text
    begin
        Pattern := StandardLibrary.RegexGroup(StandardLibrary.RegexExactly(StandardLibrary.RegexDigit(), Number));
    end;

    [Test]
    procedure TestPatternBuilding()
    var
        DatePattern: Text;
        ExpectedPattern: Text;
        FractionPattern: Text;
        Pattern: Text;
        TimePattern: Text;
        ZonePattern: Text;
    begin
        // [SCENARIO #001] Finding a pattern in a string and bringing back the position and the substring matching the pattern
        // [GIVEN] Given correct iso 8601 datetime string
        // [WHEN] searching for the date
        // [THEN] it returns the date

        ExpectedPattern := '^(\d{4})-(\d{2})-(\d{2})(T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?))?((-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})|Z)?)$';

        DatePattern := DigitGroup(4) + '-' + DigitGroup(2) + '-' + DigitGroup(2); // (\d{4})-(\d{2})-(\d{2})
        TimePattern := 'T' + DigitGroup(2) + ':' + DigitGroup(2) + ':'; // T(\d{2}):(\d{2}):

        FractionPattern := StandardLibrary.RegexDecimalPoint() + StandardLibrary.RegexZeroOrMore(StandardLibrary.RegexDigit()); // \.\d*
        FractionPattern := StandardLibrary.RegexPassiveGroup(FractionPattern); // (?:\.\d*)
        FractionPattern := StandardLibrary.RegexOptional(FractionPattern); // (?:\.\d*)?
        FractionPattern := StandardLibrary.RegexExactly(StandardLibrary.RegexDigit(), 2) + FractionPattern; // \d{2}(?:\.\d*)?
        FractionPattern := StandardLibrary.RegexGroup(FractionPattern); // (\d{2}(?:\.\d*)?)

        ZonePattern := StandardLibrary.RegexGroup(
                                    StandardLibrary.RegexOptional(
                                        StandardLibrary.RegexDisjunction3(
                                            '-' + DigitGroup(2) + ':' + DigitGroup(2),
                                            StandardLibrary.RegexPlus() + DigitGroup(2) + ':' + DigitGroup(2),
                                            'Z'))); // ((-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})|Z)?)

        TimePattern := TimePattern + FractionPattern;
        TimePattern := StandardLibrary.RegexOptional(TimePattern);

        Pattern := DatePattern + TimePattern + ZonePattern;
        Pattern := StandardLibrary.RegexEndLine(Pattern);
        Pattern := StandardLibrary.RegexStartLine(Pattern);

        Assert.AreEqual(ExpectedPattern, Pattern, '');
    end;

    [Test]
    procedure TestXmlDateTimeRegex()
    var
        isValidDateTime: Boolean;
        Pattern: Text;
    begin
        Pattern := '^((\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(Z|([+-])(\d{2}):(\d{2})))$';
        Pattern := '^(\d{4})-(\d{2})-(\d{2})(T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?))?((-(\d{2}):(\d{2})|\+(\d{2}):(\d{2})|Z)?)$';

        // Test a valid XML datetime string in UTC time zone
        isValidDateTime := StandardLibrary.RegexIsMatch('2022-02-19T14:30:00Z', Pattern);
        Assert.IsTrue(isValidDateTime, 'Valid XML datetime string in UTC time zone was marked as invalid.');

        // Test a valid XML datetime string in a positive time offset
        isValidDateTime := StandardLibrary.RegexIsMatch('2022-02-19T14:30:00+05:00', Pattern);
        Assert.IsTrue(isValidDateTime, 'Valid XML datetime string in a positive time offset was marked as invalid.');

        // Test a valid XML datetime string in a negative time offset
        isValidDateTime := StandardLibrary.RegexIsMatch('2022-02-19T14:30:00-08:00', Pattern);
        Assert.IsTrue(isValidDateTime, 'Valid XML datetime string in a negative time offset was marked as invalid.');

        // Test a valid XML datetime string with fractional seconds
        isValidDateTime := StandardLibrary.RegexIsMatch('2022-02-19T14:30:00.123Z', Pattern);
        Assert.IsTrue(isValidDateTime, 'Valid XML datetime string with fractional seconds was marked as invalid.');

        // Test a valid XML datetime string with positive fractional seconds and a positive time offset
        isValidDateTime := StandardLibrary.RegexIsMatch('2022-02-19T14:30:00.123+05:00', Pattern);
        Assert.IsTrue(isValidDateTime, 'Valid XML datetime string with positive fractional seconds and a positive time offset was marked as invalid.');

        // Test a valid XML datetime string with negative fractional seconds and a negative time offset
        isValidDateTime := StandardLibrary.RegexIsMatch('2022-02-19T14:30:00.987-08:00', Pattern);
        Assert.IsTrue(isValidDateTime, 'Valid XML datetime string with negative fractional seconds and a negative time offset was marked as invalid.');

        // Test an empty string
        isValidDateTime := StandardLibrary.RegexIsMatch('', Pattern);
        Assert.IsFalse(isValidDateTime, 'Empty string was marked as valid XML datetime string.');
    end;

    [Test]
    procedure TestRegexIsMatchInvalidPattern()
    var
        Pattern: Text;
    begin
        // [SCENARIO #002] Testing pattern recognizion with invalid pattern
        // [GIVEN] Given an invalid pattern
        // [WHEN] testing if the pattern is recognized
        // [THEN] it returns false

        Pattern := '^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$';
        Assert.IsFalse(StandardLibrary.RegexIsMatch('invalid_pattern', Pattern), 'Invalid pattern should not be recognized.');
    end;
}
