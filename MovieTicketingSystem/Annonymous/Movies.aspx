<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="Movies.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.Movies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container">
        <div class="row">
            <h2 class="text-center text-lg-start fw-bold text-light col-lg-2" style="display: inline;">Movies</h2>
            <nav class="col-lg-10">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="loginTab nav-link active" id="now-showing-tab" data-bs-toggle="tab" data-bs-target="#now-showing" type="button" role="tab" aria-controls="now-showing" aria-selected="true">Now showing</button>
                    <button class="loginTab nav-link" id="coming-soon-tab" data-bs-toggle="tab" data-bs-target="#coming-soon" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Coming Soon</button>
                </div>
            </nav>

            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="now-showing" role="tabpanel" aria-labelledby="now-showing-tab">
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
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM Movie WHERE (releaseDate &lt;= GETDATE())"></asp:SqlDataSource>
                </div>
                <div class="tab-pane fade" id="coming-soon" role="tabpanel" aria-labelledby="comming-soon-tab">
                    <div class="row">
                        <asp:Repeater ID="CommingSoonRepeater" runat="server" DataSourceID="SqlDataSource2">
                            <ItemTemplate>
                                <div class="bg-transparent card text-light text-center border-0 col-lg-4 col-xl-3 my-2">
                                    <asp:Image ID="Image1" CssClass="card-img-top image-fluid image-poster h-auto" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                                    <h6 class="card-title"><%# Eval("movieName") %></h6>
                                    <div class="d-grid gap-2">
                                        <asp:Button ID="Button1" runat="server" Text="View More" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnViewMore_Command" />
                                        <asp:Button ID="Button2" runat="server" Text="Book Now" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnBookNow_Command" />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT * FROM movie WHERE releaseDate > GETDATE()"></asp:SqlDataSource>

            </div>

        </div>
    </div>
</asp:Content>
