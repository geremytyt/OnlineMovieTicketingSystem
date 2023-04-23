<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword1.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.ResetPassword" %>

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
    <div id="content" class="text-light d-flex align-items-center justify-content-center"  style="min-height: 100vh;">
        <form id="form1" class="col-lg-2 col-md-4 col-sm-6" runat="server">
            <div class="bg-black rounded ">
                <div class="nav-link active flex-grow-1 loginTab p-3 text-center">Reset Password</div> 
                    <div class="row mt-2 justify-content-center">
                        <i class="fa-solid fa-user" style="width:10%;margin-top:30px"></i>
                        <div class="form-floating" id="float" style="width:60%;">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control userInput" placeholder=" " />
                            <label for="txtEmail">Email</label>
                            <asp:CustomValidator ID="cvEmail" CssClass="text-danger" runat="server" ErrorMessage="Invalid Email" Display="Dynamic"></asp:CustomValidator>
                        </div>
                    </div>
                <div class="text-center">
                    <asp:Button class="btn btn-default my-4" ID="btnToken" runat="server" Text="Send Token" OnClick="btnToken_Click" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>