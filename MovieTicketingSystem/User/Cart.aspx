<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="MovieTicketingSystem.User.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
<link href="../css/MenuStyle.css" rel="stylesheet" />
    
    <div id="Cartbackground">
        <h1>Cart Item</h1>
        
          <asp:Table class="cartList" runat="server" HorizontalAlign="Center">
            <asp:TableHeaderRow>
                <asp:TableHeaderCell Visible="false">Menu ID</asp:TableHeaderCell>
                <asp:TableHeaderCell>Name</asp:TableHeaderCell>
                <asp:TableHeaderCell>Category</asp:TableHeaderCell>
                <asp:TableHeaderCell>Price</asp:TableHeaderCell>
                <asp:TableHeaderCell>Quantity</asp:TableHeaderCell>
                <asp:TableHeaderCell>Total Price</asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableRow>
                <asp:TableCell Visible="false">1</asp:TableCell>
                <asp:TableCell>Pop Corn</asp:TableCell>
                <asp:TableCell>Snack</asp:TableCell>
                <asp:TableCell>9.00</asp:TableCell>
                <asp:TableCell>2</asp:TableCell>
                <asp:TableCell>18.00</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell Visible="false">2</asp:TableCell>
                <asp:TableCell>Coa-cola</asp:TableCell>
                <asp:TableCell>Bevarage</asp:TableCell>
                <asp:TableCell>2.20</asp:TableCell>
                <asp:TableCell>2</asp:TableCell>
                <asp:TableCell>4.40</asp:TableCell>
            </asp:TableRow>
            <asp:TableFooterRow>
                <asp:TableCell ColumnSpan="4">Total</asp:TableCell>
                <asp:TableCell >22.40</asp:TableCell>
            </asp:TableFooterRow>
        </asp:Table>

        <asp:Button ID="btn_proceed" CssClass="btn_proceed" runat="server" Text="Proceed to Payment" />
    </div>


</asp:Content>
