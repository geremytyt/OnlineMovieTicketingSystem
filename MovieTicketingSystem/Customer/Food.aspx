<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Food.aspx.cs" Inherits="MovieTicketingSystem.User.Food" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Menu]"></asp:SqlDataSource>
    <link href="../css/MenuStyle.css" rel="stylesheet" />
    <link rel=”stylesheet” href=”https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css”/>


    <div class="container Menubackgound" >
        <div class="row" >
            <asp:Repeater ID="repMenu" runat="server" DataSourceID="SqlDataSource1" >
                <ItemTemplate>
                    <div class= "col-12 col-sm-6 col-md-4 col-lg-3" >
                       <div class="card" >
                        <div class="card-header">
                            <asp:Label ID="LblName" runat="server" Text=<%#Eval("MenuName") %>></asp:Label>
                        </div>
                        <div class="image-box">
                            <img class="card-img-top" src='<%# Eval("menuUrl") %>' alt="Food Image" >
                            <div class ="textInImage"><%#Eval("menuCategory") %></div>
                        </div>
                        <div class="card-body">                
                            <asp:Label class="divPrice" ID="LblPrice" runat="server" Text=<%#Eval("menuPrice","RM {0:n2}")  %>></asp:Label>
                            <br /><br />
                            <asp:Label ID="tbdecs" runat="server" Text='<%#Eval("menuDesc") %>'></asp:Label>
                       </div>
                       <div class="card-footer">
                           <asp:TextBox ID="txtQty" CssClass="Qty" runat="server" TextMode="Number" ></asp:TextBox>
                           <asp:Button ID="btn_add_to_cart" CssClass="btn_add_to_cart" runat="server" Text="Add to Cart >>" OnClick='btn_addToCart_Click'/>
                      </div>
                     </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
