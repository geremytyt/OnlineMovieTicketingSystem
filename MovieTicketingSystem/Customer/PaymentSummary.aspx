
<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Customer.Master" CodeBehind="PaymentSummary.aspx.cs" Inherits="MovieTicketingSystem.View.PaymentSummary" %>

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
                    <asp:Label ID="lblPaymentNo" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Payment Date and Time:</td>
                <td>
                    <asp:Label ID="lblPaymentDateTime" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Payment Amount:</td>
                <td>
                    <asp:Label ID="lblPaymentAmount" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Card No:</td>
                <td>
                    <asp:Label ID="lblCardNo" runat="server" Text=""></asp:Label>
                </td>
            </tr>

            
            <%--<tr>
                <td class="detailHeader">Purchase Details</td>
            </tr>--%>
            <tr>
                <td>Purchase No:</td>
                <td>
                    <asp:Label ID="lblPurchaseNo" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <%--<tr>
                <td>Ticket No:</td>
                <td>
                    <asp:Label ID="lblTicketNo" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Movie Title:</td>
                <td>
                    <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Showing Date:</td>
                <td>
                    <asp:Label ID="lblShowingDate" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Showing Time:</td>
                <td>
                    <asp:Label ID="lblShowingTime" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Hall No:</td>
                <td>
                    <asp:Label ID="lblHallNo" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Seat Selected:</td>
                <td>
                    <asp:Label ID="lblSeat" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Food:</td>
                <td>
                    <asp:Label ID="lblMenuId" runat="server" Text=""></asp:Label>
                </td>
            </tr>--%>
        </table>
        <br />
        <asp:Button ID="btnDone" class="btnDone" runat="server" Text="Done" />
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
        <!-- After press done generate receipt/ticket-->
    </div>
</asp:Content>
