<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="PaymentSummary.aspx.cs" Inherits="MovieTicketingSystem.View.PaymentSummary" %>

<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    <link href="../css/payment.css" rel="stylesheet" />
    <div class="container">
        <h2 class="pageTitle">Payment Summary</h2> <hr />
        <table id="paymentSummaryTable" class="paymentSummaryTable">
            <tr>
                <td class="detailHeader">Payment Details</td>
            </tr>
            <tr>
                <td>Payment No:</td>
                <td>
                    <asp:Label ID="Label7" runat="server" Text="T01972"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Payment Date:</td>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="6/5/2023"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Payment Time:</td>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="20:23:47"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Payment Amount:</td>
                <td>
                    <asp:Label ID="Label8" runat="server" Text="RM 130.50"></asp:Label>
                </td>
            </tr>


            
            <tr>
                <td class="detailHeader">Movie Details</td>
            </tr>
            <tr>
                <td>Movie Title:</td>
                <td>
                    <asp:Label ID="lblTitle" runat="server" Text="Barbie"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Showing Date:</td>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="2023-02-01"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Showing Time:</td>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="18:30"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Hall No:</td>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="H02"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Seat Selected:</td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="C01 C02"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnDone" class="btnDone" runat="server" Text="Done" />
        <!-- After press done generate receipt/ticket-->
    </div>
</asp:Content>
