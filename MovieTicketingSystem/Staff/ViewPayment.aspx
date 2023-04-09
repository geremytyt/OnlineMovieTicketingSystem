<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="ViewPayment.aspx.cs" Inherits="MovieTicketingSystem.Staff.ViewPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
     <link href="../css/manageSchedule.css" rel="stylesheet" />
    <div class="container">
        <h2 class="pageTitle">Maintain Payment</h2>
        <hr />
        <div class="containerPayment" >
            <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:MovieDBConnectionString %>" SelectCommand="SELECT * FROM [Payment]"></asp:SqlDataSource>
            <asp:GridView ID="paymentGridView" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" DataKeyNames="paymentNo" 
                DataSourceID="SqlDataSourcePayment" AutoPostBack="True" AllowPaging="True" 
                AllowSorting="True" PageSize="10" OnSelectedIndexChanged="paymentGridView_SelectedIndexChanged">
                <HeaderStyle CssClass="gridview-header" />
                <RowStyle CssClass="gridview-row" />
                <AlternatingRowStyle CssClass="gridview-row" />
                <PagerStyle CssClass="gridview-pager" BackColor="black" ForeColor="white" HorizontalAlign="Center"/>
                <Columns>
                    <asp:BoundField DataField="paymentNo" HeaderText="Payment No" ReadOnly="True" SortExpression="paymentNo" />
                    <asp:BoundField DataField="purchaseNo" HeaderText="Purchase No" SortExpression="purchaseNo" />
                    <asp:BoundField DataField="paymentType" HeaderText="paymentType" SortExpression="paymentType" />
                    <asp:BoundField DataField="paymentDateTime" HeaderText="Payment Date & Time" SortExpression="paymentDateTime" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnView" OnClick="btnView_Click" runat="server" Text="View" CommandName="View" CommandArgument='<%# Eval("paymentNo") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </div>
</asp:Content>
