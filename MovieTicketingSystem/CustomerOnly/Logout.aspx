<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Logout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div id="content" class="text-light d-flex align-items-center justify-content-center">
        <div class="bg-black rounded col-md-4 col-lg-3 col-sm-5 text-center p-3">   
            <h5>Are you sure,</h5>
            <h5>You want to logout?</h5>
            <i class="fa-regular fa-face-sad-tear fa-beat p-3" style="font-size:50px"></i>
            <div class="text-center">
                <asp:Button class="btn btn-default mt-3 mx-2" ID="btnLogout" Width="40%" runat="server" Text="Logout" OnClick="btnLogout_Click"/>
                <asp:Button class="btn btn-default mt-3 mx-2" ID="btnCancel" Width="40%" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
            </div>
        </div>
    </div>


    <script>

    </script>
</asp:Content>
