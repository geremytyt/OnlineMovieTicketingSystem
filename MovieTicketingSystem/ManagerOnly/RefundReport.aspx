<%@ Page Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="RefundReport.aspx.cs" Inherits="MovieTicketingSystem.ManagerOnly.RefundReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            var options = {
                title: 'Refund Report on Selected Months',
                width: 600,
                height: 400,
                bar: { groupWidth: "95%" },
                legend: { position: "none" },
                isStacked: true
            };
            $.ajax({
                type: "POST",
                url: "RefundReport.aspx/GetChartData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Month');
                    data.addColumn('number', 'Total Refund Amount (RM)');
                    for (var i = 0; i < r.d.length; i++) {
                        var month = new Date(Date.parse(r.d[i][0] + " 01, 2000")).toLocaleString("en-us", { month: "short" });
                        data.addRow([month, parseFloat(r.d[i][1])]);
                    }
                    var chart = new google.visualization.ColumnChart($("#ChartReport")[0]);
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
                            <asp:Button ID="btnSale" runat="server" Text="Sale Report" class="profileTab nav-link" OnClick="btnSale_Click" type="button" CausesValidation="false"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnRefund" runat="server" Text="Refund Report" class="profileTab nav-link active" OnClick="btnRefund_Click" type="button" CausesValidation="false"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnMovieReport" runat="server" Text="Movie Report" class="profileTab nav-link" OnClick="btnMovieReport_Click" type="button" CausesValidation="false"/>
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnFoodReport" runat="server" Text="Food Sale Report " class="profileTab nav-link" OnClick="btnFoodReport_Click" type="button"  CausesValidation="false" />
                        </li>
                         <li class="nav-item mb-3">
                            <asp:Button ID="btnTopFoodPurchase" runat="server" Text="Top Purchase Food Report " class="profileTab nav-link " type="button" OnClick="btnTopFoodPurchase_Click" CausesValidation="false" />
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnUser" runat="server" Text="User Report" class="profileTab nav-link" OnClick="btnUser_Click"  type="button" CausesValidation="false"/>
                        </li>
                    </ul>
            </div>
          </div>


        <div class="col-md-8" style="height:650px;">
            <div class="tab-content container-fluid" id="nav-tabContent">
               <div class="tab-pane fade show active p-3" id="reportContenier">
                   <div class="text-white w-100">
                       <!----Start uour report here --->    
                       
                           <div id="ReportSetting">
                           <asp:Panel ID="Panel1" runat="server">
                          <div class="row mx-auto" runat="server" id="timeRangeDiv">
                            <div class="form-floating m-auto mb-3">
                                <asp:TextBox ID="tbRefundReportStartDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoPostBack="true" AutoComplete="off" TextMode="Date" OnTextChanged="tbRefundReportStartDate_TextChanged" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                                <label for="tbRefundReportStartDate" > Start From </label> 
                            </div>
                            <div class="form-floating my-auto p-0" style="width:fit-content;"> Until </div>
                            <div class="form-floating m-auto mb-3">
                                <asp:TextBox ID="tbRefundReportEndDate" runat="server" class="form-control" placeholder="End Date" AutoPostBack="true" AutoComplete="off" TextMode="Date" OnTextChanged="tbRefundReportEndDate_TextChanged" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                                <label for="tbRefundReportEndDate" > End At </label> 
                            </div>
                        </div>
                           </asp:Panel>
                       </div>
                     
                       <hr width="100%" style="border: 1px solid white"/>
                       <div runat="server" id="displayReport" visible="false">
                           <h1> Refund Report</h1>
                   
                            <div class="row ">
                                <div class="col-6 m-0 justify-content-center">
                                    <asp:Label ID = "lblDate" runat="server" cssClass="text-white" Text="Generated On"></asp:Label>
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

