﻿<%@ Page Title="" Language="C#" MasterPageFile="../Customer.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MovieTicketingSystem.View.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container">
        <div class="row">
            <div id="movieSlideIndicators" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#movieSlideIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#movieSlideIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#movieSlideIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    <button type="button" data-bs-target="#movieSlideIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active" data-bs-interval="1000">
                        <asp:Image ID="Slide1" ImageUrl="~/Image/slide1.jpg" runat="server" CssClass="slideImage" />
                    </div>
                    <div class="carousel-item" data-bs-interval="3000">
                        <asp:Image ID="Slide2" ImageUrl="~/Image/slide3.png" runat="server" CssClass="slideImage" />
                    </div>
                    <div class="carousel-item" data-bs-interval="3000">
                        <asp:Image ID="Slide3" ImageUrl="~/Image/slide4.jpg" runat="server" CssClass="slideImage" />
                    </div>
                    <div class="carousel-item" data-bs-interval="3000">
                        <asp:Image ID="Slide4" ImageUrl="~/Image/slide5.jpg" runat="server" CssClass="slideImage" />
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#movieSlideIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#movieSlideIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <div class="row">
            <h2 class="text-center text-lg-start fw-bold text-light col-lg-2" style="display: inline;">Showtimes</h2>
            <nav class="col-lg-10">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="nav-link active" id="now-showing-tab" data-bs-toggle="tab" data-bs-target="#now-showing" type="button" role="tab" aria-controls="now-showing" aria-selected="true">Now showing</button>
                    <button class="nav-link" id="coming-soon-tab" data-bs-toggle="tab" data-bs-target="#coming-soon" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Coming Soon</button>
                    <button class="nav-link" id="top-selling-tab" data-bs-toggle="tab" data-bs-target="#top-selling" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">Top Selling</button>
                </div>
            </nav>

            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="now-showing" role="tabpanel" aria-labelledby="now-showing-tab">
                    <%-- card Make the visibility to hiden only when hover only show --%>
                    <div class="row">
                        <asp:Repeater ID="CurrentMovieRepeater" runat="server" DataSourceID="SqlDataSource1">
                            <ItemTemplate>
                                <div class="bg-transparent card text-light text-center border-0 col-lg-3" style="width: 15rem;">
                                    <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid image-poster" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
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
                                <div class="bg-transparent card text-light text-center border-0 col-lg-3" style="width: 15rem;">
                                    <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid image-poster" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                                    <h6 class="card-title"><%# Eval("movieName") %></h6>
                                    <div class="d-grid gap-2">
                                        <button class="btn-default">
                                            <i class="fa fa-info-circle" aria-hidden="true"></i>View More
                                        </button>
                                        <button class="btn-default">
                                            <i class="fa fa-calendar-check-o" aria-hidden="true"></i>Book Now
                                        </button>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT * FROM movie WHERE releaseDate > GETDATE()"></asp:SqlDataSource>
            </div>
            <div class="tab-pane fade" id="top-selling" role="tabpanel" aria-labelledby="top-selling-tab">
                <asp:Repeater ID="topMovieRepeater" runat="server" DataSourceID="SqlDataSource3">
                    <ItemTemplate>
                        <div class="bg-transparent card text-light text-center border-0" style="width: 15rem;">
                            <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid image-poster" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                            <h6 class="card-title"><%# Eval("movieName") %></h6>
                            <div class="d-grid gap-2">
                                <button class="btn-default">
                                    <i class="fa fa-info-circle" aria-hidden="true"></i>View More
                                </button>
                                <button class="btn-default">
                                    <i class="fa fa-calendar-check-o" aria-hidden="true"></i>Book Now
                                </button>
                            </div>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT TOP (5) m.movieId, m.movieName, COUNT(*) AS ticketsSold, m.posterURL, m.trailerURL FROM Movie AS m INNER JOIN Schedule AS s ON m.movieId = s.movieId INNER JOIN Ticket AS t ON s.scheduleNo = t.scheduleNo INNER JOIN Purchase AS p ON t.purchaseNo = p.purchaseNo GROUP BY m.movieId, m.movieName, m.posterURL, m.trailerURL ORDER BY ticketsSold DESC"></asp:SqlDataSource>
            </div>
        </div>
    </div>

</asp:Content>
