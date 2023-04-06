<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword2.aspx.cs" Inherits="MovieTicketingSystem.View.ResetPassword2" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Web Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous"/>
    <link rel="stylesheet" href="~/css/style.css"/>
</head>
<body style="height:100vh">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <div id="content" class="text-center text-light d-flex align-items-center justify-content-center">
        <form id="form1" runat="server">
            <div class="bg-black rounded" style="height:325px">
                <h5 class="pt-3">Reset Password</h5>
                <hr class="mx-2" style="border: 1px solid white"/>
                <div class="form-floating mx-5 mb-3" id="float1">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                    <label for="txtPassword">Password</label>
                </div>
                <div class="form-floating mx-5 mb-3" id="float2">
                    <asp:TextBox ID="txtCfmPassword" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                    <label for="txtCfmPassword">Confirm Password</label>
                </div>
                <asp:Button class="btn btn-default mt-4 w-50" ID="btnToken" runat="server" Text="Reset Password" OnClick="btnToken_Click"/>
            </div>
        </form>
    </div>
</body>
</html>