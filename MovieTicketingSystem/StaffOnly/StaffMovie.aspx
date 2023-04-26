<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="StaffMovie.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.StaffMovie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>

    <link href="../css/movie.css" rel="stylesheet" />
    <script type="text/javascript">
        $(function () {
            $("[id*=MovieGridView]").DataTable(
                {
                    bLengthChange: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true
                });
        });
    </script>
        <div class="container">
            <div class="d-grid gap-2 d-md-flex justify-content-md-end my-2">
                <asp:Button ID="btnAddMovie" runat="server" Text="Add Movie" class="btn btn-default float-end my-1" OnClick="btnAddMovie_Click" />
            </div>

            <div class="text-white row">
                <asp:GridView ID="MovieGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="movieId" ClientIDMode="Static" CssClass="table w-100 table-dark table-striped my-1 table-bordered table-responsive table-hover">
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
                                    <asp:Button ID="btnView" runat="server" Text="View" CommandName="View" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default" OnCommand="btns_Command" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default" OnCommand="btns_Command" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            &nbsp;&nbsp;&nbsp;
           
        </div>
</asp:Content>