<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MovieTicketingSystem.View.Register" %>

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
    <div id="content" class="text-center text-light align-items-center justify-content-center">
        <div class="bg-black rounded col-md-4 mx-auto">
            <form id="form1" runat="server">
                <h1 class="h3" style="color:white;">Register</h1>
                <hr />
                <div class="form-group mx-5 my-3">
                    <asp:TextBox class="form-control" ID="txtName" runat="server" placeholder="Enter your name"></asp:TextBox>
                </div>
                <div class="form-group mx-5 my-3">
                    <asp:TextBox class="form-control" ID="txtEmail" runat="server" placeholder="Enter your email"></asp:TextBox>
                </div>
                <div class="form-group mx-5 my-3">
                    <asp:TextBox class="form-control" ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                </div>
                <div class="form-group mx-5 my-3">  
                    <asp:TextBox class="form-control" ID="txtlblPassword" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                </div>
                <div class="form-group mx-5 my-3">
                    <asp:TextBox class="form-control" ID="txtPhone" runat="server" TextMode="Phone" placeholder="Enter your phone"></asp:TextBox>
                </div>
                <div class="form-group mx-5 my-3">
                    <asp:TextBox class="form-control" ID="txtDob" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <div class="row mx-4 my-3">  
                    <div class="col-md-4">
                        <asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
                    </div>
                    <div class="col-md-8">
                        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2"
                        Width="100%">
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <asp:Button class="btn btn-default btn-block w-50 my-3 d-inline-block" ID="btnRegister" runat="server" Text="Register"/>
            </form>
        </div>
    </div>
</body>
</html>
