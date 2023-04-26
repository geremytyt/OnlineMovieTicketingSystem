<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="MovieSearch.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.MovieSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container">
        <h2 class="text-center text-lg-start fw-bold text-light col-lg-2" style="display: inline;">Search Result</h2>
        <div class="row">
            <asp:Repeater ID="CurrentMovieRepeater" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="bg-transparent card text-light text-center border-0 col-lg-4 col-xl-3 my-2">
                        <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid image-poster h-auto" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                        <h6 class="card-title"><%# Eval("movieName") %></h6>
                        <div class="d-grid gap-2">
                            <asp:Button ID="btnViewMore" runat="server" Text="View More" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnViewMore_Command" />
                            <asp:Button ID="btnBookNow" runat="server" Text="Book Now" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnBookNow_Command" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT * FROM Movie WHERE (movieName LIKE @name + '%')">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="movieName" Name="name"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
</asp:Content>
