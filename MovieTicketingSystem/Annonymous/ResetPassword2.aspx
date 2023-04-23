<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword2.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.ResetPassword2" %>


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
                    <i class="fa-solid fa-lock" style="width:10%;margin-top:30px"></i>
                    <div class="form-floating mb-3" id="float1" style="width:60%;">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                        <label for="txtPassword">New Password</label>
                    </div>
                <i id="passwordVisibility" class="fa-solid fa-eye-slash" onclick="togglePasswordVisibility()"  style="width:10%;margin-top:30px"></i>
                </div>
                <div class="row mt-2 justify-content-center">
                    <i class="fa-solid fa-lock" style="width:10%;margin-top:30px"></i>
                    <div class="form-floating mb-3" id="float2" style="width:60%;">
                        <asp:TextBox ID="txtCfmPassword" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                        <label for="txtCfmPassword">Confirm Password</label>
                    </div>
                <i id="passwordVisibility2" class="fa-solid fa-eye-slash" onclick="togglePasswordVisibility2()"  style="width:10%;margin-top:30px"></i>
                </div>
                <div class="text-center">
                    <asp:Button class="btn btn-default my-4 w-50" ID="btnToken" runat="server" Text="Reset Password" OnClick="btnToken_Click"/>
                </div>
            </div>
        </form>
    </div>
    <script>
        function togglePasswordVisibility() {
            var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            var iconPasswordVisibility = document.getElementById('passwordVisibility');

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                iconPasswordVisibility.classList.remove("fa-eye-slash");
                iconPasswordVisibility.classList.add("fa-eye");
            } else {
                passwordInput.type = "password";
                iconPasswordVisibility.classList.remove("fa-eye");
                iconPasswordVisibility.classList.add("fa-eye-slash");
            }
        }
        function togglePasswordVisibility2() {
            var passwordInput = document.getElementById('<%= txtCfmPassword.ClientID %>');
            var iconPasswordVisibility = document.getElementById('cfmpasswordVisibility');

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                iconPasswordVisibility.classList.remove("fa-eye-slash");
                iconPasswordVisibility.classList.add("fa-eye");
            } else {
                passwordInput.type = "password";
                iconPasswordVisibility.classList.remove("fa-eye");
                iconPasswordVisibility.classList.add("fa-eye-slash");
            }
        }
    </script>
</body>
</html>