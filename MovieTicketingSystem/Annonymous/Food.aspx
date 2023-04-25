<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Food.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.Food" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM [Menu]"></asp:SqlDataSource>
    <div class="container Menubackgound" >
        <div class="row" >
            <asp:Repeater ID="repMenu" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="repMenu_ItemDataBound" >
                <ItemTemplate>
                    <div class= "col-12 col-sm-6 col-md-4 col-lg-3" >
                       <div class="card" >
                        <div class="card-header bg-dark text-white">
                            <asp:Label ID="LBlId" runat="server" Text=<%#Eval("menuId") %> Visible="false"></asp:Label>
                            <asp:Label ID="LblName" runat="server" Text=<%#Eval("menuName") %>></asp:Label>
                        </div>
                        <div class="image-box" >
                            <asp:Image runat="server" id="foodImage" class="card-img-top" src='<%# Eval("menuUrl") %>' alt="Food Image" height="300"></asp:Image>
                            <div class ="textInImage"><%#Eval("menuCategory") %></div>
                        </div>
                        <div class="text-white bg-dark card-body">                
                            <asp:Label class="divPrice" ID="LblPrice" runat="server" Text=<%#Eval("menuPrice","RM {0:n2}")  %> ></asp:Label>
                            <br /><br />
                            <asp:Label ID="tbdecs" runat="server" Text='<%#Eval("menuDesc") %>'></asp:Label>
                       </div>
                       <div class="card-footer row">
                           <div>
                                Quantity
                                <asp:TextBox ID="txtQty" CssClass="Qty" runat="server" TextMode="Number" ></asp:TextBox>
                               </div>
                           <asp:RequiredFieldValidator ID="RFVQty" runat="server" ErrorMessage="Please Enter the Quantity" ControlToValidate="txtQty" ></asp:RequiredFieldValidator>
                           <asp:Button ID="btn_add_to_cart" CssClass="btn_add_to_cart" runat="server" Text="Add to Cart >>" OnClick='btn_addToCart_Click'/>
                      </div>
                     </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
