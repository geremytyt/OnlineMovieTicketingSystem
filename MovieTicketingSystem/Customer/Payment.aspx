<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="../Customer.Master" CodeBehind="Payment.aspx.cs" Inherits="MovieTicketingSystem.View.Payment" %>


<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    <link href="../css/payment.css" rel="stylesheet" />
    <div class="container" style="overflow:hidden;">
        <h2 class="text-white">Transaction Detail</h2> <hr />
        <table id="transactionDetailTable">
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
                <td>Total Adult Ticket(s) Purchased:</td>
                <td>
                    <asp:Label ID="lblTotalAdultTicket" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Total Child Ticket(s) Purchased:</td>
                <td>
                    <asp:Label ID="lblTotalChildTicket" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Ticket Total:</td>
                <td>
                    <asp:Label ID="lblTicketTotal" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Food Purchased:</td>
                <td>
                    <asp:Label ID="lblFoodPurchased" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Food Total:</td>
                <td>
                    <asp:Label ID="lblFoodTotal" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Payment Amount:</td>
                <td>
                    <asp:Label ID="lblPaymentAmt" runat="server" Text=""></asp:Label>
                </td>
            </tr>

            <tr>
                <td>Payment Method:</td>
                <td>
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged">
                        <asp:ListItem Text="Select a credit card" Value="" disabled="disabled"></asp:ListItem>
                        <asp:ListItem Text="Register a new credit card" Value="registerCreditCard"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <br />
        <br />

        <asp:Button ID="btnProceed" class="btnProceed" runat="server" Text="Proceed" OnClick="btnProceed_Click" />
        <br />
        <br />
    </div>
 
</asp:Content>



