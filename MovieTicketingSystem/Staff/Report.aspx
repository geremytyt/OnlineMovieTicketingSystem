<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="MovieTicketingSystem.Manager.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

<div class="container" id="reportContainer" style="height:700px;">
  
        <!---report setting--->
         <div class="reportsetting">
                    <!--Select report type-->
                    <div class="row mx-auto">
                    <div class="form-floating m-auto mb-3 w-50">
                        <asp:DropDownList ID="DDLFoodreport" runat="server"  class="form-control" placeholder="Select An Item" AutoPostBack="true" OnSelectedIndexChanged="DDLFoodreport_SelectedIndexChanged" >
                            <asp:ListItem  style="background-color:black;" Text="Top Sales item" Value="Top Sales item">Top Sales item</asp:ListItem>
                            <asp:ListItem  style="background-color:black;" Text="Most Purchase item" Value="Most Purchase item">Most Purchase item</asp:ListItem>
                            <asp:ListItem  style="background-color:black;" Text="Menu Category Report" Value="Menu Category Report">Menu Category Report</asp:ListItem>
                            <asp:ListItem  style="background-color:black;" Text="Demographic Report" Value="Demographic Report">Demographic Report</asp:ListItem>
                        </asp:DropDownList>
                        <label for="DDLFoodreport"> Report Type </label> 
                    </div>
                    <div class="form-floating m-auto mb-3 w-50" id="topAmountDiv" runat="server" visible="false">
                        <asp:TextBox ID="tbtotalItem" runat="server" class="form-control" placeholder="Total Item" AutoComplete="off" TextMode="Number" AutoPostBack="true" OnTextChanged="DDLFoodreport_SelectedIndexChanged" ></asp:TextBox>                                                         
                            <label for="tbtotalItem"> Total Item </label> 
                    </div>
                    </div>                     

                <!--Enter time range-->
                    <div class="row mx-auto" runat="server" visible="false" id="timeRangeDiv">
                    <div class="form-floating m-auto mb-3">
                        <asp:TextBox ID="tbFoodReportStartDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoComplete="off" TextMode="Date" AutoPostBack="true" OnTextChanged="DDLFoodreport_SelectedIndexChanged" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                        <label for="tbFoodReportStartDate" > Start From </label> 
                    </div>
                        <div class="form-floating my-auto p-0" style="width:fit-content;"> Until </div>
                    <div class="form-floating m-auto mb-3">
                        <asp:TextBox ID="tbFoodReportEndDate" runat="server" class="form-control" placeholder="End Date" AutoComplete="off" TextMode="Date"  AutoPostBack="true" OnTextChanged="DDLFoodreport_SelectedIndexChanged" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                        <label for="tbFoodReportEndDate" > End At </label> 
                    </div>
                </div>
         </div>    
            
        <div class="reportdisplay">
            <div class="form-floating mx-auto mb-1 w-100 px-3">
                <h4 style="text-align:center" class="mx-auto"> <asp:Label ID="lblFoodReporttitle" runat="server" Text=""></asp:Label></h4>
                <div runat="server" id="ReportGenerator" class="foodreport">
                    <!-- generate table based on the type of based on the given report type at code behind-->   
                            
                    <!--end-->
                </div>
                </div>
        </div>
            
</div>
</asp:Content>
