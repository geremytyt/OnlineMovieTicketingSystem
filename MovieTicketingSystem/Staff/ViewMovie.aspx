<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMovie.aspx.cs" MasterPageFile="~/Staff.Master" Inherits="MovieTicketingSystem.Staff.ViewMovie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container">
        <h1 class="text-light">
            Details of Movie
        </h1>
        <div class="row bg-secondary bg-gradient">
            <div class="col-lg-4 col-md-5">
                <asp:Image ID="Image1" runat="server" />
                <br />
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="col-lg-8 col-md-7">
                <table class="table table-borderless table-responsive">
                    <tr>
                        <td> 
                            <asp:Label ID="Label2" runat="server" Text="Label" CssClass="form-label"></asp:Label> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>
                                        <tr>
                        <td> 
                            <asp:Label ID="Label3" runat="server" Text="Label" CssClass="form-label"></asp:Label> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>
                                        <tr>
                        <td> 
                            <asp:Label ID="Label4" runat="server" Text="Label" CssClass="form-label"></asp:Label> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
