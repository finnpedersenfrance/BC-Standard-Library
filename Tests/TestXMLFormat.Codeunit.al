namespace FinnPedersenFrance.Tools.Library;

codeunit 50134 "Test XML Format"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        StandardLibrary: Codeunit "Standard Library";

    trigger OnRun()
    begin
        // [FEATURE] Format and Evaluation of XML Inputvalues
    end;

    [Test]
    procedure TestXMLFormatDecimal()
    begin
        // [SCENARIO #001] Formating decimal
        // [GIVEN] decimal
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('1.234', StandardLibrary.XMLFormat(1.234), '');
    end;

    [Test]
    procedure TestXMLFormatDate()
    begin
        // [SCENARIO #002] Formating date
        // [GIVEN] date
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('2023-01-20', StandardLibrary.XMLFormat(DMY2Date(20, 1, 2023)), '');
    end;

    [Test]
    procedure TestXMLFormatTime()
    begin
        // [SCENARIO #003] Formating time
        // [GIVEN] time
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('12:34:56', StandardLibrary.XMLFormat(123456T), '');
    end;

    [Test]
    procedure TestXMLFormatDateTime()
    begin
        // [SCENARIO #004] Formating datetime
        // [GIVEN] datetime
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('2023-01-20T12:34:56', StandardLibrary.XMLFormat(CreateDateTime(DMY2Date(20, 1, 2023), 123456T)), '');
    end;

    [Test]
    procedure TestXMLFormatInteger()
    begin
        // [SCENARIO #005] Formating integer
        // [GIVEN] integer
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('7', StandardLibrary.XMLFormat(7), '');
    end;

    [Test]
    procedure TestXMLFormatBigInteger()
    begin
        // [SCENARIO #006] Formating big integer
        // [GIVEN] the maximum value for a 64-bit signed integer 2^63-1
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('9223372036854775807', StandardLibrary.XMLFormat(9223372036854775807L), '');
    end;

    [Test]
    procedure TestXMLFormatTrue()
    begin
        // [SCENARIO #007] Formating boolean
        // [GIVEN] true
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('true', StandardLibrary.XMLFormat(true), '');
    end;

    [Test]
    procedure TestXMLFormatFalse()
    begin
        // [SCENARIO #008] Formating boolean
        // [GIVEN] false
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('false', StandardLibrary.XMLFormat(false), '');
    end;

    [Test]
    procedure TestXMLFormatGUID()
    var
        CodeGUID: Guid;
        TextGUID: Text;
    begin
        // [SCENARIO #009] Formating GUID
        // [GIVEN] a new GUID
        // [WHEN] formating
        // [THEN] correct XML string

        CodeGUID := System.CreateGuid();
        TextGUID := CodeGUID;
        Assert.AreEqual(TextGUID, StandardLibrary.XMLFormat(CodeGUID), '');
    end;

    [Test]
    procedure TestXMLFormatEnum()
    var
        CustomerBlocked: Enum Microsoft.Sales.Customer."Customer Blocked";
    begin
        // [SCENARIO #009] Formating Enum
        // [GIVEN] a new Enum
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('2', StandardLibrary.XMLFormat(CustomerBlocked::Invoice), '');
    end;

    [Test]
    procedure TestXMLFormatNullValue()
    begin
        // [SCENARIO #010] Formating null value
        // [GIVEN] null value
        // [WHEN] formating
        // [THEN] correct XML string

        Assert.AreEqual('', StandardLibrary.XMLFormat(''), '');
    end;
}
