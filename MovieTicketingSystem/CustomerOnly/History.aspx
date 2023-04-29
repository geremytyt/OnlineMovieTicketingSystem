<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.History" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
       <div class="col-md-10 py-5 mx-auto text-white">
        <div class="row bg-black rounded-4">
            <div class="col-md-4 p-3">
                <asp:Image ID="imgPreview" runat="server" class="mt-3 mx-auto d-block" Width="200px" Height="200px" AlternateText="No Picture Uploaded" ImageAlign="AbsMiddle" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"/>
                <hr class="mx-auto w-75" style="border:1px solid white;"/>
                <div class="row ">
                    <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnProfile" runat="server" Text="My Profile" class="profileTab nav-link" type="button" OnClick="btnProfile_Click" />
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnTicket" runat="server" Text="My Tickets" class="profileTab nav-link" type="button" OnClick="btnTicket_Click"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnHistory" runat="server" Text="My History" class="profileTab nav-link active" type="button" OnClick="btnHistory_Click"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnResetPwd" runat="server" Text="Reset Password" class="profileTab nav-link" type="button" OnClick="btnResetPwd_Click"/>
                        </li>
                    </ul>
                </div>
            <hr class="mx-auto w-75" style="border:1px solid white;"/>
            </div>
            <div class="col-md-8" style="height:650px;">
                <div class="tab-content container-fluid" id="nav-tabContent">
                    <div class="tab-pane fade show active p-3" id="nav-myHistory" role="tabpanel" aria-labelledby="nav-history-tab">
                        <h3 class="text-white">My History</h3>
                        <hr style="border:1px solid white"/>
                        <div class="row justify-content-end mb-3">
                            <asp:DropDownList ID="ddlTime" class="w-50 mx-2 p-2" runat="server" BackColor="Black" ForeColor="White" OnSelectedIndexChanged="ddlTime_SelectedIndexChanged"  AutoPostBack="True">
                                <asp:ListItem>All</asp:ListItem>
                                <asp:ListItem>Past 3 months</asp:ListItem>
                                <asp:ListItem>Past 4-12 months</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div style="height:450px;overflow:auto;overflow-x:hidden;">
                            <asp:Repeater ID="Repeater4" runat="server" OnItemDataBound="Repeater4_ItemDataBound">
                                <ItemTemplate>
                                     <div style="border: 1px solid white; border-radius:10px;" class="my-2">
                                        <div class="row">
                                            <div class="my-2" style="width:65%;">
                                                <div class="row">
                                                    <label class="fieldLabel mx-2" style="width:50%;">Payment Date</label>
                                                    <label class="fieldLabel" style="width:45%;">Total Amount</label><br />    
                                                    <asp:Label ID="Label5" runat="server" style="width:50%;" CssClass="mx-2" Text='<%#Eval("paymentDateTime","{0:d}") %>'></asp:Label>
                                                    <asp:Label ID="lblPayDate3" runat="server" Width="45%" Text='<%#Eval("paymentAmount") %>'></asp:Label>
                                                </div>
                                            </div>    
                                            <div style="width:35%">
                                                <button id="btnShow" Text="Show More" class="btn btn-default mt-3 ms-3 w-75" type="button" data-bs-toggle="collapse" data-bs-target="#<%#Eval("paymentNo") %>" aria-expanded="false" aria-controls="<%#Eval("paymentNo") %>">Details</button>
                                            </div>
                                        </div>
                                        <div class="collapse" id="<%#Eval("paymentNo") %>">
                                            <asp:Repeater ID="Repeater5" runat="server">
                                                <ItemTemplate>
                                                    <div style="border-bottom: 1px solid white; width: 95%;" class="mx-auto"></div>
                                                        <div class="row">
                                                            <label class="fieldLabel mt-2 mx-2" style="width:45%;">Movie Name</label>
                                                            <label class="fieldLabel mt-2 text-center" style="width:25%;">Schedule Time</label>
                                                            <label class="fieldLabel mt-2 text-center" style="width:25%;">Schedule Date</label>
                                                            <asp:Label ID="lblMovieName3" runat="server" CssClass="mx-2" Width="45%" Text='<%#Eval("movieName") %>'></asp:Label>
                                                            <asp:Label ID="lblScheduleTime" runat="server" Cssclass="w-25 text-center" Text='<%#Eval("scheduleDateTime","{0:t}") %>'></asp:Label>
                                                            <asp:Label ID="lblScheduleDate" runat="server" Cssclass="w-25 text-center" Text='<%#Eval("scheduleDateTime","{0:d}") %>'></asp:Label>
                                                            <label class="fieldLabel mx-2" style="width:45%;">Ticket</label>    
                                                            <label class="fieldLabel w-25 text-center">Quantity</label>
                                                            <label class="fieldLabel w-25 text-center">Subtotal(RM)</label>
                                                            <asp:Label ID="Label1" runat="server" Cssclass="mx-2" Width="45%" Text="Senior"></asp:Label>
                                                            <asp:Label ID="Label2" runat="server" Cssclass="w-25 text-center" Text='<%#Convert.ToDecimal(Eval("seniorQty")) %>'></asp:Label>
                                                            <asp:Label ID="Label3" runat="server" Cssclass="w-25 text-center" Text='<%#(Convert.ToDecimal(Eval("seniorQty")) * 10).ToString("N2") %>'></asp:Label>
                                                            <asp:Label ID="Label4" runat="server" Cssclass="mx-2" Width="45%" Text="Adult"></asp:Label>
                                                            <asp:Label ID="Label6" runat="server" Cssclass="w-25 text-center" Text='<%#Convert.ToDecimal(Eval("adultQty")) %>'></asp:Label>
                                                            <asp:Label ID="Label7" runat="server" Cssclass="w-25 text-center" Text='<%#(Convert.ToDecimal(Eval("adultQty")) * 13).ToString("N2") %>'></asp:Label>
                                                            <asp:Label ID="Label8" runat="server" Cssclass="mx-2" Width="45%" Text="Children"></asp:Label>
                                                            <asp:Label ID="Label9" runat="server" Cssclass="w-25 text-center" Text='<%#Convert.ToDecimal(Eval("childrenQty")) %>'></asp:Label>
                                                            <asp:Label ID="Label10" runat="server" Cssclass="w-25 text-center" Text='<%#(Convert.ToDecimal(Eval("childrenQty")) * 10).ToString("N2") %>'></asp:Label>
                                                            <label class="mx-2" style="width:45%"></label>
                                                            <label class="fieldLabel w-25 text-center">Total(RM):</label>
                                                            <asp:Label ID="Label14" runat="server" Cssclass="w-25 text-center" Text='<%#Eval("ticketTotal") %>'></asp:Label>
                                                        </div>  
                                                </ItemTemplate>                                
                                            </asp:Repeater>
                                            <asp:Repeater ID="Repeater6" runat="server" OnItemDataBound="Repeater6_ItemDataBound">
                                                <HeaderTemplate>
                                                        <div style="border-bottom: 1px solid white; width: 95%;" class="mx-auto"></div>
                                                        <label class="fieldLabel mx-2" style="width:45%">Menu Item</label>
                                                        <label class="fieldLabel w-25 text-center">Quantity</label>
                                                        <label class="fieldLabel w-25 text-center">Subtotal(RM)</label>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <asp:Label ID="lblMenu" runat="server" Cssclass="mx-2" Width="45%" Text='<%#Eval("menuName") %>'></asp:Label>
                                                        <asp:Label ID="lblQty2" runat="server" Cssclass="w-25 text-center" Text='<%#Eval("menuQty") %>'></asp:Label>
                                                        <asp:Label ID="lblSubTotal" runat="server" Cssclass="w-25 text-center" Text='<%#Convert.ToDecimal(Eval("menuQty")) * Convert.ToDecimal(Eval("menuPrice"))%>'></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <div class="row">
                                                        <label class="mx-2" style="width:45%"></label>
                                                        <label class="fieldLabel w-25 text-center">Total(RM):</label>
                                                        <asp:Label ID="Label15" runat="server" class="w-25 text-center"></asp:Label>
                                                      </div>
                                                </FooterTemplate>
                                            </asp:Repeater>         
                                        </div>
                                    </div>    
                                </ItemTemplate>
                            </asp:Repeater>    
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT Movie.movieName, Schedule.scheduleDateTime, Purchase.ticketTotal, Purchase.seniorQty, Purchase.adultQty, Purchase.childrenQty FROM Schedule INNER JOIN Movie ON Schedule.movieId = Movie.movieId INNER JOIN Ticket ON Schedule.scheduleNo = Ticket.scheduleNo INNER JOIN Purchase INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo ON Ticket.purchaseNo = Purchase.purchaseNo WHERE (Payment.paymentNo = @paymentNo) GROUP BY Movie.movieName, Schedule.scheduleDateTime, Purchase.ticketTotal, Purchase.seniorQty, Purchase.adultQty, Purchase.childrenQty">
                                <SelectParameters>
                                    <asp:Parameter Name="paymentNo"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT Menu.menuName, Menu.menuPrice, PurchaseMenu.menuQty, Purchase.foodTotal FROM Purchase INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo INNER JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo INNER JOIN Menu ON PurchaseMenu.menuId = Menu.menuId WHERE (Payment.paymentNo = @paymentNo)">
                                <SelectParameters>
                                    <asp:Parameter Name="paymentNo"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                        <div class="w-100 text-center">
                            <asp:Label ID="lblNo" runat="server"></asp:Label>
                        </div>  
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>

    </script>
</asp:Content>
