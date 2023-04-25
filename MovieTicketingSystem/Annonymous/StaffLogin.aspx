<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffLogin.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.StaffLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <link rel="stylesheet" href="~/css/style.css">
</head>
<body style="min-height: 100vh;">
    <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit" async defer></script>
    <form id="form1" runat="server" style="min-height: 100vh;">
       <div id="content" class="text-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">
        <div class="bg-black rounded col-md-5 col-lg-3 col-sm-6">                  
            <div class="nav-link active flex-grow-1 loginTab p-3 text-center">Staff Login</div>    
            <div class="container-fluid">
                <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-user" style="width:10%;margin-top:30px"></i>
                    <div class="form-floating mb-3" style="width:60%;" id="float">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Email" />
                        <label for="txtEmail">Email</label>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter your email" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                <i style="width:10%;margin-top:30px"></i>
                </div>
                <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-lock" style="width:10%;margin-top:30px"></i>
                    <div class="form-floating mb-3 " style="width:60%;" id="float2">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password"/>
                        <label for="txtPassword">Password</label>
                        <asp:CustomValidator ID="cvLogin" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Invalid Email and Password" SetFocusOnError="true"></asp:CustomValidator>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter your password" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                <i id="passwordVisibility" class="fa-solid fa-eye-slash" onclick="togglePasswordVisibility()"  style="width:10%;margin-top:30px"></i>
                </div>
                <div id="googleRecaptcha" class="d-flex justify-content-center align-items-center" ></div>
                <div class="text-center">
                    <asp:CustomValidator ID="cvCaptcha" runat="server" CssClass="text-danger" ErrorMessage="Please retry the captcha challenge"></asp:CustomValidator>
                </div>
                <div class="checkbox mt-3 text-center">
                    <asp:Label ID="lblRemember" runat="server">
                        <asp:CheckBox ID="cbRemember" runat="server" /> Remember me
                    </asp:Label>
                </div>
                <div class="text-center">
                     <asp:Button class="btn btn-default w-50 mt-3" ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"/>
                </div>
                <div class="row text-center">
                    <asp:HyperLink CssClass="mt-2 mb-4 loginLink" ID="hlForgetpwd" runat="server" NavigateUrl="ResetPassword1.aspx">Forget Password?</asp:HyperLink>
                </div>
            </div>
        </div>
    </div>
    </form>
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
        var renderRecaptcha = function () {
            grecaptcha.render('googleRecaptcha', {
                'sitekey': '6LdtHKwlAAAAAN07Moo4spWHNegef1-5HSdjiBMl',
                'callback': reCaptchaCallback,
                theme: 'dark', 
                type: 'image',
                size: 'normal'
            });
        };
        var reCaptchaCallback = function (response) {
            if (response !== '') {
                document.getElementById('lblCaptcha').innerHTML = "";
            }
        };
    </script>
</body>
</html>
