<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Food.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.Food" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM [Menu] Where available = 'true'"></asp:SqlDataSource>
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
                            <div class ="textInImage"><%#Eval("menuCategory") %>
                            <asp:Label ID="lblUrl" runat="server" Text='<%# Eval("menuUrl") %>' Visible="false" ></asp:Label>  
                                </div>
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
                               <asp:RequiredFieldValidator ID="RFVQty" runat="server" ErrorMessage="Please Enter the Quantity" ControlToValidate="txtQty" ForeColor="Red" >*</asp:RequiredFieldValidator>
                           <asp:RangeValidator ID="RVQty" runat="server" ErrorMessage="Only Values 1 to 10 are accepted" ControlToValidate="txtQty" MaximumValue="10"  MinimumValue="1" Type="Integer" ForeColor="Red" >*</asp:RangeValidator>         
                           <asp:ValidationSummary ID="VS1" runat="server" ForeColor="Red" />
                               </div>
                           <asp:Button ID="btn_add_to_cart" CssClass="btn_add_to_cart" runat="server" Text="Add to Cart >>" OnClick='btn_addToCart_Click'/>
                      </div>
                     </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
