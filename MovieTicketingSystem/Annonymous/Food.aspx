<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Food.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.Food" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM [Menu]"></asp:SqlDataSource>
    <div class="container Menubackgound" >
        <div class="row" >
            <asp:Repeater ID="repMenu" runat="server" DataSourceID="SqlDataSource1" >
                <ItemTemplate>
                    <div class= "col-12 col-sm-6 col-md-4 col-lg-3" >
                       <div class="card" >
                        <div class="card-header bg-dark text-white">
                            <asp:Label ID="LblName" runat="server" Text=<%#Eval("MenuName") %>></asp:Label>
                        </div>
                        <div class="image-box">
                            <img class="card-img-top" src='<%# Eval("menuUrl") %>' alt="Food Image" >
                            <div class ="textInImage"><%#Eval("menuCategory") %></div>
                        </div>
                        <div class="card-body text-white bg-dark    ">                
                            <asp:Label class="divPrice" ID="LblPrice" runat="server" Text=<%#Eval("menuPrice","RM {0:n2}")  %> ></asp:Label>
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
