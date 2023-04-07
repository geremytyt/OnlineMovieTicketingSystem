<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="FoodManagement.aspx.cs" Inherits="MovieTicketingSystem.Staff.FoodManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
<link href="../css/MenuStyle.css" rel="stylesheet" />
        
    <div class="container" >
        <div class="row g-2">
            <div class="col containerLeft">
        <asp:GridView ID="GVMenu" class="GVmenu" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="menuId" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="Horizontal" BackColor="Yellow" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" ShowHeaderWhenEmpty="True"  OnSelectedIndexChanged="GVMenu_SelectedIndexChanged" >
            <AlternatingRowStyle BackColor="lightyellow" ForeColor="black" />
            <Columns>
                <asp:BoundField DataField="menuId" HeaderText="Id" ReadOnly="True" SortExpression="menuId" />
                <asp:BoundField DataField="menuName" HeaderText="Name" SortExpression="menuName"  ItemStyle-Width="250px" ItemStyle-HorizontalAlign="Left">
<ItemStyle HorizontalAlign="Left" Width="250px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="menuCategory" HeaderText="Category" SortExpression="menuCategory" />
                <asp:BoundField DataField="menuPrice" HeaderText="Price (RM)" SortExpression="menuPrice" />
                <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText=">>" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="Yellow" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="Yellow" Font-Bold="True" ForeColor="Black" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" HorizontalAlign="Center" Font-Underline="False" VerticalAlign="Middle" Wrap="True" />
            <PagerStyle BackColor="Yellow" ForeColor="Black" HorizontalAlign="Center" BorderColor="White" BorderStyle="Solid" Height="5px" VerticalAlign="Middle" Wrap="False" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Height="30px" />
            <SelectedRowStyle BackColor="Yellow" Font-Bold="True" ForeColor="Black" BorderColor="Black" BorderStyle="Double" BorderWidth="1px" VerticalAlign="Middle" Font-Italic="True" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [menuId], [menuName], [menuCategory], [menuPrice] FROM [Menu]"></asp:SqlDataSource>
      </div>

        <div class="col containerRight"> 
            <h3>Menu Details</h3>
            <div class="row g-2">
                <div class="col-md">
                    <img src="../Image/popcorn.png" class="image-box" style="height:200px; width:200px;" />
                </div>
                <div class="form-floating m-auto col-md px-3">
                    <asp:Label id="lblMenuId" runat="server" class="form-control">Select An Item</asp:Label>        
                    <label for="lblMenuId">Menu Id</label>        
                </div>
            </div>
            <div class="form-floating mx-auto mb-1 w-100 px-3">
                <asp:TextBox ID="tbName" runat="server" class="form-control" placeholder="Name" ReadOnly="true"  ></asp:TextBox>                            
                <label for="tbName" >Name</label> 
            </div>
            <div class="form-floating mx-auto mb-1 w-100 px-3">
                <asp:TextBox ID="tbCategory" runat="server" class="form-control" placeholder="Category" autocomplete="off" ReadOnly="true" ></asp:TextBox>                            
                <label for="tbCategory">Category</label> 
            </div>
            <div class="row g-2">
                <div class="form-floating col-md px-3">
                    <asp:TextBox ID="tbPrice" runat="server" class="form-control" placeholder="Price"  autocomplete="off" ReadOnly="true"></asp:TextBox>                            
                    <label for="tbPrice">Price</label> 
                </div>
                <div class="form-floating col-md px-3">
                    <asp:TextBox ID="tbRemark" runat="server" class="form-control" placeholder="Remarks"  autocomplete="off"  ReadOnly="true"></asp:TextBox>                            
                    <label for="tbRemark">Remarks</label> 
                </div>
            </div>
            <div class="form-floating mx-auto mb-3 px-3 w-100">
                <asp:TextBox ID="tbDecs" runat="server" class="form-control" placeholder="Description"  autocomplete="off" ReadOnly="true" TextMode="MultiLine" ></asp:TextBox>                            
                <label for="tbDecs" >Description</label> 
            </div>
            <div class="actionBar">
                <asp:Button ID="btn_add" class="actionButton" runat="server" Text="Add" OnClick="btn_add_Click"  Visible="false"/>
                <asp:Button ID="btn_back" runat="server" Text="Back" OnClick="btn_back_Click" class="actionButton" Visible="false"/>
                <asp:Button ID="btn_update" runat="server" Text="Update" OnClick="btn_update_Click" class="actionButton" Visible="false" />
                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" OnClick="btn_cancel_Click" class="actionButton" Visible="false"/>
                <asp:Button ID="btn_insert" runat="server" Text="Insert" OnClick="btn_insert_Click" class="actionButton" />
                <asp:Button ID="btn_edit" runat="server" Text="Edit" OnClick="btn_edit_Click" class="actionButton" />
                <asp:Button ID="btn_delete" runat="server" Text="Delete" OnClick="btn_delete_Click" class="actionButton" />
            </div>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Menu WHERE Menu.Menu_Id = @Menu_Id" >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GVMenu" Name="Menu_Id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
     </div>
</asp:Content>
