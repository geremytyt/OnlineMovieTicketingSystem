<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginControl.ascx.cs" Inherits="MovieTicketingSystem.User_Control.LoginControl" %>
<div class="container-fluid">
    <div class="row mt-2 justify-content-center">
    <i class="fa-solid fa-user" style="width:10%;margin-top:30px"></i>
        <div class="form-floating mb-3" style="width:60%;" id="float">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Email" />
            <label for="txtEmail">Email</label>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter your email"></asp:RequiredFieldValidator>
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
    <asp:Label ID="lblCaptcha" runat="server"></asp:Label>
    <div class="checkbox mt-3 text-center">
        <asp:Label ID="lblRemember" runat="server">
            <asp:CheckBox ID="cbRemember" runat="server" /> Remember me
        </asp:Label>
    </div>
    <div class="text-center">
        <asp:Button class="btn btn-default w-50 mt-3 " ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"/>
    </div>
    <div class="text-center">
        <asp:HyperLink CssClass="mt-2 loginLink" ID="hlForgetpwd" runat="server" NavigateUrl="ResetPassword1.aspx">Forget Password?</asp:HyperLink>
    </div>
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