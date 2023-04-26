<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffLogout.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.StaffLogout" %>
<%@ Register TagPrefix="LogoutControl" TagName="logout" Src="../User Control/LogoutControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div>
        <LogoutControl:logout runat="server" />
    </div>
</asp:Content>
