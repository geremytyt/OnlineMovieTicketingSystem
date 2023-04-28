<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffHome.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.StaffHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container my-10">

        <h1 style="color:white; font-weight:900; ">Dash Board</h1>

        <asp:Label ID="TBDate" CssClass="text-white" runat="server"></asp:Label> <br />


        <div class="row">
             <div class="text-white col-6 border border-white" style="font-size:20px;">
                <div class="row">
                    <div class="col-6 m-0">
                        <asp:Label ID="lblTicketSold" runat="server" cssClass="text-white" Text="Total Ticket Sold Today "></asp:Label>
                    </div>
                    <div class="col-6 m-0">
                        <asp:Literal ID="litTicketSold" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6 m-0">
                <asp:Label ID="lblFoodSold" runat="server" Text="Total Food Item Sold "></asp:Label>
                </div>
                <div class="col-6 m-0 ">
                        <asp:Literal ID="LitFoodSold" runat="server"></asp:Literal>
                </div>
                </div>
                <div class="row">
                    <div class="col-6 m-0">
                        <asp:Label ID="lblMostMovie" runat="server" Text="Most popular Movie of the Day "></asp:Label>
                    </div> 
                    <div class="col-6 m-0">
                        <asp:Literal ID="LitlblMostMovie" runat="server"></asp:Literal>
                    </div> 
                </div> 
                <div class="row">
                    <div class="col-6 m-0">
                        <asp:Label ID="lblMostFood" runat="server" Text="Most popular Food Item of the Day: "></asp:Label>
                    </div> 
                    <div class="col-6 m-0">
                        <asp:Literal ID="LitlblMostFood" runat="server"></asp:Literal>
                    </div> 
                </div> 
            </div >
            
            <div class="text-white col-6"  style="font-size:20px;" >
                <asp:Label ID="GridViewTitle" runat="server" Text="Today Schedule "></asp:Label>
                <asp:GridView ID="ScheduleTable" runat="server">
                    <RowStyle Height="50px" BackColor="#262626" ForeColor="White" BorderColor="White" HorizontalAlign="Center"/>
             <AlternatingRowStyle BackColor="#5c5c5c" ForeColor="White" BorderColor="White" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
