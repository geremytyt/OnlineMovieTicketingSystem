<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="ManagePayment.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.ManagePayment" %>


<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
    <%--<link href="../css/payment.css" rel="stylesheet" />--%>
     <%--<link href="../css/manageSchedule.css" rel="stylesheet" />--%>

    <div class="container" style="overflow:hidden;">
    <div class="paymentSummaryContainer" style="width:60%; margin: auto; margin-top:20px;">
        <br />
        <br />
        
        <div class="PaymentDetailsContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
                <br />
               <h2 class="text-white text-center">Payment Details</h2> <hr style="color:white;" />
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Payment Number</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPaymentNo" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>

                <div class="m-2 row">
                    <div class="col-6">
                        <label>Payment Date</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPaymentDate" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Payment Time</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPaymentTime" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
                
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Card Used</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblCardNo" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>

                <div class="m-2 row">
                    <div class="col-6">
                        <label>Payment Amount</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPaymentAmt" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
                
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Payment Status</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Completed" Value="Completed" />
                            <asp:ListItem Text="Cancelled" Value="Cancelled" />
                        </asp:DropDownList>
                    </div>
                </div>
            
                <br />      
            
       
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
   
        </div>
        <br />
        <div class="PurchaseDetailsContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <br />  
            <h2 class="text-white text-center">Purchase Details</h2> <hr style="color:white;" />
            <div class="m-2 row">
                <div class="col-6">
                    <label>Purchase Number</label>
                </div>
                <div class="col-3 text-center"></div>
                <div class="col-3 text-right">
                    <asp:Label ID="lblPurchaseNo" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>
            </div>

            <div class="m-2 row">
                <div class="col-6">
                    <label>Cust ID</label>
                </div>
                <div class="col-3 text-center"></div>
                <div class="col-3 text-right">
                    <asp:Label ID="lblCustID" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>
            </div>

            <div class="m-2 row">
                <div class="col-6">
                    <label>Ticket Total</label>
                </div>
                <div class="col-3 text-center"></div>
                <div class="col-3 text-right">
                    <asp:Label ID="lblTicketTotal" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>
            </div>

            <div class="m-2 row">
                <div class="col-6">
                    <label>Food Total</label>
                </div>
                <div class="col-3 text-center"></div>
                <div class="col-3 text-right">
                    <asp:Label ID="lblFoodTotal" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>
            </div>

            <div class="m-2 row">
                <div class="col-6">
                    <label>Ticket Number</label>
                </div>
                <div class="col-3 text-center"></div>
                <div class="col-3 text-right">
                    <asp:Label ID="lblTicketNo" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>
            </div>

            <div class="m-2 row">
                <div class="col-6">
                    <label>Menu ID</label>
                </div>
                <div class="col-3 text-center"></div>
                <div class="col-3 text-right">
                    <asp:Label ID="lblMenuID" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>
            </div>

            <br />  
        </div>
            <br />
        <div class="d-flex justify-content-center align-items-center m-2">
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-default m-2" Width="10%" Text="Edit" OnClick="btnEdit_Click" />
                    <asp:Button ID="btnConfirm" runat="server" CssClass="btn btn-default  m-2" Width="10%" Text="Confirm" OnClick="btnConfirm_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default  m-2" Width="10%" OnClick="btnCancel_Click" />
                    <asp:Button ID="btnDone" runat="server" CssClass="btn btn-default m-2" Width="10%" Text="Done" OnClick="btnDone_Click" />
        </div>
            <br />
            <br />
    </div>
    </div>
    <%--<div class="container">
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
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Completed" Value="Completed" />
                            <asp:ListItem Text="Cancelled" Value="Cancelled" />
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
        
    </div>--%>
</asp:Content>


