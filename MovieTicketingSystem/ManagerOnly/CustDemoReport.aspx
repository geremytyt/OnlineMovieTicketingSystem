<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="CustDemoReport.aspx.cs" Inherits="MovieTicketingSystem.ManagerOnly.CustDemoReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);
        google.charts.setOnLoadCallback(drawChart2);
        function drawChart() {
            var options = {
                title: 'Gender Distribution',
                width: 600,
                height: 400,
                bar: { groupWidth: "95%" },
                legend: { position: "none" },
                isStacked: true
            };
            $.ajax({
                type: "POST",
                url: "CustDemoReport.aspx/GetChartData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Gender');
                    data.addColumn('number', 'Quantity');
                    for (var i = 0; i < r.d.length; i++) {
                        data.addRow([String(r.d[i][0]), r.d[i][1]]);
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
        function drawChart2() {
            var options = {
                title: 'Age Distribution',
                width: 600,
                height: 400,
                bar: { groupWidth: "95%" },
                legend: { position: "none" },
                isStacked: true
            };
            $.ajax({
                type: "POST",
                url: "CustDemoReport.aspx/GetChartData2",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Age Group');
                    data.addColumn('number', 'Quantity');
                    for (var i = 0; i < r.d.length; i++) {
                        data.addRow([String(r.d[i][0]), r.d[i][1]]);
                    }
                    var chart = new google.visualization.ColumnChart($("#ChartReport2")[0]);
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
<div class="container row" id="reportContainer" style="min-height:100vh;">
  <div class="col-md-4 p-3">
         <div class="row ">
                <h1  class="nav nav-tabs flex-column align-items-center border-0" >Report Type</h1>
                <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnSale" runat="server" Text="Sales Revenue Report" class="profileTab nav-link " OnClick="btnSale_Click"  type="button" CausesValidation="false"/>
                    </li>
                    <li class="nav-item mb-3">
                            <asp:Button ID="btnRefund" runat="server" Text="Refund Report" class="profileTab nav-link" OnClick="btnRefund_Click" type="button" CausesValidation="false"/>
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
                        <asp:Button ID="btnCustDemo" runat="server" Text="Customer Demographic Report" class="profileTab active nav-link" type="button" OnClick="btnCustDemo_Click" CausesValidation="false"/>
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnTopCust" runat="server" Text="Top Customer Report" class="profileTab nav-link" type="button" OnClick="btnTopCust_Click" CausesValidation="false"/>
                    </li>
                </ul>
        </div>
      </div>


    <div class="col-md-8">
        <div class="tab-content container-fluid" id="nav-tabContent">
           <div class="tab-pane fade show active p-3" id="reportContenier">
               <div class="text-white w-100">
                   <!----Start uour report here --->    
                   <hr width="100%" style="border: 1px solid white"/>
                   <div runat="server" id="displayReport" class="border border-light p-5">
                       <h1 class="text-center"> Customers Demographic Report</h1>
                       <div class="justify-content-end d-flex">
                            <asp:Label ID = "lblDate" runat="server" cssClass="text-white mx-2" Text="Generated On: "></asp:Label>
                            <asp:Literal ID = "litDate" runat="server"></asp:Literal>
                       </div>
                    <div id="ChartReport" class="my-3 mx-auto d-flex align-items-center justify-content-center"></div>
                    <div id="ChartReport2" class="my-3 mx-auto d-flex align-items-center justify-content-center"></div>

                    </div>
               </div>
           </div>
        </div>
    </div>
</div>
</asp:Content>
