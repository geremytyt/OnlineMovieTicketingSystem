<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="TopCustomerReport.aspx.cs" Inherits="MovieTicketingSystem.ManagerOnly.TopCustomerReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            var options = {
                title: 'Top Customers Report',
                width: 600,
                height: 400,
                bar: { groupWidth: "95%" },
                legend: { position: "none" },
                isStacked: true
            };
            $.ajax({
                type: "POST",
                url: "TopCustomerReport.aspx/GetChartData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'Name');
                    data.addColumn('number', 'Amount Purchased(RM)');
                    for (var i = 0; i < r.d.length; i++) {
                        data.addRow([String(r.d[i][0]), parseFloat(r.d[i][1])]);
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
                        <asp:Button ID="btnCustDemo" runat="server" Text="Customer Demographic Report" class="profileTab nav-link" type="button" OnClick="btnCustDemo_Click" CausesValidation="false"/>
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnTopCust" runat="server" Text="Top Customer Report" class="profileTab active nav-link" type="button" OnClick="btnTopCust_Click" CausesValidation="false"/>
                    </li>
                </ul>
        </div>
      </div>


    <div class="col-md-8">
        <div class="tab-content container-fluid" id="nav-tabContent">
           <div class="tab-pane fade show active p-3" id="reportContenier">
               <div class="text-white w-100">
                   <!----Start uour report here --->    
                   <div id="ReportSetting">
                       <asp:Panel ID="Panel1" runat="server" DefaultButton="btnReport">
                            <div class="row" runat="server" >
                         <div class="row mx-auto form-floating mb-3 w-50" id="topAmountDiv" runat="server" >
                            <asp:TextBox ID="txtCust" runat="server" class="form-control userInput" placeholder="" TextMode="Number"></asp:TextBox>                                                         
                            <label for="tbtotalCust"> Total Customer </label> 
                             <asp:RangeValidator ID="rvCust" runat="server" ErrorMessage="Number must be between 0 to 10" Type="Integer" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtCust" MinimumValue="1" MaximumValue="10" CssClass="text-danger"></asp:RangeValidator>
                             <asp:RequiredFieldValidator ID="rfvCust" runat="server" ErrorMessage="Please enter number of customer" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtCust" CssClass="text-danger"></asp:RequiredFieldValidator>
                        </div>
                      </div>
                      <div class="row" runat="server" id="timeRangeDiv">
                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtStartDate" runat="server" class="form-control userInput" placeholder="dd/mm/yyyy" TextMode="Date" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                            <label for="txtStartDate" > Start From </label> 
                            <asp:RequiredFieldValidator ID="rfvStart" runat="server" ErrorMessage="Please select start date" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtStartDate" CssClass="text-danger" ></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvStart" runat="server" ErrorMessage="Start date must be before end date" Type="Date" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtStartDate" ControlToCompare="txtEndDate" Operator="LessThanEqual" CssClass="text-danger"></asp:CompareValidator>
                        </div>
                        <div class="form-floating my-auto p-0" style="width:fit-content;"> Until </div>
                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtEndDate" runat="server" class="form-control userInput" placeholder="End Date" TextMode="Date" onkeypress="return false;" onpaste="return false" ></asp:TextBox>                            
                            <label for="tbFoodReportEndDate" > End At </label> 
                            <asp:RequiredFieldValidator ID="rfvEnd" runat="server" ErrorMessage="Please select end date" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtEndDate" CssClass="text-danger" ></asp:RequiredFieldValidator>
                        </div>
                          <div class="justify-content-end align-items-right d-flex">
                              <asp:Button ID="btnReport" runat="server" OnClick="btnReport_Click" CssClass="btn btn-default w-25" Text="Generate"/>
                          </div>
                    </div>
                       </asp:Panel>
                   </div>
                     
                   <hr width="100%" style="border: 1px solid white"/>
                   <div runat="server" id="displayReport" visible="false" class="border border-light p-5">
                       <h1 class="text-center"> Top Customers Report</h1>
                       <div class="justify-content-end d-flex">
                            <asp:Label ID = "lblDate" runat="server" cssClass="text-white mx-2" Text="Generated On: "></asp:Label>
                            <asp:Literal ID = "litDate" runat="server"></asp:Literal>
                       </div>
                        <div class="justify-content-end d-flex">
                            <asp:Label ID = "Label1" runat="server" cssClass="text-white mx-2" Text="Date Range: "></asp:Label>
                            <asp:Literal ID = "Literal1" runat="server"></asp:Literal>
                        </div>
                    <div id="ChartReport" class="my-3 mx-auto d-flex align-items-center justify-content-center"></div>
                    <div class="mt-5 mx-auto">
                        <asp:GridView ID="GVReport" runat="server" CssClass="table w-100 table-dark table-striped my-1 table-bordered table-responsive table-hover"></asp:GridView>
                    </div>
                    </div>
               </div>
           </div>
        </div>
    </div>
</div>
</asp:Content>
