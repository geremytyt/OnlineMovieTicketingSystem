<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="ManageSchedule.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.ManageSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    
    <link href="../css/style.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("[id*=scheduleGridView]").DataTable(
                {
                    bLengthChange: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true
                });
        });
    </script>
    <style>
        /* Style for the GridView Container */
        .scheduleGridViewContainer {
            width: 60%;
            margin: 0 auto;
            float: left;
           /* padding-left: 5%;*/
        }

        .scheduleDetailsContainer {
            width: 35%;
            margin: 0 auto;
            float: right;
            /*padding-right: 5%;*/
    
        }
        #main_ddlMovieID, #main_ddlHall, #main_txtScheduleTime, #main_txtScheduleDate, #main_ddlStatus, #ddlMovieID, #ddlHall, #ddlStatus, #txtScheduleTime, #txtScheduleDate {
            border-radius: 0;
            border: none;
            background: none;
            color: white;
            border-bottom: 1px solid white;
        }

        .bg-dark.rounded-4.text-white.mb-2 {
            height: 500px;
        }
    </style>
    <div class="mx-auto" style="width:85%;">
    <div class="maintainScheduleContainer" style="height:700px;">
        <h2 class="text-white pt-2">Maintain Schedule</h2>
        <hr width="100%" style="border: 1px solid white"/>
        <div class="scheduleGridViewContainer text-white">
            
            <asp:GridView ID="scheduleGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="scheduleNo" ClientIDMode="Static" CssClass="text-white"
                  Width="100%">
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
                    <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnSelect" runat="server" Text="Select" CausesValidation="false" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default" OnCommand="btnSelect_Command"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="scheduleDetailsContainer">
            <div class="bg-dark rounded-4 text-white ">
                <div class="row">
                    <h3 class="text-center mt-2">Record</h3>
                  
                </div>
                <div class="m-4">
                    <label >Schedule No:</label>
                    <asp:Label ID="lblScheduleID" runat="server" Text="" CssClass="m-2"></asp:Label>
                </div>

                <div class="mx-4">
                    <label for="ddlMovieID">Movie ID</label> 
                </div>
                <div class="mx-4">
                    <asp:DropDownList ID="ddlMovieID" runat="server" DataSourceID="SqlDataSourceSchedule2"
                            DataTextField="movieId" DataValueField="movieId"  Width="95%" CssClass="mt-3 bg-dark"></asp:DropDownList>
                </div>
                <br />
                <div class="mx-4">
                    <label for="ddlHall">Hall No</label>
                </div>
                <div class="mx-4">
                    <asp:DropDownList ID="ddlHall" runat="server" DataSourceID="SqlDataSourceSchedule3"
                            DataTextField="hallNo" DataValueField="hallNo" Width="95%" CssClass="mt-3 bg-dark"></asp:DropDownList>
                </div>
                
                <br />
                <div class="mx-4">
                    <label for="txtScheduleDate">Schedule Date</label>
                </div>
                <div class="mx-4">
                    <asp:TextBox ID="txtScheduleDate" runat="server" CssClass="form-control" placeholder=" " TextMode="Date"/>
                    <asp:RequiredFieldValidator ID="rfvScheduleDate" runat="server" ControlToValidate="txtScheduleDate" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter schedule date"></asp:RequiredFieldValidator>
                </div>

                <br />
                <div class="mx-4">
                    <label for="txtScheduleTime">Schedule Time</label>
                </div>
                <div class="mx-4">
                    <asp:TextBox ID="txtScheduleTime" runat="server" CssClass="form-control" placeholder=" " TextMode="Time"/>
                    <asp:RequiredFieldValidator ID="rfvScheduleTime" runat="server" ControlToValidate="txtScheduleTime" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter schedule time"></asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="mx-4">
                    <label>Status</label>
                </div>
                <div class="mx-4">
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control mt-3 bg-dark">
                            <asp:ListItem Text="Active" Value="Active" />
                            <asp:ListItem Text="Cancelled" Value="Cancelled" />
                    </asp:DropDownList>
                </div>

                <br />
                
                <div class="m-4">
                    <asp:Button ID="btnAdd"  runat="server" Text="Add" CssClass="btn btn-default" CausesValidation="false" Width="40%" OnClick="btnAdd_Click"/>
                    <asp:Button ID="btnEdit"  runat="server" Text="Edit" CssClass="btn btn-default" CausesValidation="false" Width="40%" OnClick="btnEdit_Click" />
                    <asp:Button ID="btnConfirm"  runat="server" Text="Confirm" CssClass="btn btn-default" CausesValidation="true" Width="40%" OnClick="btnConfirm_Click" />
                    <asp:Button ID="btnCancel"  runat="server" Text="Cancel" CssClass="btn btn-default" CausesValidation="false" Width="40%" OnClick="btnCancel_Click" />
                </div>
                <br />
                
              
            </div>
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSourceSchedule2" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>'
                SelectCommand="SELECT movieId FROM Movie"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSchedule3" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>'
                SelectCommand="SELECT hallNo FROM Hall"></asp:SqlDataSource>
        </div>
    </div>
        </div>
</asp:Content>

