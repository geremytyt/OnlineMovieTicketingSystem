<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="AvailableFoodManagement.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.AvailableFoodManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>
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
                <asp:Button ID="btnAvailable" runat="server" Text="Available" CssClass="nav-link active w-50 text-black mb-2 border-0" BackColor="#F4E618"/>
                <asp:Button ID="btnUnAvailable" runat="server" Text="Unavailable" CssClass="nav-link w-50 text-white mb-2" BorderColor="White" OnClick="btnUnAvailable_Click" />
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

              
        <div class="col containerRight  "> 
            
            <div class ="detailsView bg-dark rounded-4 text-white mb-2 border-0">
                <h3 class="bg-dark rounded-4 text-white mb-2 border-0 text-center mt-2">Menu Details</h3>
            <div class="row g-2">
                <div class="col-md ">
                    <asp:Image ID="menuImg" style="height:200px; width:200px; display:none; " AlternateText="No Picture Uploaded" runat="server" />
                    <asp:FileUpload ID="FoodIMageUpload" CssClass="uploadbtn" runat="server" Visible="false" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" onchange="uploadImg()"/> <br />
                    <asp:RequiredFieldValidator ID="RVUpload" ForeColor="Red" ControlToValidate="FoodIMageUpload" runat="server" ErrorMessage="Please Upload An Image" Enabled="false" ></asp:RequiredFieldValidator>
                </div>
                <div class="form-floating m-auto col-md px-3">
                    <asp:Label id="lblMenuId" runat="server" class="form-control">Select An Item</asp:Label>        
                    <label for="lblMenuId">Menu Id</label>        
                </div>
            </div>
            <div class="form-floating mx-auto mb-1 w-100 px-3">
                <asp:TextBox ID="tbName" runat="server" class="form-control" placeholder="Name" ReadOnly="true"  ></asp:TextBox>                            
                <label for="tbName" >Name</label> 
                    <asp:RequiredFieldValidator ID="RVtbName" ForeColor="Red" ControlToValidate="tbName" runat="server" ErrorMessage="Please Enter the Price" Enabled="false" ></asp:RequiredFieldValidator>                    
            </div>
            <div class="form-floating mx-auto mb-1 w-100 px-3">
                <asp:DropDownList ID="DDLCategory" Cssclass="form-control  text-white" Enabled="false" runat="server">
                    <asp:ListItem style="background-color:black;">Snack</asp:ListItem>
                    <asp:ListItem style="background-color:black;">Bevarage</asp:ListItem>
                    <asp:ListItem style="background-color:black;">Combo</asp:ListItem>
                </asp:DropDownList>
                <label for="tbCategory text-white">Category</label> 
            </div>
            <div class="form-floating col-md px-3">
                <asp:TextBox ID="tbPrice" runat="server" class="form-control" placeholder="Price" TextMode="Number"  autocomplete="off" ReadOnly="true"></asp:TextBox>                            
                <label for="tbPrice">Price (RM)</label> 
                <asp:CompareValidator ID="CVPrice" runat="server" ControlToValidate="tbPrice" Operator="LessThanEqual" Type="Integer" ValueToCompare="0" Enabled="false" ErrorMessage="CompareValidator"></asp:CompareValidator>
                 <asp:RequiredFieldValidator ID="RVPrice" ForeColor="Red" ControlToValidate="tbPrice" runat="server" ErrorMessage="Please Enter the Price" Enabled="false" ></asp:RequiredFieldValidator>                    
            </div>
            <div class="form-floating mx-auto mb-3 px-3 w-100">
                <asp:TextBox ID="tbDecs" runat="server" class="form-control" placeholder="Description" autocomplete="off" ReadOnly="true" TextMode="MultiLine" ></asp:TextBox>                            
                <label for="tbDecs" >Description</label> 
                    <asp:RequiredFieldValidator ID="RVtbDecs" ForeColor="Red" ControlToValidate="tbDecs" runat="server" ErrorMessage="Please Enter the Price" Enabled="false" ></asp:RequiredFieldValidator>                    
            </div>
            <div class="actionBar">
                <asp:Button ID="btn_add" class="actionButton" runat="server" Text="Add" OnClick="btn_add_Click"  Visible="false"/>
                <asp:Button ID="btn_back" runat="server" Text="Back" OnClientClick="this.reset()" OnClick="btn_back_Click" class="actionButton" Visible="false"/>
                <asp:Button ID="btn_update" runat="server" Text="Update" OnClick="btn_update_Click" class="actionButton" Visible="false" />
                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" OnClientClick="this.reset()"  OnClick="btn_cancel_Click" class="actionButton" Visible="false" />
                <asp:Button ID="btn_insert" runat="server" Text="Insert" OnClick="btn_insert_Click" class="actionButton" />
                <asp:Button ID="btn_edit" runat="server" Text="Edit" OnClick="btn_edit_Click" class="actionButton" Visible="false"  />
                <asp:Button ID="btn_Discontinue" runat="server" Text="Discontinue" OnClick="btn_Discontinue_Click" class="actionButton" Visible="false" />
            </div> 
            </div>            
            </div>
      </div>
</div>

</asp:Content>
