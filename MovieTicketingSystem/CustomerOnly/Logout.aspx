<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Logout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    Logout Successfull, You will be redirected back to Home Page in 3 seconds.


    <script>
        setTimeout("location='../Annonymous/Home.aspx'", 3000);
    </script>
</asp:Content>
