<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="PageLevelError2.aspx.cs" Inherits="MovieTicketingSystem.ErrorPages.PageLevelError2" %>

<asp:Content ID="content" ContentPlaceHolderID="main" runat="server">
      <div class="container text-white mt-5" style='font-family:Calibri; padding: 5px 5px 5px 5px; min-height:90vh'>
        <h1>Oops! An error occurred.</h1>
        <h2>We apologize for the inconvenience. Please try again.</h2>
        <br /><br />
        <h2>Error Details:</h2>
        <div class="row">
            <h4 style="width:10%;">Exception:</h4>
            <asp:Label ID="lblException" runat="server" Text="" CssClass="h4 w-75"></asp:Label>
        </div>
        <div class="row">
            <h4 style="width:10%;">Source:</h4>
            <asp:Label ID="lblSource" runat="server" Text="" CssClass="h4 w-75"></asp:Label>
        </div>
        <br /><br />
        <h3>You can screenshot this message to the website administrator or technical support for assistance.</h3>
    </div>
</asp:Content>
