<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
       <div class="col-md-10 py-5 mx-auto text-white">
        <div class="row bg-black rounded-4">
            <div class="col-md-4 p-3">
                <asp:Image ID="imgPreview" runat="server" class="mt-3 mx-auto d-block" Width="200px" Height="200px" AlternateText="No Picture Uploaded" ImageAlign="AbsMiddle" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"/>
                <hr class="mx-auto w-75" style="border:1px solid white;"/>
                <div class="row ">
                    <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnProfile" runat="server" Text="My Profile" class="profileTab nav-link" type="button" OnClick="btnProfile_Click" />
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnTicket" runat="server" Text="My Tickets" class="profileTab nav-link" type="button" OnClick="btnTicket_Click"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnHistory" runat="server" Text="My History" class="profileTab nav-link" type="button" OnClick="btnHistory_Click"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnResetPwd" runat="server" Text="Reset Password" class="profileTab nav-link active" type="button" OnClick="btnResetPwd_Click"/>
                        </li>
                    </ul>
            </div>
            <hr class="mx-auto w-75" style="border:1px solid white;"/>
            </div>
            <div class="col-md-8" style="height:650px;">
                <div class="tab-content container-fluid" id="nav-tabContent">
                    <div class="tab-pane fade show active p-3" id="nav-resetPwd" role="tabpanel" aria-labelledby="nav-resetpwd-tab">
                        <h3 class="text-white">Reset Password</h3>
                        <hr style="border:1px solid white"/>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="txtOldPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                            <label>Old Password</label>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="txtNewPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" onInput="updateStrength()"  />
                            <label>New Password</label>
                        </div>
                        <div style="border: 1px solid white;" class="mb-3 w-75 mx-auto p-3">
                            <label>Password strength:</label>
                            <label id="lblStrength"></label>
                            <div class="progress">
                              <div id="progressBar" class="progress-bar bg-danger" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <label ID="lblCond1" class="text-danger mt-2">✗ Must be at least 10 characters</label><br/>
                            <label ID="lblCond2" class="text-danger">✗ Must contain at least 1 uppercase</label><br/>
                            <label ID="lblCond3" class="text-danger">✗ Must contain at least 1 lowercase</label><br/>
                            <label ID="lblCond4" class="text-danger mb-2">✗ Must contain at least 1 digit</label><br/>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="txtCfmPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                            <label>Confirm Password</label>
                        </div>
                        <asp:Button class="btn btn-default btn-block w-25 my-3 float-end" ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
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
