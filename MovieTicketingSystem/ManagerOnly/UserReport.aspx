<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="UserReport.aspx.cs" Inherits="MovieTicketingSystem.ManagerOnly.UserReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            var options = {
                title: 'Top 5 Customers Report',
                width: 600,
                height: 400,
                bar: { groupWidth: "95%" },
                legend: { position: "none" },
                isStacked: true
            };
            $.ajax({
                type: "POST",
                url: "UserReport.aspx/GetChartData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Name');
                    data.addColumn('number', 'AmountSold');
                    for (var i = 0; i < r.d.length; i++) {
                        data.addRow([String(r.d[i][0]), parseFloat(r.d[i][1])]);
                    }
                    var chart = new google.visualization.PieChart($("#ChartReport")[0]);
                    chart.draw(data, options);
                },
                failure: function (r) {
                    alert("Error2: " + r.status + " " + r.statusText + " " + r.responsetext);
                },
                error: function (r) {
                    alert("Error: " + r.status + " " + r.statusText + " " + r.responsetext);
                }
            });
        }
    </script>
<div class="container row" id="reportContainer" style="height:700px;">
  <div class="col-md-4 p-3">
         <div class="row ">
                <h1  class="nav nav-tabs flex-column align-items-center border-0" >Report Type</h1>
                <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnSale" runat="server" Text="Sale Report" class="profileTab nav-link " OnClick="btnSale_Click"  type="button" CausesValidation="false"/>
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnMovieReport" runat="server" Text="Movie Report" class="profileTab  nav-link" type="button" OnClick="btnMovieReport_Click"  CausesValidation="false"/>
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnFoodReport" runat="server" Text="Food Sale Report " class="profileTab  nav-link " type="button" OnClick="btnFoodReport_Click"  CausesValidation="false" />
                    </li>
                     <li class="nav-item mb-3">
                        <asp:Button ID="btnTopFoodPurchase" runat="server" Text="Top Purchase Food Report " class="profileTab nav-link " type="button" OnClick="btnTopFoodPurchase_Click" CausesValidation="false" />
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnUser" runat="server" Text="User Report" class="profileTab active nav-link" type="button" OnClick="btnUser_Click" CausesValidation="false"/>
                    </li>
                </ul>
        </div>
      </div>


    <div class="col-md-8" style="height:650px;">
        <div class="tab-content container-fluid" id="nav-tabContent">
           <div class="tab-pane fade show active p-3" id="reportContenier">
               <div class="text-white w-100">
                   <!----Start uour report here --->    
                   <h1> User Report</h1>
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT TOP (5) Customer.custId AS ID, SUM(Purchase.ticketTotal) AS Total_Ticket_Sold, SUM(Purchase.foodTotal) AS Total_Food_Sold FROM Customer INNER JOIN Purchase ON Customer.custId = Purchase.custId INNER JOIN Payment ON Purchase.purchaseNo = Payment.purchaseNo GROUP BY Customer.custId"></asp:SqlDataSource>
                   <div id="ReportSetting">
                       <asp:Panel ID="Panel1" runat="server">
                            <div class="row mx-auto" runat="server" >
                         <div class="form-floating m-auto mb-3 w-50" id="topAmountDiv" runat="server" >
                            <asp:TextBox ID="tbtotalItem" runat="server" class="form-control" placeholder="Total Item" AutoPostBack="true" OnTextChanged="tbtotalItem_TextChanged" AutoComplete="off" TextMode="Number"></asp:TextBox>                                                         
                          <label for="tbtotalItem"> Total Customer </label> 
                    </div>
                      </div>
                      <div class="row mx-auto" runat="server" id="timeRangeDiv">
                        <div class="form-floating m-auto mb-3">
                            <asp:TextBox ID="tbFoodReportStartDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoPostBack="true" AutoComplete="off" TextMode="Date" OnTextChanged="tbFoodReportStartDate_TextChanged" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                            <label for="tbFoodReportStartDate" > Start From </label> 
                        </div>
                        <div class="form-floating my-auto p-0" style="width:fit-content;"> Until </div>
                        <div class="form-floating m-auto mb-3">
                            <asp:TextBox ID="tbFoodReportEndDate" runat="server" class="form-control" placeholder="End Date" AutoPostBack="true" AutoComplete="off" TextMode="Date" OnTextChanged="tbFoodReportEndDate_TextChanged" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                            <label for="tbFoodReportEndDate" > End At </label> 
                        </div>
                    </div>
                       </asp:Panel>
                   </div>
                     
                   <hr width="100%" style="border: 1px solid white"/>
                   <div runat="server" id="displayReport" visible="false">
                       <h1> Top 5 Customer Report</h1>
                   
                        <div class="row ">
                            <div class="col-6 m-0 justify-content-center">
                                <asp:Label ID = "lblDate" runat="server" cssClass="text-white" Text="Generate On"></asp:Label>
                            </div>
                            <div class="col-6 m-0 justify-content-center">
                                <asp:Literal ID = "litDate" runat="server"></asp:Literal>
                            </div>
                        </div>
                       <div>
                           <asp:GridView ID="GVReport" runat="server"></asp:GridView>
                       </div>
                        <br />
                         <div id="ChartReport"></div>
                   </div>
               
               </div>
           </div>
        </div>
    </div>
</div>
</asp:Content>
