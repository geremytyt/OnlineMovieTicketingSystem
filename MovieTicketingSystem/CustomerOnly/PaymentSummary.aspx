
<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Customer.Master" CodeBehind="PaymentSummary.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.PaymentSummary" %>

<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    
    <link href="../css/style.css" rel="stylesheet" />
    <div class="container" style="overflow:hidden;">
    <div class="paymentSummaryContainer" style="width:60%; margin: auto; margin-top:20px;">
        <h2 class="text-white text-center">Payment Summary</h2> <hr style="color:white;" />
        <br />
        <br />
        
        <div class="PaymentDetailsContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div class="row">
                <br />
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Payment Status</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblStatus" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>

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
                        <label>Purchase Number</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPurchaseNo" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>

                <div class="m-2 row">
                    <div class="col-6">
                        <label>Payment Date and Time</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPaymentDateTime" runat="server" Text="" CssClass="m-2"></asp:Label>
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
                        <asp:Label ID="lblPaymentAmount" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>   <br />      
            </div>
        </div>
        <br />
        <br />
        <br />
         <asp:Button ID="btnDone" class="btnDone" runat="server" Text="Done" style="display: block; margin: 0 auto; width:20%;" CssClass="btn btn-default" OnClick="btnDone_Click" />
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
   
    </div>
    </div>
</asp:Content>
