<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="../Customer.Master" CodeBehind="Payment.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Payment" %>


<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />

    <script>
        function toggleContainer() {
            var container = document.querySelector(".PurchaseDetailsContainer");
            if (container.classList.contains("collapsed")) {
                container.classList.remove("collapsed");
                container.classList.add("expanded");
            } else {
                container.classList.remove("expanded");
                container.classList.add("collapsed");
            }
        }
    </script>

    <style>
    .PurchaseDetailsContainer.collapsed {
        height: 50px;
        overflow: hidden;
        transition: height 0.3s;
    }

    .PurchaseDetailsContainer.expanded {
        height: auto;
        overflow: visible;
        transition: height 0.3s;
    }
    </style>

    <div class="container" style="overflow:hidden;">
        <h2 class="text-white">Transaction Detail</h2> <hr />

        <div class="MovieDetailsContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div class="row justify-content-center">
                <h3 class="text-center mt-2" style="margin-left:10px;">
                    <asp:Label ID="lblTitle" runat="server" Text="">Mario</asp:Label>
                </h3>
                

                <div class="col-md-3 mt-2">
                        <label><i class="fa-solid fa-calendar-days" style="color: #ffffff;"></i></label>
                        <asp:Label ID="lblShowingDate" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                </div>
                <div class="col-md-3 mt-2">
                        <label><i class="fa fa-clock" style="color: #ffffff;"></i></label>
                        <asp:Label ID="lblShowingTime" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                </div>
                <div class="col-md-3 mt-2">
                        <label><i class="fa-sharp fa-light fa-screen-users"></i></label>
                        <asp:Label ID="lblHallNo" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                </div>
                <div class="col-md-3 mt-2">
                        <label><i class="fab fa-loveseat" style="color: #ffffff;"></i></label>
                        <asp:Label ID="lblSeat" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                </div>
            </div>
        </div>
        <br />
        <div class="PurchaseDetailsContainer text-white expanded" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div class="row p-5" onclick="toggleContainer()">
                <h3 class="mt-2" style="margin-left:10px;">Purchase Details</h3>
                <div class="m-2">
                    <label style="color:yellow; font-weight:bold;">Tickets</label>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Adult Ticket(s)</label>
                    </div>
                    <div class="col-3 text-center">
                        <asp:Label ID="lblTotalAdultTicket" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblAdultTicketPrice" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Child Ticket(s)</label>
                    </div>
                    <div class="col-3 text-center">
                        <asp:Label ID="lblTotalChildTicket" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblChildTicketPrice" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Senior Ticket(s)</label>
                    </div>
                    <div class="col-3 text-center">
                        <asp:Label ID="lblTotalSeniorTicket" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblSeniorTicketPrice" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
               
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Ticket Total</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblTicketTotal" runat="server" Text="" CssClass="m-2">40</asp:Label>
                    </div>
                </div>
                <hr />

                <div class="m-2">
                    <label style="color:yellow; font-weight:bold;">F&B</label>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <asp:Label ID="lblFoodPurchased" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                    <div class="col-3 text-center">
                        <asp:Label ID="lblFoodQty" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblFoodPrice" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                </div>

                
                <div class="m-2 row">
                    <div class="col-6">
                        <label>Food & Beverage Total</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblFoodTotal" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                </div>
                <hr />

                <div class="m-2 row" style="background-color:#1d2124; padding:10px;">
                    <div class="col-6">
                        <label>Total</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPaymentAmt" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="PaymentMethodContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div class="row p-5">
                <h3 class="mt-2" style="margin-left:10px;">Payment Method</h3>

                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12">
                            <label>Credit Card</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:DropDownList ID="ddlPaymentMethod" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged"
                                CssClass="form-control">
                                <asp:ListItem Text="Select a credit card" Value="" disabled="disabled"></asp:ListItem>
                                <asp:ListItem Text="Register a new credit card" Value="registerCreditCard"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12">
                            <label>PayPal</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <asp:Button ID="btnPaypal" runat="server" Text="PayPal" CssClass="btn btn-default" Width="100%" />
                            <asp:Label ID="lblCount" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

       <%-- <table id="transactionDetailTable">
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
                <td>Total Senior Ticket(s) Purchased:</td>
                <td>
                    <asp:Label ID="lblTotalSeniorTicket" runat="server" Text=""></asp:Label>
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
        </table>--%>
        <br />
        <br />

        <%--<asp:Button ID="btnProceed" class="btnProceed" CssClass="btn btn-default" runat="server" Text="Proceed" OnClick="btnProceed_Click" />--%>
        <br />
        <br />
    </div>
 
</asp:Content>



