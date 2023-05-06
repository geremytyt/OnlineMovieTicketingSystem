<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="UnavailableFoodManagement.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.UnavailableFoodManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>
    <script>
       $(function () {
           $("[id*=GVMenu]").DataTable(
               {
                   bLengthChange: true,
                   bFilter: true,
                   bSort: true,
                   bPaginate: true
               });
       });
    </script>
    <div class="container" style="min-height:100vh;">
         <h1 class="text-white pt-2">Food Management</h1>
        <hr width="100%" style="border: 1px solid white"/>
        <div class="row g-2">
            <div class="col containerLeft text-white">
                <div class="nav nav-tabs border-0"id="nav-tab" role="tablist">
                <asp:Button ID="btnAvailable" runat="server" Text="Available" CssClass="nav-link w-50 text-white mb-2" BorderColor="White" OnClick="btnAvailable_Click" />
                <asp:Button ID="btnUnAvailable" runat="server" Text="Unavailable" CssClass="nav-link active w-50 text-black mb-2 border-0" BackColor="#F4E618" />
            </div>
        <asp:GridView ID="GVMenu" class="GVmenu" runat="server" DataKeyNames="menuId" AutoGenerateColumns="False" ClientIDMode="Static"
                CssClass="table w-100 table-dark table-striped my-1 table-bordered table-responsive table-hover" >
            <Columns>
                <asp:BoundField DataField="menuId" HeaderText="Id" ReadOnly="True" SortExpression="menuId" />
                <asp:BoundField DataField="menuName" HeaderText="Name" SortExpression="menuName"  ItemStyle-Width="250px" ItemStyle-HorizontalAlign="Left">
<ItemStyle HorizontalAlign="Left" Width="250px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="menuCategory" HeaderText="Category" SortExpression="menuCategory" />
                <asp:BoundField DataField="menuPrice" HeaderText="Price (RM)" SortExpression="menuPrice" />
                 <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <div class="d-grid gap-2 d-md-flex">
                                <asp:Button ID="btnView" runat="server" Text="View" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default" OnCommand="btnView_Command" CausesValidation="false"/>
                            </div>
                        </ItemTemplate>
                 </asp:TemplateField>
            </Columns>
        </asp:GridView>
      </div>



        <div class="col containerRight"> 
                        <div class ="detailsView bg-dark rounded-4 text-white mb-2 border-0">
                <h3 class="bg-dark rounded-4 text-white mb-2 border-0 text-center mt-2">Menu Details</h3>
            <div class="row g-2">
                <div class="col-md">
                    <asp:Image ID="menuImg" style="height:200px; width:200px; display:none; " AlternateText="No Picture Uploaded" runat="server" />
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
                <asp:DropDownList ID="DDLCategory" Cssclass="form-control" Enabled="false" runat="server">
                    <asp:ListItem style="background-color:black;">Snack</asp:ListItem>
                    <asp:ListItem style="background-color:black;">Bevarage</asp:ListItem>
                    <asp:ListItem style="background-color:black;">Combo</asp:ListItem>
                </asp:DropDownList>
                <label for="tbCategory">Category</label> 
            </div>
            <div class="form-floating col-md px-3">
                <asp:TextBox ID="tbPrice" runat="server" class="form-control" placeholder="Price" TextMode="Number"  autocomplete="off" ReadOnly="true"></asp:TextBox>                            
                <label for="tbPrice">Price (RM)</label> 
            </div>
            <div class="form-floating mx-auto mb-3 px-3 w-100">
                <asp:TextBox ID="tbDecs" runat="server" class="form-control" placeholder="Description" autocomplete="off" ReadOnly="true" TextMode="MultiLine" ></asp:TextBox>                            
                <label for="tbDecs" >Description</label> 
            </div>
            <div class="actionBar">
                <asp:Button ID="btn_Continue" runat="server" Text="Continue" OnClick="btn_Continue_Click" class="actionButton"/>
            </div>
            </div>
            </div>
      </div>
</div>
</asp:Content>
