<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffResetPassword.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.StaffResetPassword" %>
<%@ Register TagPrefix="ResetPwdControl" TagName="resetPwd" Src="../User Control/ResetPwdControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="col-md-10 py-5 mx-auto text-white" style="min-height:100vh;">
        <div class="row bg-black rounded-4">
            <div class="col-md-4 p-3">
                <asp:Image ID="imgPreview" runat="server" ImageUrl="../Image/user.png" class="mt-3 mx-auto d-block" Width="200px" Height="200px" AlternateText="No Picture Uploaded" ImageAlign="AbsMiddle" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"/>
                <hr class="mx-auto w-75" style="border:1px solid white;"/>
                <div class="row ">
                    <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnProfile" runat="server" Text="My Profile" class="profileTab nav-link" type="button" OnClick="btnProfile_Click" CausesValidation="false"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnResetPwd" runat="server" Text="Reset Password" class="profileTab nav-link active" type="button" OnClick="btnResetPwd_Click" CausesValidation="false"/>
                        </li>
                    </ul>
            </div>
            <hr class="mx-auto w-75" style="border:1px solid white;"/>
            </div>
            <div class="col-md-8" style="height:650px;">
                <div class="tab-content container-fluid" id="nav-tabContent">
                    <div class="tab-pane fade show active p-3" id="nav-myHistory" role="tabpanel" aria-labelledby="nav-history-tab">
                        <h3 class="text-white">Reset Password</h3>
                        <hr style="border:1px solid white"/>
                        <ResetPwdControl:resetPwd runat="server"/>
                </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
