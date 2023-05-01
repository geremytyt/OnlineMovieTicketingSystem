<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="DefaultErrorPage(Staff).aspx.cs" Inherits="MovieTicketingSystem.ErrorPages.DefaultErrorPage_Staff_" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container text-white" style='font-family:Calibri; padding: 5px 5px 5px 5px'>
        <h3>Error</h3>
        <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
        <h4>Please contact the admin</h4>
    </div>
</asp:Content>
