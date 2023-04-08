<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="MovieTicketingSystem.User.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
<link href="../css/MenuStyle.css" rel="stylesheet" />
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
      <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"/>
      <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"/>
    </svg>
    
    <div id="Cartbackground">                
        <asp:Repeater ID="cartList" runat="server" OnItemDataBound="cartList_ItemDataBound">
            <HeaderTemplate>
                <div class="row">
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
        <asp:Button ID="btn_proceed" CssClass="btn_proceed" runat="server" Text="Proceed to Payment" />
    </div>


</asp:Content>
