<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="MovieTicketingSystem.View.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="col-md-10 py-5 mx-auto text-white">
        <div class="row bg-black rounded-4">
            <div class="col-md-4 p-3">
                <asp:Image ID="imgPreview" runat="server" class="mt-3 mx-auto d-block" Width="200px" Height="200px" AlternateText="No Picture Uploaded" ImageAlign="AbsMiddle" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"/>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="d-block mx-auto w-75 mt-2" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" onchange="uploadImg()"/>
                <hr class="mx-auto w-75" style="border:1px solid white;"/>
                <div class="row">
                    <ul class="nav nav-tabs flex-column align-items-center">
                        <li class="nav-item mb-3">
                            <button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-myProfile" type="button" role="tab" aria-controls="nav-myProfile"
                            aria-selected="true">My Profile</button>
                        </li>
                        <li class="nav-item mb-3">
                            <button class="nav-link" id="nav-ticket-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-myTickets" type="button" role="tab" aria-controls="nav-myTickets"
                            aria-selected="false">My Tickets</button>
                        </li>
                        <li class="nav-item mb-3">
                            <button class="nav-link" id="nav-history-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-myHistory" type="button" role="tab" aria-controls="nav-myHistory"
                            aria-selected="false">My History</button>
                        </li>
                        <li class="nav-item mb-3">
                            <button class="nav-link" id="nav-resetpwd-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-resetPwd" type="button" role="tab" aria-controls="nav-resetPwd"
                            aria-selected="false">Reset Password</button>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="deleteTab" runat="server" Text="Delete Account" CssClass="nav-link" OnClick="deleteTab_Click"/>
                        </li>
                    </ul>
            </div>
            <hr class="mx-auto w-75" style="border:1px solid white;"/>
            </div>
            <div class="col-md-8" style="height:650px;">
                <div class="tab-content container-fluid" id="nav-tabContent">
                    <div class="tab-pane fade show active p-3" id="nav-myProfile" role="tabpanel" aria-labelledby="nav-profile-tab">
                        <h3 class="text-white">My Profile</h3>
                        <hr style="border:1px solid white"/>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Name</h6>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control w-75" placeholder=" "/>
                            </div>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Email</h6>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control w-75" placeholder=" " ReadOnly="true" />
                            </div>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Phone No</h6>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control w-75" placeholder=" " TextMode="Phone"/>
                            </div>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Date Of Birth</h6>
                                <asp:TextBox ID="txtDob" runat="server" CssClass="form-control w-75" placeholder=" " TextMode="Date"/>
                            </div>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Gender</h6>
                                <asp:RadioButtonList ID="rblGender" CssClass="text-center" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="75%">
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        <asp:Button class="btn btn-default btn-block w-25 my-3 float-end" ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
                    </div>
                    <div class="tab-pane fade p-3" id="nav-myTickets" role="tabpanel" aria-labelledby="nav-ticket-tab">
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
                    <div class="tab-pane fade p-3" id="nav-myHistory" role="tabpanel" aria-labelledby="nav-history-tab">
                        <h3 class="text-white">My History</h3>
                        <hr style="border:1px solid white"/>
                        <div class="row justify-content-end mb-3">
                            <asp:DropDownList ID="DropDownList1" class="w-50 mx-2" runat="server" BackColor="Black" ForeColor="White">
                                <asp:ListItem>All</asp:ListItem>
                                <asp:ListItem>Past 3 months</asp:ListItem>
                                <asp:ListItem>Past 4-12 months</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtSearch" runat="server"  class="form-control w-25 mx-2" placeholder="Search"></asp:TextBox>
                            <button class="btn btn-default" style="width:50px" type="submit"><i class="fas fa-search"></i></button>
                        </div>
                        <div style="height:450px;overflow:auto;overflow-x:hidden;">
                            <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource4" OnItemDataBound="Repeater4_ItemDataBound">
                                <ItemTemplate>
                                     <div style="border: 1px solid white; border-radius:10px;" class="mb-2">
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
                                                <button class="btn btn-default mt-3 ms-3 w-75" type="button" data-bs-toggle="collapse" data-bs-target="#showMore" aria-expanded="false" aria-controls="showMore" onclick="change(this)" id="btnShow">Show More</button>
                                            </div>
                                        </div>
                                        <div class="collapse" id="showMore">
                                            <asp:Repeater ID="Repeater5" runat="server" DataSourceID="SqlDataSource5">
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
                                            <asp:Repeater ID="Repeater6" runat="server" DataSourceID="SqlDataSource6">
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
                                                    <label class="mx-2" style="width:45%"></label>
                                                        <label class="fieldLabel w-25 text-center">Total(RM):</label>
                                                        <asp:Label ID="Label15" runat="server" Cssclass="w-25 text-center" Text='<%#Eval("foodTotal") %>'></asp:Label>
                                                </FooterTemplate>
                                            </asp:Repeater>         
                                        </div>
                                    </div>    
                                </ItemTemplate>
                            </asp:Repeater>    
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT Payment.paymentDateTime, Payment.paymentAmount, Payment.paymentNo FROM Schedule INNER JOIN Hall ON Schedule.hallNo = Hall.hallNo INNER JOIN Movie ON Schedule.movieId = Movie.movieId INNER JOIN Ticket ON Schedule.scheduleNo = Ticket.scheduleNo INNER JOIN Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo INNER JOIN PurchaseMenu ON Purchase.purchaseNo = PurchaseMenu.purchaseNo INNER JOIN Menu ON PurchaseMenu.menuId = Menu.menuId ON Ticket.purchaseNo = Purchase.purchaseNo WHERE (Customer.custId = @custID) GROUP BY Payment.paymentDateTime, Payment.paymentAmount, Payment.paymentNo">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="C001" Name="custID"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
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
                            <asp:Label ID="lblNo" runat="server" Text="2 Record(s) displayed"></asp:Label>
                        </div>  
                    </div>
                    <div class="tab-pane fade p-3" id="nav-resetPwd" role="tabpanel" aria-labelledby="nav-resetpwd-tab">
                        <h3 class="text-white">Reset Password</h3>
                        <hr style="border:1px solid white"/>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="txtPassword">Old Password</label>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="TextBox3">New Password</label>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="TextBox2">Confirm Password</label>
                        </div>
                        <asp:Button class="btn btn-default btn-block w-25 my-3 float-end" ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click"/>
                    </div>
                </div>
            </div>
        </div>
    <script>
        function change(sender) {  
            var id = sender.id;
            var text = document.getElementById(id).innerHTML;
            if (text == "Show More") {
                document.getElementById(id).innerHTML = "Show Less";
            } else {
                document.getElementById(id).innerHTML = "Show More";
            }
        }

        function uploadImg() {
            var fileInput = document.getElementById("<%=fileUpload.ClientID%>");
            var file = fileInput.files[0];
            if (file) {
                var reader = new FileReader(); 
                reader.onload = function (e) {
                    var fileUrl = e.target.result;
                    var imgPreview = document.getElementById("<%=imgPreview.ClientID%>");
                    imgPreview.src = fileUrl;
                };
                reader.readAsDataURL(file); 
            }
        }

    </script>
    </div>
</asp:Content>
