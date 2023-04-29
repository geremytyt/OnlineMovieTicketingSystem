<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">    
    <script>
        function confirmDeleteDialog() {
            if (confirm("Do you want to continue? Click 'YES'") == true) {
                return true
            }
            else {
                return false
            }
        }

        function reset() {

        }
    </script>
    
    <div id="Cartbackground">         
        <div id="NoRecords" class="NoRecordField" runat="server" visible="false">
                No records are available.
        </div>
        <asp:Repeater ID="cartList" runat="server" OnItemDataBound="cartList_ItemDataBound" OnPreRender="cartList_PreRender" >
            <HeaderTemplate>
                <div class="row" >
                    <h1>Cart</h1>
                </div>
            </HeaderTemplate>
            <ItemTemplate>
                <div class="card-body ps-0 cartItem rounded-2 p-2">
                    <div class="d-flex justify-content-between row">
                        <div class="d-flex flex-row align-items-center col-lg-6 col-sm-12 p-3">
                            <!--Image-->
                            <div>
                                <asp:Image runat="server"  src='<%# Eval("menuUrl") %>' 
                                style="width:150px; height:150px;" CssClass="my-auto rounded-2 cart-image-box" ></asp:Image>
                            </div>

                            <!--Menu Detail-->
                            <div class="ms-3 text-start m-auto">
                                 <asp:Label ID="LBlId" runat="server" Text=<%#Eval("menuId") %> Visible="false"></asp:Label>
                                <h2><b><asp:Label ID="lblName" runat="server" Text=<%# Eval("menuName") %>></asp:Label></b></h2>
                                <asp:Label ID="lblPrice" runat="server" Text=<%# Eval("menuPrice","RM {0:n2}") %>></asp:Label>
                            </div>                       
                        </div>
                            
                      <div class="d-flex flex-row align-items-center col-lg-6 col-sm-12">
                          <div class="align-center m-auto" style=" width:fit-content;">
                             <div style="width: 100%; margin:auto; padding:10px;">
                              <asp:TextBox CssClass="w-50 m-auto" ID="lblQty" runat="server" type="number" ReadOnly="true" Text=<%# Eval("qty","{0}") %>></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RFVQty" runat="server" ErrorMessage="Please Enter the Quantity" ControlToValidate="lblQty" ForeColor="Red" >*</asp:RequiredFieldValidator>
                             <asp:RangeValidator ID="RVQty" runat="server" ErrorMessage="Only Values 1 to 10 are accepted" ControlToValidate="lblQty" MaximumValue="10"  MinimumValue="1" Type="Integer" ForeColor="Red" >*</asp:RangeValidator>         
                             </div>
                         </div>
                      <div style="width: 120px; text-align:center;">
                          <asp:Label ID="lblTotalPrice" runat="server" Text=<%# Eval("totalPrice","RM {0:n2}")%>></asp:Label>
                      </div>
                          <asp:Button ID="btnEdit" runat="server" CssClass="cartbtn mx-3" OnClick="btnEdit_Click" Text="Edit" />
                            <%--<i class="fa fa-edit"></i>--%>
                          
                          <asp:Button ID="btnDetele" runat="server" OnClientClick="return confirmDeleteDialog()" OnClick="btnDetele_Click"  Text="Delete" CssClass="cartbtn mx-3"/>
                          <%--      <i class="fas fa-trash-alt" ></i>--%>

                          <asp:Button ID="btnConfirm" runat="server" OnClick="btnConfirm_Click" Visible="false" Text="Confirm" CssClass="cartbtn mx-3"/>
                           <%-- <i class="fa fa-check"></i>--%>                           
                          
                          <asp:Button ID="btnCancel" runat="server" OnClientClick="this.form.reset()" OnClick="btnCancel_Click" Visible="false" Text="Cancel" CssClass="cartbtn mx-3 "/>
                                <%--<i class="fa fa-close"></i>--%>
                      </div>
                 </div>
                        <asp:ValidationSummary ID="VS1" runat="server" ForeColor="Red" />
                </div>
             </ItemTemplate>
            </asp:Repeater>

        <div class="row align-items-center justify-content m-auto">
            <asp:Button ID="btn_back" CssClass="btnforcart" runat="server" Text="Conutinue Shopping" OnClick="btn_back_Click" />
            <asp:Button ID="btn_proceed" CssClass="btnforcart" runat="server" Text="Proceed to Payment" OnClick="btn_proceed_Click" />
        </div>
    </div>


</asp:Content>
