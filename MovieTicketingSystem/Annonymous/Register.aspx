<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div id="content" class="text-light d-flex align-items-center justify-content-center">
        <div class="bg-black rounded-4 col-md-7 col-lg-4 col-sm-8 my-5">
            <div class="nav-link active flex-grow-1 loginTab p-3 text-center"><h5>Register</h5></div> 
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-user" style="width:5%;margin-top:30px"></i>
                <div class="form-floating mb-3" style="width:60%;" id="float">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control userInput" placeholder=" " />
                    <label for="txtName">Name</label>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Please enter your name" CssClass="text-danger" Display="Dynamic" ControlToValidate="txtName" SetFocusOnError="true"></asp:RequiredFieldValidator>
                </div>
                <i style="width:5%;margin-top:30px"></i>
            </div>
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-envelope" style="width:5%;margin-top:30px"></i>
                <div class="form-floating mb-3" style="width:60%;" id="float1">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Email" />
                    <label for="txtEmail">Email</label>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Please enter your email" CssClass="text-danger" Display="Dynamic" ControlToValidate="txtEmail" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvExistEmail" runat="server" ControlToValidate="txtEmail" Cssclass="text-danger" Display="Dynamic" ErrorMessage="This email has been registered" SetFocusOnError="true"></asp:CustomValidator> 
                </div>
                <i style="width:5%;margin-top:30px"></i>
            </div>
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-lock" style="width:5%;margin-top:30px"></i>
                <div class="form-floating mb-3" style="width:60%;" id="float2">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control userInput" placeholder=" " onInput="updateStrength()" TextMode="Password"/>
                    <label for="txtPassword">Password</label>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Please enter your password" CssClass="text-danger" Display="Dynamic" ControlToValidate="txtPassword" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtEmail" Cssclass="text-danger" Display="Dynamic" ErrorMessage="Password is too weak" SetFocusOnError="true" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{10,}$" ></asp:RegularExpressionValidator>
                </div>
                <i id="passwordVisibility" class="fa-solid fa-eye-slash" onclick="togglePasswordVisibility()"  style="width:5%;margin-top:30px"></i>
                <div style="border: 1px solid white;width:70%;">
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
            </div>
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-lock" style="width:5%;margin-top:30px"></i>
                <div class="form-floating mb-3" style="width:60%;" id="float3">
                    <asp:TextBox ID="txtCfmPassword" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                    <label for="txtCfmPassword">Confirm Password</label>
                    <asp:RequiredFieldValidator ID="rfvCfmPassword" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please confirm your password" ControlToValidate="txtPassword" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvCfmPassword" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Password does not match" ControlToValidate="txtCfmPassword" SetFocusOnError="true"></asp:CustomValidator>
                </div>
                <i id="cfmpasswordVisibility" class="fa-solid fa-eye-slash" onclick="togglePasswordVisibility2()"  style="width:5%;margin-top:30px"></i>
            </div>
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-phone" style="width:5%;margin-top:30px"></i>
                <div class="form-floating mb-3" style="width:60%;" id="float4">
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Phone" />
                    <label for="txtPhone">Phone No</label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter your phone no" CssClass="text-danger" Display="Dynamic" ControlToValidate="txtPhone" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvExistPhone" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="This phone no has been registered" ControlToValidate="txtPhone" SetFocusOnError="true"></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="revPhone" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Invalid format of phone no" SetFocusOnError="true" ControlToValidate="txtPhone" ValidationExpression="^(\+?6?01)[0|1|2|3|4|6|7|8|9]\-*[0-9]{7,8}$"></asp:RegularExpressionValidator>
                </div>
                <i style="width:5%;margin-top:30px"></i>
            </div>                                                     
            <div class="row mt-2 justify-content-center">
                <i class="fa-solid fa-cake-candles" style="width:5%;margin-top:30px"></i>
                <div class="form-floating mb-3" style="width:60%;" id="float5">
                    <asp:TextBox ID="txtDob" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Date"/>
                    <label for="txtDob">Date Of Birth</label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter your date of birth" CssClass="text-danger" Display="Dynamic" ControlToValidate="txtDob" SetFocusOnError="true"></asp:RequiredFieldValidator>
                </div>
                <i style="width:5%;margin-top:30px"></i>
            </div>
            <div class="row mt-4 justify-content-center">
                <i class="fa-solid fa-venus-mars" style="width:5%;"></i>
                <div class="row" style="width:60%;margin-right:15px;">
                    <div class="w-25">
                        <asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
                    </div>
                    <div class="w-75">
                        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="100%">
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvGender" runat="server" ErrorMessage="Please select your gender" CssClass="text-danger" Display="Dynamic" ControlToValidate="rblGender" SetFocusOnError="true"></asp:RequiredFieldValidator>
                </div>
                <i style="width:5%;margin-top:30px"></i>
            </div>
            <div class="text-center">
                <asp:Button class="btn btn-default w-75 my-5" ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click"/>
            </div>
        </div>
    </div>
    <script>
        function updateStrength(){
            var password = document.getElementById('<%= txtPassword.ClientID %>').value;
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
            if (strength ==0) {
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
</asp:Content>
