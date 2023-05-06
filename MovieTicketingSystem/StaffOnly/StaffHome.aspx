    <%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffHome.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.StaffHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container my-10"  style="min-height:90vh;">

        <h1 class="text-white pt-2">Home Page</h1>
        <hr width="100%" style="border: 1px solid white"/>
        <asp:Label ID="TBDate" CssClass="text-white float-end" runat="server"></asp:Label> <br />
        <div class="row mt-3">
            <div class="PaymentDetailsContainer text-white m-3" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);width:45%;">
                <h2 class="text-white text-center">Ticket Sales</h2> <hr style="color:white;" />
                <div class="row m-3">
                    <div class="col-6 m-0">
                        <asp:Label ID="lblTicketSold" runat="server" cssClass="text-white" Text="Total Ticket Sold Today "></asp:Label>
                    </div>
                    <div class="col-6 m-0">
                        <asp:Literal ID="litTicketSold" runat="server"></asp:Literal>
                    </div>
                </div>
              <div class="row m-3">
                    <div class="col-6 m-0">
                        <asp:Label ID="lblMostFood" runat="server" Text="Most popular Item of the Day "></asp:Label>
                    </div> 
                    <div class="col-6 m-0">
                        <asp:Literal ID="LitlblMostFood" runat="server"></asp:Literal>
                    </div> 
                </div>
                <div class="row m-3">
                    <div class="col-6 m-0">
                        <asp:Label ID="Label2" runat="server" Text="Total Movie Sales today "></asp:Label>
                    </div> 
                    <div class="col-6 m-0">
                        <asp:Literal ID="LitlblMovieSales" runat="server" Text="RM 0.00"></asp:Literal>
                    </div> 
                </div>
            </div>
            <div class="PaymentDetailsContainer text-white m-3" style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);width:45%;">
                <h2 class="text-white text-center">F&B Sales</h2> <hr style="color:white;" />
                <div class="row m-3">
                    <div class="col-6 m-0">
                        <asp:Label ID="lblFoodSold" runat="server" Text="Total Food Item Sold "></asp:Label>
                    </div>
                    <div class="col-6 m-0 ">
                        <asp:Literal ID="LitFoodSold" runat="server"></asp:Literal>
                    </div>
                </div>
                  <div class="row m-3">
                    <div class="col-6 m-0">
                        <asp:Label ID="lblMostMovie" runat="server" Text="Most popular Movie of the Day "></asp:Label>
                    </div> 
                    <div class="col-6 m-0">
                        <asp:Literal ID="LitlblMostMovie" runat="server"></asp:Literal>
                    </div> 
                </div> 
                <div class="row m-3">
                    <div class="col-6 m-0">
                        <asp:Label ID="Label1" runat="server" Text="Total Food Sales today "></asp:Label>
                    </div> 
                    <div class="col-6 m-0">
                        <asp:Literal ID="LitlblFoodSales" runat="server"></asp:Literal>
                    </div> 
                </div>
            </div >
            <div class="text-white"  style="font-size:20px;width:45%;" >
                <h2 class="text-white text-center">Schedule Today</h2> <hr style="color:white;" />
                <asp:GridView ID="ScheduleTable" runat="server" CssClass="table w-100 table-dark table-striped my-1 table-bordered table-responsive table-hover">
                </asp:GridView>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
</asp:Content>
