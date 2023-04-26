﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffResetPwd2.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.StaffResetPwd2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
 <div id="content" class="text-light d-flex align-items-center justify-content-center"  style="min-height: 100vh;">
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
</asp:Content>
