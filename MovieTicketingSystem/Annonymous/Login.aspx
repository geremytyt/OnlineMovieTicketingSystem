<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.Login" %>
<%@ Register TagPrefix="LoginControl" TagName="login" Src="../User Control/LoginControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit" async defer></script>
    <div id="content" class="text-light d-flex align-items-center justify-content-center m-3">
        <div class="bg-black rounded col-md-5 col-lg-3 col-sm-6">                  
            <div class="nav-link active flex-grow-1 loginTab p-3 text-center">User Login</div>    
            <LoginControl:login runat="server"/>
                <div class="text-center">
            <div class="text-center mb-4">
                 <asp:HyperLink CssClass="mt-2 mb-4 loginLink" ID="hlRegister" runat="server" NavigateUrl="Register.aspx">Register</asp:HyperLink>
                <asp:HyperLink CssClass="mt-2 loginLink" ID="HyperLink1" runat="server" NavigateUrl="ResetPwd1.aspx">Forget Password?</asp:HyperLink>
            </div>
        </div>
    </div>

</asp:Content>
