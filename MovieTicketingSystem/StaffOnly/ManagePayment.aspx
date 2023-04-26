<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="ManagePayment.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.ManagePayment" %>


<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
    <link href="../css/payment.css" rel="stylesheet" />
     <%--<link href="../css/manageSchedule.css" rel="stylesheet" />--%>
    <div class="container">
        <div class="containerPaymentDetails" id="containerPaymentDetails" runat="server">
            <h2 class="text-white">Payment Details</h2> <hr />
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
                    <td>Payment Date:</td>
                    <td>
                        <asp:Label ID="lblPaymentDate" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Payment Time:</td>
                    <td>
                        <asp:Label ID="lblPaymentTime" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Payment Amount:</td>
                    <td>
                        <asp:Label ID="lblPaymentAmt" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                
                <tr>
                    <td class="detailHeader">Purchase Details</td>
                </tr>
                <tr>
                    <td>Purchase No:</td>
                    <td>
                        <asp:Label ID="lblPurchaseNo" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Cust ID:</td>
                    <td>
                        <asp:Label ID="lblCustID" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Ticket Total:</td>
                    <td>
                        <asp:Label ID="lblTicketTotal" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Food Total:</td>
                    <td>
                        <asp:Label ID="lblFoodTotal" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Ticket No:</td>
                    <td>
                        <asp:Label ID="lblTicketNo" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Menu ID:</td>
                    <td>
                        <asp:Label ID="lblMenuID" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Status:</td>
                    <td>
                        <asp:DropDownList ID="ddlStatus" runat="server">
                            <asp:ListItem Text="completed" Value="completed" />
                            <asp:ListItem Text="cancelled" Value="cancelled" />
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
                <div class="d-flex justify-content-center align-items-center m-2">
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-default m-2" Width="10%" Text="Edit" OnClick="btnEdit_Click" />
                    <asp:Button ID="btnConfirm" runat="server" CssClass="btn btn-default  m-2" Width="10%" Text="Confirm" OnClick="btnConfirm_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default  m-2" Width="10%" OnClick="btnCancel_Click" />
                    <asp:Button ID="btnDone" runat="server" CssClass="btn btn-default m-2" Width="10%" Text="Done" OnClick="btnDone_Click" />
            </div>
        
    </div>
</asp:Content>


