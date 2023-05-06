<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="500Error.aspx.cs" Inherits="MovieTicketingSystem.ErrorPages._500Error_" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <link rel="stylesheet" href="~/css/style.css">
</head>
<body style="background-color:#343a40;">
    <form id="form1" runat="server">
    <div class="container text-white mt-5" style='font-family:Calibri; padding: 5px 5px 5px 5px; min-height:90vh'>
        <h1>Error 500 - Internal Server Error</h1>
        <h2>We apologize for the inconvenience. An internal server error has occurred.</h2>
        <br /><br />
        <h3>Here are some steps you can try to resolve the issue:</h3>
        <ul>
            <li>Check the server logs for more detailed error information.</li>
            <li>Contact the website administrator or technical support for assistance.</li>
        </ul>
            <asp:Button ID="Button1" runat="server" Text="Go back" CssClass="btn btn-default" OnClick="Button1_Click"/>
    </div>
    </form>
</body>
