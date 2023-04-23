﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Profile" %>
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
                            <asp:Button ID="btnProfile" runat="server" Text="My Profile" class="profileTab nav-link active" type="button" OnClick="btnProfile_Click" />
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnTicket" runat="server" Text="My Tickets" class="profileTab nav-link" type="button" OnClick="btnTicket_Click"/>
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
                    <div class="tab-pane fade show active p-3" id="nav-myProfile">
                        <h3 class="text-white">My Profile</h3>
                        <hr style="border:1px solid white"/>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Name</h6>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control w-75 userInput" placeholder=" "/>
                            </div>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Email</h6>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control w-75 userInput" placeholder=" " ReadOnly="true" />
                            </div>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Phone No</h6>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control w-75 userInput" placeholder=" " TextMode="Phone"/>
                            </div>
                            <div class="my-4 mx-auto d-flex">
                                <h6 class="w-25 align-self-end">Date Of Birth</h6>
                                <asp:TextBox ID="txtDob" runat="server" CssClass="form-control w-75 userInput" placeholder=" " TextMode="Date"/>
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
                </div>
            </div>
        </div>
    <script>

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
