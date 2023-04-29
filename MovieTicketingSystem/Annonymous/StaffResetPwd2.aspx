<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffResetPwd2.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.StaffResetPwd2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
<div id="content" class="text-light d-flex align-items-center justify-content-center"  style="min-height: 100vh;">
        <div class="bg-black rounded col-md-5 col-lg-3 col-sm-6">     
            <div class="nav-link active flex-grow-1 loginTab p-3 text-center">Reset Password</div> 
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-lock" style="width:10%;margin-top:30px"></i>
                <div class="form-floating mb-3" id="float1" style="width:60%;">
                    <asp:TextBox ID="txtNewPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" onInput="updateStrength()"/>
                    <label for="txtNewPwd">New Password</label>
                    <asp:RequiredFieldValidator ID="rfvPwd" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter your password" ControlToValidate="txtNewPwd" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPwd" runat="server" ControlToValidate="txtNewPwd" Cssclass="text-danger" Display="Dynamic" ErrorMessage="Password is too weak" SetFocusOnError="true" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{10,}$" ></asp:RegularExpressionValidator>
                </div>
            <i id="passwordVisibility" class="fa-solid fa-eye-slash" onclick="togglePasswordVisibility()"  style="width:10%;margin-top:30px"></i>
            </div>
            <div style="border: 1px solid white;width:70%;" class="mx-auto p-2">
                <label class="text-left mt-2">Password strength:</label>
                <label id="lblStrength"></label>
                <div class="progress">
                    <div id="progressBar" class="progress-bar bg-danger" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <label ID="lblCond1" class="text-danger mt-2">✗ Must be at least 10 characters</label><br/>
                <label ID="lblCond2" class="text-danger">✗ Must contain at least 1 uppercase</label><br/>
                <label ID="lblCond3" class="text-danger">✗ Must contain at least 1 lowercase</label><br/>
                <label ID="lblCond4" class="text-danger mb-2">✗ Must contain at least 1 digit</label><br/>
            </div>
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-lock" style="width:10%;margin-top:30px"></i>
                <div class="form-floating mb-3" id="float2" style="width:60%;">
                    <asp:TextBox ID="txtCfmPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                    <label for="txtCfmPassword">Confirm Password</label>
                    <asp:RequiredFieldValidator ID="rfvCfmPassword" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please confirm your password" ControlToValidate="txtCfmPwd" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvCfmPassword" runat="server" ErrorMessage="Password does not match"  CssClass="text-danger" Display="Dynamic" ControlToValidate="txtCfmPwd" ControlToCompare="txtNewPwd" SetFocusOnError="true"></asp:CompareValidator>
                </div>
            <i id="passwordVisibility2" class="fa-solid fa-eye-slash" onclick="togglePasswordVisibility2()"  style="width:10%;margin-top:30px"></i>
            </div>
            <div class="text-center">
                <asp:Button class="btn btn-default my-4 w-50" ID="btnToken" runat="server" Text="Reset Password" OnClick="btnToken_Click"/>
            </div>
        </div>
    </div>
    <script>
        function togglePasswordVisibility() {
            var passwordInput = document.getElementById('<%= txtNewPwd.ClientID %>');
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
        var passwordInput = document.getElementById('<%= txtCfmPwd.ClientID %>');
            var iconPasswordVisibility = document.getElementById('passwordVisibility2');

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
        function updateStrength() {
            var password = document.getElementById('<%= txtNewPwd.ClientID %>').value;
            var progressBar = document.getElementById("progressBar");
            var lblCond1 = document.getElementById("lblCond1");
            var lblCond2 = document.getElementById("lblCond2");
            var lblCond3 = document.getElementById("lblCond3");
            var lblCond4 = document.getElementById("lblCond4");
            var lblStrength = document.getElementById("lblStrength");
            var strength = 0;

            if (password.length >= 10) {
                lblCond1.classList.remove("text-danger");
                lblCond1.classList.add("text-success");
                lblCond1.innerHTML = "✓ Must be at least 10 characters<br/>";
                strength = strength + 20;
            } else {
                lblCond1.classList.remove("text-success");
                lblCond1.classList.add("text-danger");
                lblCond1.innerHTML = "✗ Must be at least 10 characters<br/>";
            }

            if (password.length >= 14) {
                strength = strength + 20;
            }

            if (/[A-Z]/.test(password)) {
                lblCond2.classList.remove("text-danger");
                lblCond2.classList.add("text-success");
                lblCond2.innerHTML = "✓ Must contain at least 1 uppercase<br/>";
                strength = strength + 20;
            } else {
                lblCond2.classList.remove("text-success");
                lblCond2.classList.add("text-danger");
                lblCond2.innerHTML = "✗ Must contain at least 1 uppercase<br/>";
            }

            if (/.*[a-z].*/.test(password)) {
                lblCond3.classList.remove("text-danger");
                lblCond3.classList.add("text-success");
                lblCond3.innerHTML = "✓ Must contain at least 1 lowercase<br/>";
                strength = strength + 20;
            } else {
                lblCond3.classList.remove("text-success");
                lblCond3.classList.add("text-danger");
                lblCond3.innerHTML = "✗ Must contain at least 1 lowercase<br/>";
            }

            if (/[0-9]/.test(password)) {
                lblCond4.classList.remove("text-danger");
                lblCond4.classList.add("text-success");
                lblCond4.innerHTML = "✓ Must contain at least 1 digit<br/>";
                strength = strength + 20;
            } else {
                lblCond4.classList.remove("text-success");
                lblCond4.classList.add("text-danger");
                lblCond4.innerHTML = "✗ Must contain at least 1 digit<br/>";
            }
            progressBar.style.width = strength + "%";
            if (strength == 0) {
                lblStrength.innerHTML = "";
            } else if (strength <= 20) {
                progressBar.classList.remove("bg-warning");
                progressBar.classList.remove("bg-success");
                progressBar.classList.remove("bg-info");
                progressBar.classList.add("bg-danger");
                lblStrength.innerHTML = "Very Weak";
            } else if (strength <= 40) {
                progressBar.classList.remove("bg-danger");
                progressBar.classList.remove("bg-success");
                progressBar.classList.remove("bg-info");
                progressBar.classList.add("bg-warning");
                lblStrength.innerHTML = "Weak";
            } else if (strength <= 60) {
                progressBar.classList.remove("bg-danger");
                progressBar.classList.remove("bg-success");
                progressBar.classList.remove("bg-warning");
                progressBar.classList.add("bg-info");
                lblStrength.innerHTML = "Good";
            } else if (strength <= 80) {
                progressBar.classList.remove("bg-danger");
                progressBar.classList.remove("bg-success");
                progressBar.classList.remove("bg-warning");
                progressBar.classList.remove("bg-info");
                lblStrength.innerHTML = "Strong";
            } else {
                progressBar.classList.remove("bg-danger");
                progressBar.classList.remove("bg-warning");
                progressBar.classList.remove("bg-info");
                progressBar.classList.add("bg-success");
                lblStrength.innerHTML = "Very Strong";
            }

        }
    </script>
</asp:Content>
