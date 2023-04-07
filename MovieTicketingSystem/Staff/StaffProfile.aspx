<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffProfile.aspx.cs" Inherits="MovieTicketingSystem.Staff.StaffProfile" %>
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
            <div class="col-md-8" style="height:500px;">
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
                                <h6 class="w-25 align-self-end">IC</h6>
                                <asp:TextBox ID="txtDob" runat="server" CssClass="form-control w-75" placeholder=" "/>
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