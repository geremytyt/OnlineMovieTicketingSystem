<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffMovie.aspx.cs" Inherits="MovieTicketingSystem.View.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    
    <link href="../css/movie.css" rel="stylesheet" />
    <%--Gonna change to grid view when having database--%>
        <div class="container">
            <asp:Button ID="btnAddMovie" runat="server" Text="Add Movie" class="btn btn-warning float-end my-1"/>
            <div class="input-group">
            <asp:TextBox ID="txtSearch" runat="server" class="form-control my-2" placeholder="Search"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-success my-2"/>            
            </div>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="movieNo" DataSourceID="SqlDataSource1" class="table table-striped bg-light my-3 table-bordered table-responsive table-hover">
                <Columns>
                    <asp:BoundField DataField="movieNo" HeaderText="Movie No." ReadOnly="True" SortExpression="movieNo" />
                    <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                    <asp:BoundField DataField="releaseDate" HeaderText="Release Date" SortExpression="releaseDate" DataFormatString="{0:MM/dd/yy}" />
                    <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
                    <asp:BoundField DataField="synopsis" HeaderText="Synopsis" SortExpression="synopsis" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <div class="d-grid gap-2 d-md-flex">
                                <asp:Button ID="btnView" runat="server" Text="View" CommandName="View" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-success" />
                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-warning" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-danger"/>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            &nbsp;&nbsp;&nbsp;
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM [Movie]"></asp:SqlDataSource>
        </div>
</asp:Content>
