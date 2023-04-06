<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="MovieTicketingSystem.View.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="col-md-10 py-5 mx-auto text-white">
        <div class="row bg-black rounded-4">
            <div class="col-md-4 p-3">
                    <asp:Image CssClass="border-1 mx-auto d-block mt-3" ID="imgProfile" runat="server" src="Image/logo.png" Height="200" Width="200" />
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
                                <button class="nav-link" id="nav-logout-tab" href="#">Logout</button>
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
                            <div class="my-4 mx-auto d-flex" id="float">
                                <h6 class="w-25 align-self-end">Name</h6>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control w-75" placeholder=" "/>
                            </div>
                            <div class="my-4 mx-auto d-flex" id="float1">
                                <h6 class="w-25 align-self-end">Email</h6>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control w-75" placeholder=" " />
                            </div>
                            <div class="my-4 mx-auto d-flex" id="float3">
                                <h6 class="w-25 align-self-end">Phone No</h6>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control w-75" placeholder=" " TextMode="Phone"/>
                            </div>
                            <div class="my-4 mx-auto d-flex" id="float4">
                                <h6 class="w-25 align-self-end">Date Of Birth</h6>
                                <asp:TextBox ID="txtDob" runat="server" CssClass="form-control w-75" placeholder=" " TextMode="Date"/>
                            </div>
                            <div class="my-4 mx-auto d-flex" id="float5">
                                <h6 class="w-25 align-self-end">Gender</h6>
                                <asp:RadioButtonList ID="rblGender" CssClass="text-center" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="75%">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        <asp:Button class="btn btn-default btn-block w-25 my-3 float-end" ID="btnEdit" runat="server" Text="Edit" />
                    </div>
                    <div class="tab-pane fade p-3" id="nav-myTickets" role="tabpanel" aria-labelledby="nav-ticket-tab">
                        <h3 class="text-white">My Tickets</h3>
                        <hr style="border:1px solid white"/>
                        <div style="height:550px;overflow:auto;">
                            <div class="mx-auto bg-white text-black rounded-4 w-75">
                                <div class="container-fluid m-2 p-2 ">
                                    <asp:Label ID="lblMovieName" runat="server" Text="Alice in the Wonderland" Font-Size="14px"></asp:Label><br />
                                    <asp:Label ID="lblRating" runat="server" Text="P13" Font-Size="14px" ForeColor="#808080"></asp:Label>
                                    <div class="text-center">
                                        <asp:Image CssClass="border-1 mx-auto d-block mt-3" ID="imgTicket" runat="server" src="Image/logo.png" Height="150" Width="150" />
                                        <label class="fieldLabel" ID="lblPayNo">Payment No:</label>
                                        <asp:Label ID="lblPayNo2" runat="server" Text="P12356789" Font-Size="14px"></asp:Label><br />
                                        <label class="fieldLabel" ID="lblPayDate">Payment Date:</label>
                                        <asp:Label ID="lblPayDate2" runat="server" Text="03/04/2023" Font-Size="14px"></asp:Label>
                                    </div>
                                    <div class="row mt-3">
                                        <label class="fieldLabel w-50">Date</label>
                                        <label class="fieldLabel w-50">Time</label>
                                        <asp:Label ID="lblDate" CssClass="w-50" runat="server" Text="05/04/2023" Font-Size="14px"></asp:Label>
                                        <asp:Label ID="lblTime" CssClass="w-50" runat="server" Text="21:00"  Font-Size="14px"></asp:Label>
                                        <label class="fieldLabel w-50">Hall</label>
                                        <label class="fieldLabel w-50">Seat</label>
                                        <asp:Label ID="lblHall" CssClass="w-50" runat="server" Text="Hall 2" Font-Size="14px"></asp:Label>
                                        <asp:Label ID="lblSeat" CssClass="w-50" runat="server" Text="E04,E05"  Font-Size="14px"></asp:Label>
                                        <label class="fieldLabel w-100">Ticket</label>
                                        <asp:Label ID="lblSenior" Width="33%" runat="server" Text="Senior x2"  Font-Size="14px"></asp:Label>
                                        <asp:Label ID="lblAdult" Width="33%" runat="server" Text="Adult x3"  Font-Size="14px"></asp:Label>
                                        <asp:Label ID="lblChildren" Width="33%" runat="server" Text="Children x1"  Font-Size="14px"></asp:Label>
                                        <label class="fieldLabel w-100">Purchased Food</label>
                                        <asp:Label ID="lblFood" Width="75%" runat="server" Text="Family Set A"  Font-Size="14px"></asp:Label>
                                        <asp:Label ID="lblQty" Width="25%" runat="server" Text="1"  Font-Size="14px"></asp:Label>
                                    </div>
                                </div>
                            </div>
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
                            <div style="border: 1px solid white; border-radius:10px;">
                            <div class="row">
                                <div class="my-2" style="border-right: 1px solid white;width:65%;">
                                    <div class="row">
                                        <label class="fieldLabel mx-2" style="width:50%;">Movie Name</label>
                                        <label class="fieldLabel" style="width:45%;">Payment Date</label>
                                        <asp:Label ID="lblMovieName3" runat="server" CssClass="mx-2" Width="50%" Text="Alice in the Wonderland"></asp:Label>
                                        <asp:Label ID="lblPayDate3" runat="server" Width="45%" Text="27/03/2023"></asp:Label>
                                        <label class="fieldLabel mt-2 mx-2" style="width:50%;">Schedule Time</label>
                                        <label class="fieldLabel mt-2" style="width:45%;">Schedule Date</label>
                                        <asp:Label ID="lblScheduleTime" runat="server" CssClass="mx-2" Width="50%" Text="13:00"></asp:Label>
                                        <asp:Label ID="lblScheduleDate" runat="server" Width="45%" Text="30/03/2023"></asp:Label>
                                    </div>
                                </div>    
                                <div style="width:35%">
                                    <label class="fieldLabel">Total Amount</label><br />    
                                    <asp:Label ID="Label5" runat="server" Text="RM69.50"></asp:Label>
                                    <button class="btn btn-default mt-2 w-75" type="button" data-bs-toggle="collapse" data-bs-target="#showMore" aria-expanded="false" aria-controls="showMore" onclick="change(this)" id="btnShow">Show More</button>
                                </div>
                            </div>
                            <div class="collapse" id="showMore">
                                <div style="border-bottom: 1px solid white; width: 95%;" class="mx-auto"></div>
                                <div class="row">
                                    <label class="fieldLabel mx-2" style="width:45%;">Ticket</label>    
                                    <label class="fieldLabel w-25 text-center">Quantity</label>
                                    <label class="fieldLabel w-25 text-center">Subtotal(RM)</label>
                                    <asp:Label ID="Label1" runat="server" Cssclass="mx-2" Width="45%" Text="Senior"></asp:Label>
                                    <asp:Label ID="Label2" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label3" runat="server" Cssclass="w-25 text-center" Text="10.00"></asp:Label>
                                    <asp:Label ID="Label4" runat="server" Cssclass="mx-2" Width="45%" Text="Adult"></asp:Label>
                                    <asp:Label ID="Label6" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label7" runat="server" Cssclass="w-25 text-center" Text="15.00"></asp:Label>
                                    <asp:Label ID="Label8" runat="server" Cssclass="mx-2" Width="45%" Text="Children"></asp:Label>
                                    <asp:Label ID="Label9" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label10" runat="server" Cssclass="w-25 text-center" Text="13.00"></asp:Label>
                                    <label class="mx-2" style="width:45%"></label>
                                    <label class="fieldLabel w-25 text-center">Total(RM):</label>
                                    <asp:Label ID="Label14" runat="server" Cssclass="w-25 text-center" Text="38.00"></asp:Label>
                                </div>  
                                <div style="border-bottom: 1px solid white; width: 95%;" class="mx-auto"></div>
                                <div class="row">
                                    <label class="fieldLabel mx-2" style="width:45%">Menu Item</label>
                                    <label class="fieldLabel w-25 text-center">Quantity</label>
                                    <label class="fieldLabel w-25 text-center">Subtotal(RM)</label>
                                    <asp:Label ID="lblMenu" runat="server" Cssclass="mx-2" Width="45%" Text="Chili Cheese Hotdog"></asp:Label>
                                    <asp:Label ID="lblQty2" runat="server" Cssclass="w-25 text-center" Text="2"></asp:Label>
                                    <asp:Label ID="lblSubTotal" runat="server" Cssclass="w-25 text-center" Text="26.00"></asp:Label>
                                    <asp:Label ID="Label11" runat="server" Cssclass="mx-2" Width="45%" Text="Latte"></asp:Label>
                                    <asp:Label ID="Label12" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label13" runat="server" Cssclass="w-25 text-center" Text="5.50"></asp:Label>
                                    <label class="mx-2" style="width:45%"></label>
                                    <label class="fieldLabel w-25 text-center">Total(RM):</label>
                                    <asp:Label ID="Label15" runat="server" Cssclass="w-25 text-center" Text="21.50"></asp:Label>
                                </div>
                            </div>
                        </div>
                           <div style="border: 1px solid white; border-radius:10px;" class="my-2">
                            <div class="row">
                                <div class="my-2" style="border-right: 1px solid white;width:65%;">
                                    <div class="row">
                                        <label class="fieldLabel mx-2" style="width:50%;">Movie Name</label>
                                        <label class="fieldLabel" style="width:45%;">Payment Date</label>
                                        <asp:Label ID="Label16" runat="server" CssClass="mx-2" Width="50%" Text="Alice in the Wonderland"></asp:Label>
                                        <asp:Label ID="Label17" runat="server" Width="45%" Text="27/03/2023"></asp:Label>
                                        <label class="fieldLabel mt-2 mx-2" style="width:50%;">Schedule Time</label>
                                        <label class="fieldLabel mt-2" style="width:45%;">Schedule Date</label>
                                        <asp:Label ID="Label18" runat="server" CssClass="mx-2" Width="50%" Text="13:00"></asp:Label>
                                        <asp:Label ID="Label19" runat="server" Width="45%" Text="30/03/2023"></asp:Label>
                                    </div>
                                </div>    
                                <div style="width:35%">
                                    <label class="fieldLabel">Total Amount</label><br />    
                                    <asp:Label ID="Label20" runat="server" Text="RM69.50"></asp:Label>
                                    <button class="btn btn-default mt-2 w-75" type="button" data-bs-toggle="collapse" data-bs-target="#showMore1" aria-expanded="false" aria-controls="showMore1" onclick="change(this)" id="btnShow1">Show More</button>
                                </div>
                            </div>
                            <div class="collapse" id="showMore1">
                                <div style="border-bottom: 1px solid white; width: 95%;" class="mx-auto"></div>
                                <div class="row">
                                    <label class="fieldLabel mx-2" style="width:45%;">Ticket</label>    
                                    <label class="fieldLabel w-25 text-center">Quantity</label>
                                    <label class="fieldLabel w-25 text-center">Subtotal(RM)</label>
                                    <asp:Label ID="Label21" runat="server" Cssclass="mx-2" Width="45%" Text="Senior"></asp:Label>
                                    <asp:Label ID="Label22" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label23" runat="server" Cssclass="w-25 text-center" Text="10.00"></asp:Label>
                                    <asp:Label ID="Label24" runat="server" Cssclass="mx-2" Width="45%" Text="Adult"></asp:Label>
                                    <asp:Label ID="Label25" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label26" runat="server" Cssclass="w-25 text-center" Text="15.00"></asp:Label>
                                    <asp:Label ID="Label27" runat="server" Cssclass="mx-2" Width="45%" Text="Children"></asp:Label>
                                    <asp:Label ID="Label28" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label29" runat="server" Cssclass="w-25 text-center" Text="13.00"></asp:Label>
                                    <label class="mx-2" style="width:45%"></label>
                                    <label class="fieldLabel w-25 text-center">Total(RM):</label>
                                    <asp:Label ID="Label30" runat="server" Cssclass="w-25 text-center" Text="38.00"></asp:Label>
                                </div>  
                                <div style="border-bottom: 1px solid white; width: 95%;" class="mx-auto"></div>
                                <div class="row">
                                    <label class="fieldLabel mx-2" style="width:45%">Menu Item</label>
                                    <label class="fieldLabel w-25 text-center">Quantity</label>
                                    <label class="fieldLabel w-25 text-center">Subtotal(RM)</label>
                                    <asp:Label ID="Label31" runat="server" Cssclass="mx-2" Width="45%" Text="Chili Cheese Hotdog"></asp:Label>
                                    <asp:Label ID="Label32" runat="server" Cssclass="w-25 text-center" Text="2"></asp:Label>
                                    <asp:Label ID="Label33" runat="server" Cssclass="w-25 text-center" Text="26.00"></asp:Label>
                                    <asp:Label ID="Label34" runat="server" Cssclass="mx-2" Width="45%" Text="Latte"></asp:Label>
                                    <asp:Label ID="Label35" runat="server" Cssclass="w-25 text-center" Text="1"></asp:Label>
                                    <asp:Label ID="Label36" runat="server" Cssclass="w-25 text-center" Text="5.50"></asp:Label>
                                    <label class="mx-2" style="width:45%"></label>
                                    <label class="fieldLabel w-25 text-center">Total(RM):</label>
                                    <asp:Label ID="Label37" runat="server" Cssclass="w-25 text-center" Text="21.50"></asp:Label>
                                </div>
                            </div>
                        </div>
                        </div>
                        <div class="w-100 text-center">
                            <asp:Label ID="lblNo" runat="server" Text="2 Record(s) displayed"></asp:Label>
                        </div>
                    </div>
                    <div class="tab-pane fade p-3" id="nav-resetPwd" role="tabpanel" aria-labelledby="nav-resetpwd-tab">
                        <h3 class="text-white">Reset Password</h3>
                        <hr style="border:1px solid white"/>
                        <div class="form-floating mb-3 w-75 mx-auto" id="float6">
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="txtPassword">Old Password</label>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto" id="float7">
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="txtPassword1">New Password</label>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto" id="float8">
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder=" " TextMode="Password" />
                            <label for="txtCfmPassword">Confirm Password</label>
                        </div>
                        <asp:Button class="btn btn-default btn-block w-25 my-3 float-end" ID="btnReset" runat="server" Text="Reset" />
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
    </script>
    </div>
</asp:Content>
