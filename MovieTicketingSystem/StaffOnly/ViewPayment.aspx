﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="ViewPayment.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.ViewPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
     <link href="../css/manageSchedule.css" rel="stylesheet" />
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("[id*=paymentGridView]").DataTable(
                {
                    bLengthChange: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true
                });
        });
    </script>

    <div class="container" style="height:700px;">
        <h2 class="text-white">Maintain Payment</h2>
        <hr />
        <div class="containerPayment text-white">
            <%--<div class="d-flex justify-content-end">
                <asp:TextBox ID="txtPaymentSearch" runat="server" style="width:40%;" Cssclass="ms-4 rounded-4 p-2" placeholder="Search"></asp:TextBox>
                <button class="btn btn-default my-2" style="width:40px" type="submit" onclick="btnSearch_Click" ><i class="fas fa-search"></i></button>
            </div>--%>
            <br />
            <%--<asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM [Payment]"></asp:SqlDataSource>--%>
            <asp:GridView ID="paymentGridView" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="paymentNo" ClientIDMode="Static">
                <HeaderStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle  Height="50px" BackColor="#262626" ForeColor="White" BorderColor="White" HorizontalAlign="Center"/>
                <AlternatingRowStyle BackColor="#5c5c5c" ForeColor="White" BorderColor="White" />
                <PagerStyle CssClass="gridview-pager" BackColor="black" ForeColor="white" HorizontalAlign="Center"/>
                <SelectedRowStyle BackColor="#f4e618" ForeColor="Black" />
                <Columns>
                    <asp:BoundField DataField="paymentNo" HeaderText="Payment No" ReadOnly="True" SortExpression="paymentNo" />
                    <asp:BoundField DataField="purchaseNo" HeaderText="Purchase No" SortExpression="purchaseNo" />
                    <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                    <asp:BoundField DataField="paymentDateTime" HeaderText="Payment Date & Time" SortExpression="paymentDateTime" />
                    <asp:TemplateField HeaderText="Actions" >
                        <ItemTemplate>
                            <asp:LinkButton ID="btnView" OnClick="btnView_Click" runat="server" Text="View" CommandName="View" CommandArgument='<%# Eval("paymentNo") %>'  class="btn btn-default"  />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </div>
</asp:Content>
