<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="../Customer.Master" CodeBehind="Payment.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Payment" %>


<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />


    <div class="container" style="overflow:hidden;">
        <br />
        <div id="movieDetails" runat="server"> 
        <div class="MovieDetailsContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div class="row justify-content-center text-center">
                <h3 class="text-center mt-2" style="margin-left:10px;">
                    <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
                </h3>

                <div class="col-md-3 mt-2">
                    <label><i class="fa-solid fa-calendar-days" style="color: #ffffff;"></i></label>
                    <asp:Label ID="lblShowingDate" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>

                <div class="col-md-3 mt-2">
                    <label><i class="fa fa-clock" style="color: #ffffff;"></i></label>
                    <asp:Label ID="lblShowingTime" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>

                <div class="col-md-3 mt-2">
                    <label><img src="../Image/hall.png" /></label>
                    <asp:Label ID="lblHallNo" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>             
            </div>
            <div class="row justify-content-center text-center mt-2">
                <div class="col-md-3 mt-2">
                    <div runat="server" id="seatContainer"> 
                    
                       
                            <label><img src="../Image/seat.png" /></label>
                            <asp:Label ID="lblSeat" runat="server" Text="" CssClass="m-2"></asp:Label>
                                      
                    </div> 
                </div>
            </div>

        </div>
        </div>
        <br />
        <div class="PurchaseDetailsContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div id="ticketDetails" runat="server">
            <div class="row p-5">
                <h3 class="mt-2" style="margin-left:10px;">Purchase Details</h3>
                <div class="m-2">
                    <label style="color:yellow; font-weight:bold;">Tickets</label>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <asp:Label ID="lblAdult" runat="server" Text="Adult Ticket(s)"></asp:Label>
                    </div>
                    <div class="col-3 text-center">
                        <asp:Label ID="lblAdultTicketQty" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblTotalAdultTicketPrice" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <asp:Label ID="lblChild" runat="server" Text="Child Ticket(s)"></asp:Label>
                    </div>
                    <div class="col-3 text-center">
                        <asp:Label ID="lblChildTicketQty" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblTotalChildTicketPrice" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
                <div class="m-2 row">
                    <div class="col-6">
                        <asp:Label ID="lblSenior" runat="server" Text="Senior Ticket(s)"></asp:Label>
                    </div>
                    <div class="col-3 text-center">
                        <asp:Label ID="lblSeniorTicketQty" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblTotalSeniorTicketPrice" runat="server" Text="" CssClass="m-2"></asp:Label>
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
                </div>
                </div>
                <hr />
               
                <div id="cartDetails" runat="server">
                    <div class="row p-5">
                    <div class="m-2">
                        <label style="color:yellow; font-weight:bold;">F&B</label>
                    </div>
                    <asp:Repeater ID="rptCartItems" runat="server">
                        <ItemTemplate>
                            <div class="m-2 row">
                                <div class="col-6">
                                    <asp:Label ID="lblFoodPurchased" runat="server" Text='<%# Eval("menuName") %>' CssClass="m-2"></asp:Label>
                                </div>
                                <div class="col-3 text-center">
                                    <asp:Label ID="lblFoodQty" runat="server" Text='<%# "(" + Eval("menuPrice","RM {0:n2}") + "x" + Eval("qty","{0}") + ")" %>' CssClass="m-2"></asp:Label>
                                </div>
                                <div class="col-3 text-right">
                                    <asp:Label ID="lblFoodPrice" runat="server" Text='<%# Eval("totalPrice","RM {0:n2}") %>' CssClass="m-2"></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="m-2 row">
                        <div class="col-6">
                            <label>Food & Beverage Total</label>
                        </div>
                        <div class="col-3 text-center"></div>
                        <div class="col-3 text-right">
                            <asp:Label ID="lblFoodTotal" runat="server" Text="" CssClass="m-2"></asp:Label>
                        </div>
                    </div>
                    </div>
                    <hr />
                </div>
                
                

                <div class="m-2 row" style="background-color:#1d2124; padding:10px;">
                    <div class="col-6">
                        <label>Total</label>
                    </div>
                    <div class="col-3 text-center"></div>
                    <div class="col-3 text-right">
                        <asp:Label ID="lblPaymentAmt" runat="server" Text="" CssClass="m-2"></asp:Label>
                    </div>
                </div>
            <br />
            
        </div>
        <br />
        <div class="PaymentMethodContainer text-white" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div class="row p-5">
                <h3 class="mt-2" style="margin-left:10px;">Payment Method</h3>
                <br />
                <div class="col-md-6">
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

            </div>
        </div>

        <br />
        <br />
        <div class="d-flex justify-content-center align-items-center m-2">
            <asp:Button ID="btnCancel" class="btnCancel" runat="server" Text="Cancel" style="display: block; margin: 0 auto; width:20%;" CssClass="btn btn-default" OnClick="btnCancel_Click"  />
            <asp:Button ID="btnProceed" class="btnProceed" style="display: block; margin: 0 auto; width:20%;" CssClass="btn btn-default" runat="server" Text="Proceed" OnClick="btnProceed_Click" />
        </div>
        
        <br />
        <br />
    </div>
 
</asp:Content>



