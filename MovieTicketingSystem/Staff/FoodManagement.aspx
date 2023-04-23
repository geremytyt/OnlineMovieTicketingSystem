<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="FoodManagement.aspx.cs" Inherits="MovieTicketingSystem.View.FoodManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
 <script>
        //saving file into
        function uploadImg() {
            var fileInput = document.getElementById("<%=FoodIMageUpload.ClientID%>");
            var file = fileInput.files[0];
            if (file) {
                var reader = new FileReader(); 
                reader.onload = function (e) {
                    var fileUrl = e.target.result;
                    var menuImg = document.getElementById("<%=menuImg.ClientID%>");
                    menuImg.src = fileUrl;
                    menuImg.style.display = "inherit";
                };
                reader.readAsDataURL(file); 
            }
        }
    </script>
    
    <div class="container" style="height:700px;">
        <div class="row g-2">
            <div class="col containerLeft">
        <asp:GridView ID="GVMenu" class="GVmenu" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="menuId" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="Horizontal" BackColor="Yellow" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" ShowHeaderWhenEmpty="True"  OnSelectedIndexChanged="GVMenu_SelectedIndexChanged" >
            <Columns>
                <asp:BoundField DataField="menuId" HeaderText="Id" ReadOnly="True" SortExpression="menuId" />
                <asp:BoundField DataField="menuName" HeaderText="Name" SortExpression="menuName"  ItemStyle-Width="250px" ItemStyle-HorizontalAlign="Left">
<ItemStyle HorizontalAlign="Left" Width="250px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="menuCategory" HeaderText="Category" SortExpression="menuCategory" />
                <asp:BoundField DataField="menuPrice" HeaderText="Price (RM)" SortExpression="menuPrice" />
                <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText=">>" />
            </Columns>
            <RowStyle Height="50px" BackColor="#262626" ForeColor="White" BorderColor="White" HorizontalAlign="Center"/>
            <AlternatingRowStyle BackColor="#5c5c5c" ForeColor="White" BorderColor="White" />
            <HeaderStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#f4e618" ForeColor="Black"/>
        </asp:GridView>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT [menuId], [menuName], [menuCategory], [menuPrice] FROM [Menu]"></asp:SqlDataSource>
      </div>

        <div class="col containerRight"> 
            <h3>Menu Details</h3>
            <div class="row g-2">
                <div class="col-md">
                    <asp:Image ID="menuImg" style="height:200px; width:200px; display:none; " AlternateText="No Picture Uploaded" runat="server" />
                    <asp:FileUpload ID="FoodIMageUpload" CssClass="uploadbtn" runat="server" Visible="false" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" onchange="uploadImg()"/>
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
            <div class="form-floating col-md px-3">
                <asp:TextBox ID="tbPrice" runat="server" class="form-control" placeholder="Price"  autocomplete="off" ReadOnly="true"></asp:TextBox>                            
                <label for="tbPrice">Price</label> 
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
            </div>
      </div>
</div>
</asp:Content>
