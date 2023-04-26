<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Logout" %>
<%@ Register TagPrefix="LogoutControl" TagName="logout" Src="../User Control/LogoutControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <LogoutControl:logout runat="server" />
</asp:Content>
