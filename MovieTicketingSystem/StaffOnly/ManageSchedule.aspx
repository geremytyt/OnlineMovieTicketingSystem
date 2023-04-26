<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="ManageSchedule.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.ManageSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/manageSchedule.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>
    <div class="container" style="height:700px;">
        <h2 class="text-white">Maintain Schedule</h2>
        <hr />
        <div class="container1">
            <asp:SqlDataSource ID="SqlDataSourceSchedule" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT * FROM [Schedule]"></asp:SqlDataSource>
            <asp:GridView ID="scheduleGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="scheduleNo" CssClass="text-white"
                DataSourceID="SqlDataSourceSchedule" OnSelectedIndexChanged="scheduleGridView_SelectedIndexChanged" AutoPostBack="True" AllowPaging="True"
                AllowSorting="True" Width="100%">
                <RowStyle Height="50px" BackColor="#262626" ForeColor="White" BorderColor="White" HorizontalAlign="Center"/>
                <AlternatingRowStyle BackColor="#5c5c5c" ForeColor="White" BorderColor="White" />
                <HeaderStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#f4e618" ForeColor="Black"/>
                <PagerStyle CssClass="gridview-pager" BackColor="black" ForeColor="white" HorizontalAlign="Center"/>
                <Columns>
                    <asp:BoundField DataField="scheduleNo" HeaderText="Schedule No" ReadOnly="True" SortExpression="scheduleNo" />
                    <asp:BoundField DataField="movieId" HeaderText="Movie Id" SortExpression="movieId" />
                    <asp:BoundField DataField="hallNo" HeaderText="Hall No" SortExpression="hallNo" />
                    <asp:BoundField DataField="scheduleDateTime" HeaderText="Schedule Date & Time" SortExpression="scheduleDateTime" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnSelect" runat="server" Text="Select" CommandName="Select" CssClass="text-light" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="container2">
            <div class="bg-dark rounded-4 text-white ">
                <div class="row">
                    <h3 class="text-center mt-2">Record</h3>
                    <div>
                        <asp:TextBox ID="txtScheduleSearch" runat="server" style="width:70%;" Cssclass="ms-4 rounded-4 p-2" placeholder="Search"></asp:TextBox>
                        <button class="btn btn-default my-2" style="width:40px" type="submit" onclick="btnSearch_Click" ><i class="fas fa-search"></i></button>
                    </div>
                </div>
                <div class="m-4">
                    <label >Customer ID:</label>
                    <asp:Label ID="lblScheduleID" runat="server" Text="" CssClass="m-2">Test</asp:Label>
                </div>

                <div class="mx-4">
                    <label for="ddlMovieID">Movie ID</label> 
                </div>
                <div class="mx-4">
                    <asp:DropDownList ID="ddlMovieID" runat="server" DataSourceID="SqlDataSourceSchedule2"
                            DataTextField="movieId" DataValueField="movieId"  Width="95%" CssClass="mt-3"></asp:DropDownList>
                </div>
                <br />
                <div class="mx-4">
                    <label for="ddlHall">Hall No</label>
                </div>
                <div class="mx-4">
                    <asp:DropDownList ID="ddlHall" runat="server" DataSourceID="SqlDataSourceSchedule3"
                            DataTextField="hallNo" DataValueField="hallNo" Width="95%" CssClass="mt-3"></asp:DropDownList>
                </div>

                <br />
                <div class="mx-4">
                    <label for="txtScheduleDate">Schedule Date</label>
                </div>
                <div class="mx-4">
                    <asp:TextBox ID="txtScheduleDate" runat="server" CssClass="form-control" placeholder=" " TextMode="Date"/>
                </div>

                <br />
                <div class="mx-4">
                    <label for="txtScheduleTime">Schedule Time</label>
                </div>
                <div class="mx-4">
                    <asp:TextBox ID="txtScheduleTime" runat="server" CssClass="form-control" placeholder=" " TextMode="Time" Pattern="[0-9]{1,2}:[0-9]{1,2}:[0-9]{2}"/>
                </div>
                
                <div class="m-4">
                    <asp:Button ID="btnAdd"  runat="server" Text="Add" CssClass="btn btn-default" Width="40%" OnClick="btnAdd_Click"/>
                    <asp:Button ID="btnEdit"  runat="server" Text="Edit" CssClass="btn btn-default" Width="40%" OnClick="btnEdit_Click" />
                    <asp:Button ID="btnConfirm"  runat="server" Text="Confirm" CssClass="btn btn-default" Width="40%" OnClick="btnConfirm_Click" />
                    <asp:Button ID="btnCancel"  runat="server" Text="Cancel" CssClass="btn btn-default" Width="40%" OnClick="btnCancel_Click" />
                </div>
                <br />
                <%--<asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ddlHall" CssClass="error" Display="Dynamic" ErrorMessage="CustomValidator" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>--%>
                <asp:Label ID="lblInvalid" runat="server" CssClass="error" Display="Dynamic" Text="Hall is not available at the selected time. Please choose a different time or hall."></asp:Label>
            </div>
            <asp:SqlDataSource ID="SqlDataSourceSchedule2" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>'
                SelectCommand="SELECT DISTINCT movieId FROM Schedule"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSchedule3" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>'
                SelectCommand="SELECT DISTINCT hallNo FROM Schedule"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>

