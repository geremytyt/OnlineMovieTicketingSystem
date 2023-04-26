<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LogoutControl.ascx.cs" Inherits="MovieTicketingSystem.User_Control.LogoutControl" %>

    <div id="content" class="text-light d-flex align-items-center justify-content-center"  style="min-height: 100vh;">
        <div class="bg-black rounded col-md-4 col-lg-3 col-sm-5 text-center p-3 m-3">   
            <h5>Are you sure,</h5>
            <h5>You want to logout?</h5>
            <i class="fa-regular fa-face-sad-tear fa-beat p-3" style="font-size:50px"></i>
            <div class="text-center">
                <asp:Button class="btn btn-default mt-3 mx-2" ID="btnLogout" Width="40%" runat="server" Text="Logout" OnClick="btnLogout_Click"/>
                <asp:Button class="btn btn-default mt-3 mx-2" ID="btnCancel" Width="40%" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
            </div>
        </div>
    </div>