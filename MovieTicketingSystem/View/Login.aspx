<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MovieTicketingSystem.View.Login" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Web Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous"/>
    <link rel="stylesheet" href="~/css/style.css"/>
</head>
<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <div id="content" class="text-center text-light d-flex align-items-center">
        <div class="bg-black rounded align-middle col-md-4 mx-auto">
            <form id="form1" runat="server">
                <h1 class="h3 my-3" style="color:white;">Login</h1>
                <hr />
                <div class="form-group mx-5 mt-5 mb-3">
                    <asp:TextBox class="form-control" ID="txtEmail" runat="server" placeholder="Enter your email"></asp:TextBox>
                </div>
                <div class="form-group mx-5 my-3">
                    <asp:TextBox class="form-control" ID="txtPassword" runat="server" TextMode="Password"  placeholder="Enter your password"></asp:TextBox>
                </div>
                <div class="checkbox">
                    <asp:Label ID="lblRemember" runat="server">
                        <asp:CheckBox  ID="cbRemember" runat="server" />Remember me
                    </asp:Label>
                </div>
                <asp:Button class="btn btn-default btn-block w-50 mt-2" ID="btnSubmit" runat="server" Text="Submit"/>
                <div class="row">
                    <asp:HyperLink CssClass="mt-2" ID="hlRegister" runat="server">Register</asp:HyperLink>
                    <asp:HyperLink CssClass="mt-2 mb-3" ID="hlForgetpwd" runat="server">Forget Password</asp:HyperLink>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
