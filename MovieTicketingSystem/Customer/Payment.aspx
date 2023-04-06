<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Customer.Master" CodeBehind="Payment.aspx.cs" Inherits="MovieTicketingSystem.View.Payment" %>


<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    <link href="../css/payment.css" rel="stylesheet" />
    <div class="container">
        <h2 class="pageTitle">Transaction Detail</h2> <hr />
        <table id="transactionDetailTable">
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
            <tr>
                <td>Total Adult Ticket(s) Purchased:</td>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="3"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Total Child Ticket(s) Purchased:</td>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Transaction No:</td>
                <td>
                    <asp:Label ID="Label7" runat="server" Text="T01972"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Transaction Amount:</td>
                <td>
                    <asp:Label ID="Label8" runat="server" Text="RM 130.50"></asp:Label>
                </td>
            </tr>

            <tr>
                <td>Payment Method:</td>
                <td>
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged">
                        <asp:ListItem Text="Select a credit card" Value=""></asp:ListItem>
                        <asp:ListItem Text="Credit Card 1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Credit Card 2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Credit Card 3" Value="3"></asp:ListItem> 
                        <asp:ListItem Text="Register a new credit card" Value="registerCreditCard"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <asp:Button ID="btnProceed" class="btnProceed" runat="server" Text="Proceed" OnClick="btnProceed_Click" />
    </div>
</asp:Content>



