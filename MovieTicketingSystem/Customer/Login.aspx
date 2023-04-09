<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MovieTicketingSystem.View.Login" %>
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
            <div class="bg-black rounded" style="height:350px">
                <nav>
                    <div class="nav nav-tabs border-0"id="nav-tab" role="tablist">
                        <button class="nav-link active flex-grow-1" id="nav-userLogin-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-userLogin" type="button" role="tab" aria-controls="nav-userLogin"
                            aria-selected="true">User Login</button>
                        <button class="nav-link flex-grow-1" id="nav-staffLogin-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-staffLogin" type="button" role="tab" aria-controls="nav-staffLogin"
                            aria-selected="false">Staff Login</button>
                    </div>
                </nav>
                <div class="tab-content container-fluid" id="nav-tabContent">
                    <div class="tab-pane fade show active p-3" id="nav-userLogin" role="tabpanel" aria-labelledby="nav-userLogin-tab">
                        <div class="form-floating mb-3" id="float">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder=" " TextMode="Email" />
                            <label for="txtEmail">Email</label>
                        </div>
                        <div class="form-floating mb-3"  id="float2">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="txtPassword">Password</label>
                        </div>
                        <div class="checkbox">
                            <asp:Label ID="lblRemember" runat="server">
                                <asp:CheckBox ID="cbRemember" runat="server" />Remember me
                            </asp:Label>
                        </div>
                        <asp:Button class="btn btn-default mt-2 w-75" ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"/>
                        <div class="row">
                            <asp:HyperLink CssClass="mt-2 col-md-8" ID="hlForgetpwd" runat="server" NavigateUrl="ResetPassword1.aspx">Forget Password?</asp:HyperLink>
                            <asp:HyperLink CssClass="mt-2 col-md-4" ID="hlRegister" runat="server" NavigateUrl="Register.aspx">Register</asp:HyperLink>
                        </div>
                        </div>
                    <div class="tab-pane fade p-3" id="nav-staffLogin" role="tabpanel" aria-labelledby="nav-staff Login-tab">
                       <div class="form-floating mb-3" id="float3">
                            <asp:TextBox ID="txtEmail1" runat="server" CssClass="form-control" placeholder=" " TextMode="Email" />
                            <label for="txtEmail">Email</label>
                        </div>
                        <div class="form-floating mb-3"  id="float4">
                            <asp:TextBox ID="txtPassword1" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="txtPassword">Password</label>
                        </div>
                        <div class="checkbox">
                            <asp:Label ID="lblRemember1" runat="server">
                                <asp:CheckBox ID="cbRemember1" runat="server" />Remember me
                            </asp:Label>
                        </div>
                        <asp:Button class="btn btn-default mt-2 w-75" ID="btnStaffLogin" runat="server" Text="Login" OnClick="btnStaffLogin_Click"/>
                        <div class="row">
                            <asp:HyperLink CssClass="mt-2" ID="hlForgetpwd1" runat="server" NavigateUrl="ResetPassword1.aspx">Forget Password?</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
