<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">    
    <div id="Cartbackground">                
        <asp:Repeater ID="cartList" runat="server" OnItemDataBound="cartList_ItemDataBound">
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
                                <h2><b><asp:Label ID="lblName" runat="server" Text=<%# Eval("menuName") %>></asp:Label></b></h2>
                                <asp:Label ID="lblPrice" runat="server" Text=<%# Eval("menuPrice","RM {0:n2}") %>></asp:Label>
                            </div>                       
                        </div>
                            
                      <div class="d-flex flex-row align-items-center col-lg-6 col-sm-12">
                          <div class="align-center m-auto" style=" width:fit-content;">
                             <div style="width: 120px;">
                              <asp:TextBox CssClass="w-50" ID="lblQty" runat="server" type="number" Text=<%# Eval("qty","{0}") %>></asp:TextBox>
                          </div>
                         </div>
                      <div style="width: 120px; text-align:center;">
                          <asp:Label ID="lblTotalPrice" runat="server" Text=<%# Eval("totalPrice","RM {0:n2}")%>></asp:Label>
                      </div>
                     <a href="#!" class="mx-3" style="color: black; width:auto;"><i class="fas fa-trash-alt"></i></a>
                   </div>
                 </div>
                </div>
             </ItemTemplate>
            </asp:Repeater>
        <asp:Button ID="btn_proceed" CssClass="btn_proceed" runat="server" Text="Proceed to Payment" OnClick="btn_proceed_Click" />
    </div>


</asp:Content>
