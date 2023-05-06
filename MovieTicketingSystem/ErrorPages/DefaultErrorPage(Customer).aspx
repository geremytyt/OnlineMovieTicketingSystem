<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="DefaultErrorPage(Customer).aspx.cs" Inherits="MovieTicketingSystem.ErrorPages.DefaultErrorPage_Customer_" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container text-white" style='font-family:Calibri; padding: 5px 5px 5px 5px;min-height:90vh;'>
        <h1>Error</h1>
        <br />
        <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
        <h2>An error occurred. Please try again later or contact the website administrator for assistance.</h2>
    </div>
</asp:Content>
