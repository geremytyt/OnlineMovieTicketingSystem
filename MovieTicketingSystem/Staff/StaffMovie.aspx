<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffMovie.aspx.cs" Inherits="MovieTicketingSystem.Staff.StaffMovie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <%--Gonna change to grid view when having database--%>
        <div class="container">
            <asp:Button ID="btnAddMovie" runat="server" Text="Add Movie" class="btn btn-default float-end my-1" OnClick="btnAddMovie_Click"/>
            <div class="input-group">
            <asp:TextBox ID="txtSearch" runat="server" TextMode="Search" class="form-control my-2" placeholder="Search"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-default my-2"/>            
            </div>
            <asp:GridView ID="MovieGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="movieId" DataSourceID="SqlDataSource1" CssClass="table table-dark table-striped my-1 table-bordered table-responsive table-hover">
                <Columns>
                    <asp:BoundField DataField="movieId" HeaderText="Movie Id" ReadOnly="True" SortExpression="movieId" />
                    <asp:BoundField DataField="movieName" HeaderText="Movie Name" SortExpression="movieName" />
                    <asp:BoundField DataField="releaseDate" HeaderText="Release Date" SortExpression="releaseDate" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
                    <asp:BoundField DataField="language" HeaderText="Language" SortExpression="language" />
                    <asp:BoundField DataField="synopsis" HeaderText="Synopsis" SortExpression="synopsis" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <div class="d-grid gap-2 d-md-flex">
                                <asp:Button ID="btnView" runat="server" Text="View" CommandName="View" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default" OnCommand="btns_Command"/>
                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default" OnCommand="btns_Command"/>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            &nbsp;&nbsp;&nbsp;
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM [Movie]"></asp:SqlDataSource>
        </div>
</asp:Content>
