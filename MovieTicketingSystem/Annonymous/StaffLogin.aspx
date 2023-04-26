<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffLogin.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.StaffLogin" %>
<%@ Register TagPrefix="LoginControl" TagName="login" Src="../User Control/LoginControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit" async defer></script>
    <div id="content" class="text-light d-flex align-items-center justify-content-center m-3" style="min-height: 100vh;">
        <div class="bg-black rounded col-md-5 col-lg-3 col-sm-6">                  
            <div class="nav-link active flex-grow-1 loginTab p-3 text-center">Staff Login</div>    
            <LoginControl:login runat="server" /> 
        </div>
        <div class="text-center">
            <asp:HyperLink CssClass="mt-2 loginLink" ID="hlForgetpwd" runat="server" NavigateUrl="StaffResetPwd1.aspx">Forget Password?</asp:HyperLink>
        </div>
    </div>
</asp:Content>
