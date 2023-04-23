<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.ResetPassword" %>
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
                            <asp:Button ID="btnTicket" runat="server" Text="My Tickets" class="profileTab nav-link" type="button" OnClick="btnTicket_Click"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnHistory" runat="server" Text="My History" class="profileTab nav-link" type="button" OnClick="btnHistory_Click"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnResetPwd" runat="server" Text="Reset Password" class="profileTab nav-link active" type="button" OnClick="btnResetPwd_Click"/>
                        </li>
                    </ul>
            </div>
            <hr class="mx-auto w-75" style="border:1px solid white;"/>
            </div>
            <div class="col-md-8" style="height:650px;">
                <div class="tab-content container-fluid" id="nav-tabContent">
                    <div class="tab-pane fade show active p-3" id="nav-resetPwd" role="tabpanel" aria-labelledby="nav-resetpwd-tab">
                        <h3 class="text-white">Reset Password</h3>
                        <hr style="border:1px solid white"/>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="txtOldPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                            <label>Old Password</label>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="txtNewPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                            <label>New Password</label>
                        </div>
                        <div class="form-floating mb-3 w-75 mx-auto">
                            <asp:TextBox ID="txtCfmPwd" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Password" />
                            <label>Confirm Password</label>
                        </div>
                        <asp:Button class="btn btn-default btn-block w-25 my-3 float-end" ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
