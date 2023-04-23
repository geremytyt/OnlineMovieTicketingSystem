<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Tickets.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Tickets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
       <div class="col-md-10 py-5 mx-auto text-white">
        <div class="row bg-black rounded-4">
            <div class="col-md-4 p-3">
                <asp:Image ID="imgPreview" runat="server" class="mt-3 mx-auto d-block" Width="200px" Height="200px" AlternateText="No Picture Uploaded" ImageAlign="AbsMiddle" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"/>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="d-block mx-auto w-75 mt-2" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" onchange="uploadImg()"/>
                <hr class="mx-auto w-75" style="border:1px solid white;"/>
                <div class="row ">
                    <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnProfile" runat="server" Text="My Profile" class="profileTab nav-link" type="button" OnClick="btnProfile_Click" />
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnTicket" runat="server" Text="My Tickets" class="profileTab nav-link active" type="button" OnClick="btnTicket_Click"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnHistory" runat="server" Text="My History" class="profileTab nav-link" type="button" OnClick="btnHistory_Click"/>
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
                    <div class="tab-pane fade show active p-3" id="nav-myTickets" role="tabpanel" aria-labelledby="nav-ticket-tab">
                        <h3 class="text-white">My Tickets</h3>
                        <hr style="border:1px solid white"/>
                        <div style="height:550px;overflow:auto;">
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                                <ItemTemplate>
                                    <div class="mx-auto bg-white text-black rounded-4 w-75">
                                        <div class="container-fluid m-2 p-2 ">
                                            <asp:Label ID="lblMovieName" runat="server" Text='<%#Eval("movieName") %>' Font-Size="14px"></asp:Label><br />
                                            <asp:Label ID="lblRating" runat="server" Text='<%#Eval("ageRating") %>' Font-Size="14px" ForeColor="#808080"></asp:Label>
                                            <div class="text-center">
                                                <asp:Image CssClass="border-1 mx-auto d-block" ID="imgTicket" runat="server" src="../Image/qrcode.png" Height="150" Width="150" />
                                                <label class="fieldLabel" ID="lblPayNo">Payment No:</label>
                                                <asp:Label ID="lblPayNo2" runat="server" Text='<%#Eval("paymentNo") %>' Font-Size="14px"></asp:Label><br />
                                                <label class="fieldLabel" ID="lblPayDate">Payment Date:</label>
                                                <asp:Label ID="lblPayDate2" runat="server" Text='<%#Eval("paymentDateTime","{0:d}") %>' Font-Size="14px"></asp:Label>
                                            </div>
                                            <div class="row mt-3">
                                                <label class="fieldLabel w-50">Date</label>
                                                <label class="fieldLabel w-50">Time</label>
                                                <asp:Label ID="lblDate" CssClass="w-50" runat="server" Text='<%#Eval("scheduleDateTime","{0:d}") %>' Font-Size="14px"></asp:Label>
                                                <asp:Label ID="lblTime" CssClass="w-50" runat="server" Text='<%#Eval("scheduleDateTime","{0:t}") %>'  Font-Size="14px"></asp:Label>
                                                <label class="fieldLabel w-50">Hall</label>
                                                <label class="fieldLabel w-50">Seat</label>
                                                <asp:Label ID="lblHall" CssClass="w-50" runat="server" Text='<%#Eval("hallNo") %>' Font-Size="14px"></asp:Label>
                                                <asp:Label ID="lblSeat" CssClass="w-50" runat="server" Font-Size="14px">
                                                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                                                        <ItemTemplate>
                                                            <%#Eval("seatNo") %>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </asp:Label>
                                                <label class="fieldLabel w-100">Ticket</label>
                                                <asp:Label ID="lblSenior" Width="33%" runat="server" Text='<%#"Senior x " + Eval("seniorQty") %>'  Font-Size="14px"></asp:Label>
                                                <asp:Label ID="lblAdult" Width="33%" runat="server" Text='<%#"Adult x " + Eval("adultQty") %>'  Font-Size="14px"></asp:Label>
                                                <asp:Label ID="lblChildren" Width="33%" runat="server" Text='<%#"Children x " + Eval("childrenQty") %>'  Font-Size="14px"></asp:Label>
                                                <label class="fieldLabel w-100">Purchased Food</label>
                                                <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFood" Width="75%" runat="server" Text='<%#Eval("menuName") %>'  Font-Size="14px"></asp:Label>
                                                        <asp:Label ID="lblQty" Width="25%" runat="server" Text='<%#Eval("menuQty") %>'  Font-Size="14px"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>'
                                SelectCommand="SELECT Movie.movieName, Movie.ageRating, Payment.paymentNo, Payment.paymentDateTime, Schedule.scheduleDateTime, Schedule.hallNo, Purchase.childrenQty, Purchase.adultQty, Purchase.seniorQty FROM Schedule INNER JOIN Hall ON Schedule.hallNo = Hall.hallNo INNER JOIN Movie ON Schedule.movieId = Movie.movieId INNER JOIN Ticket ON Schedule.scheduleNo = Ticket.scheduleNo INNER JOIN Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo INNER JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo INNER JOIN Menu ON PurchaseMenu.menuId = Menu.menuId ON Ticket.purchaseNo = Purchase.purchaseNo CROSS JOIN Staff WHERE (Customer.custId = @custId) GROUP BY Movie.movieName, Movie.ageRating, Payment.paymentNo, Payment.paymentDateTime, Schedule.scheduleDateTime, Schedule.hallNo, Purchase.childrenQty, Purchase.adultQty, Purchase.seniorQty">
                                <SelectParameters>
                                    <asp:Parameter Name="custId" DefaultValue="C001"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>'
                                SelectCommand="SELECT Ticket.seatNo FROM Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Ticket ON Purchase.purchaseNo = Ticket.purchaseNo INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo WHERE (Payment.paymentNo = @paymentNo)">
                                <SelectParameters>
                                    <asp:Parameter Name="paymentNo"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT Menu.menuName, PurchaseMenu.menuQty FROM Purchase INNER JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo INNER JOIN Menu ON PurchaseMenu.menuId = Menu.menuId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo WHERE (Payment.paymentNo = @paymentNo)">
                                <SelectParameters>
                                    <asp:Parameter Name="paymentNo"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>  
                    </div> 
                </div>
            </div>
        </div>
</asp:Content>
