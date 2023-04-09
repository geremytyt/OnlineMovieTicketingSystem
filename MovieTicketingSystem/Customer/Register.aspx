<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MovieTicketingSystem.View.Register" %>

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
        <div class="bg-black rounded-4 mx-auto col-md-12" style="height:550px">
            <h5 class="pt-3">Register</h5>
            <hr class="mx-2" style="border: 1px solid white"/>
            <div class="form-floating mx-5" id="float">
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder=" " />
                <label for="txtName">Name</label>
            </div>
            <div class="form-floating mx-5" id="float1">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder=" " TextMode="Email" />
                <label for="txtEmail">Email</label>
            </div>
            <div class="form-floating mx-5" id="float2">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                <label for="txtPassword">Password</label>
            </div>
            <div class="form-floating mx-5" id="float3">
                <asp:TextBox ID="txtCfmPassword" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                <label for="txtCfmPassword">Password</label>
            </div>
            <div class="form-floating mx-5" id="float4">
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder=" " TextMode="Phone" />
                <label for="txtPhone">Phone No</label>
            </div>
            <div class="form-floating mx-5" id="float5">
                <asp:TextBox ID="txtDob" runat="server" CssClass="form-control" placeholder=" " TextMode="Date" />
                <label for="txtDob">Date Of Birth</label>
            </div>
            <div class="row my-3 align-items-center justify-content-center">
                <div class="w-25">
                    <asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
                </div>
                <div class="w-50">
                    <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="100%">
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <asp:Button class="btn btn-default mt-2 w-75" ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click"/>

            </div>
        </form>
    </div>
</body>
</html>
