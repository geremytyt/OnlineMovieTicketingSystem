<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="ViewPayment.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.ViewPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
     <link href="../css/manageSchedule.css" rel="stylesheet" />
    <div class="container" style="height:700px;">
        <h2 class="text-white">Maintain Payment</h2>
        <hr />
        <div class="containerPayment" >
            <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM [Payment]"></asp:SqlDataSource>
            <asp:GridView ID="paymentGridView" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="paymentNo" 
                DataSourceID="SqlDataSourcePayment" AutoPostBack="True" AllowPaging="True" 
                AllowSorting="True" PageSize="10" OnSelectedIndexChanged="paymentGridView_SelectedIndexChanged">
                <HeaderStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle  Height="50px" BackColor="#262626" ForeColor="White" BorderColor="White" HorizontalAlign="Center"/>
                <AlternatingRowStyle BackColor="#5c5c5c" ForeColor="White" BorderColor="White" />
                <PagerStyle CssClass="gridview-pager" BackColor="black" ForeColor="white" HorizontalAlign="Center"/>
                <SelectedRowStyle BackColor="#f4e618" ForeColor="Black" />
                <Columns>
                    <asp:BoundField DataField="paymentNo" HeaderText="Payment No" ReadOnly="True" SortExpression="paymentNo" />
                    <asp:BoundField DataField="purchaseNo" HeaderText="Purchase No" SortExpression="purchaseNo" />
                    <asp:BoundField DataField="paymentType" HeaderText="paymentType" SortExpression="paymentType" />
                    <asp:BoundField DataField="paymentDateTime" HeaderText="Payment Date & Time" SortExpression="paymentDateTime" />
                    <asp:TemplateField HeaderText="Actions" >
                        <ItemTemplate>
                            <asp:LinkButton ID="btnView" OnClick="btnView_Click" runat="server" Text="View" CommandName="View" CommandArgument='<%# Eval("paymentNo") %>'  CssClass="text-light" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </div>
</asp:Content>
