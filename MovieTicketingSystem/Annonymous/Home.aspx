<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="Home.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
    <div class="container">
        <div class="row">
            <div id="movieSlideIndicators" class="carousel slide carousel-fade" data-bs-ride="carousel">
                <div class="carousel-inner" >
                    <asp:Repeater ID="slideItem" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                        <div class="carousel-item <%# (Container.ItemIndex == 0 ? "active" : "") %>" data-bs-interval="3000">
                            <div class="card text-white">
                                <asp:Image ImageUrl='<%# ResolveUrl((string)Eval("slideURL")) %>' runat="server" CssClass="slideImage" />
                                <div class="card-img-overlay d-grid col-2 align-items-end" style="margin:0px 0px 30px 130px;">
                                    <asp:Button ID="btnBookNow" runat="server" Text="BUY NOW" CssClass="btn btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnBookNow_Command" /> </td>
                                </div>
                            </div>
                        </div>                            
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#movieSlideIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon bg-dark m-2" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#movieSlideIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon bg-dark m-2" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <div class="row">
            <h2 class="text-center text-lg-start fw-bold text-light col-lg-2" style="display: inline;">Showtimes</h2>
            <nav class="col-lg-10">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="nav-link active" id="now-showing-tab" data-bs-toggle="tab" data-bs-target="#now-showing" type="button" role="tab" aria-controls="now-showing" aria-selected="true">Now showing</button>
                    <button class="nav-link" id="coming-soon-tab" data-bs-toggle="tab" data-bs-target="#coming-soon" type="button" role="tab" aria-controls="coming-soon" aria-selected="false">Coming Soon</button>
                    <button class="nav-link" id="top-selling-tab" data-bs-toggle="tab" data-bs-target="#top-selling" type="button" role="tab" aria-controls="top-selling" aria-selected="false">Top Selling</button>
                </div>
            </nav>

            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="now-showing" role="tabpanel" aria-labelledby="now-showing-tab">
                    <div class="swiper currentSwiper" style="width:100%; margin:20px auto;">
                        <div class="swiper-wrapper">
                            <asp:Repeater ID="CurrentMovieRepeater" runat="server" DataSourceID="SqlDataSource1">
                                <ItemTemplate>
                                    <div class="swiper-slide d-flex">
                                        <div class="bg-transparent card text-light text-center border-0" style="width: 15rem;">
                                            <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid image-poster" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                                            <h6 class="card-title"><%# Eval("movieName") %></h6>
                                            <div class="d-grid gap-2">
                                                <asp:Button ID="btnViewMore" runat="server" Text="View More" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnViewMore_Command" />
                                                <asp:Button ID="btnBookNow" runat="server" Text="Book Now" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnBookNow_Command" />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

                    <!-- Initialize Swiper -->
                    <script>
                        var swiper = new Swiper(".currentSwiper", {
                            slidesPerView: 4,
                            spaceBetween: 30,
                            pagination: {
                                el: ".swiper-pagination",
                                type: "fraction",
                            },
                            navigation: {
                                nextEl: ".swiper-button-next",
                                prevEl: ".swiper-button-prev",
                            },
                        });
                    </script>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM Movie WHERE (releaseDate <= GETDATE() AND endDate > GETDATE())"></asp:SqlDataSource>
                </div>
                <div class="tab-pane fade" id="coming-soon" role="tabpanel" aria-labelledby="comming-soon-tab">
                    <div class="swiper currentSwiper" style="width:100%; margin:20px auto;">
                        <div class="swiper-wrapper">
                            <asp:Repeater ID="comingSoonRepeater" runat="server" DataSourceID="SqlDataSource2">
                                <ItemTemplate>
                                    <div class="swiper-slide d-flex">
                                        <div class="bg-transparent card text-light text-center border-0" style="width: 15rem;">
                                            <asp:Image ID="Image1" CssClass="card-img-top image-fluid image-poster" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                                            <h6 class="card-title"><%# Eval("movieName") %></h6>
                                            <div class="d-grid gap-2">
                                                <asp:Button ID="btnViewMore" runat="server" Text="View More" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnViewMore_Command" />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

                    <!-- Initialize Swiper -->
                    <script>
                        var swiper = new Swiper(".currentSwiper", {
                            slidesPerView: 4,
                            spaceBetween: 30,
                            pagination: {
                                el: ".swiper-pagination",
                                type: "fraction",
                            },
                            navigation: {
                                nextEl: ".swiper-button-next",
                                prevEl: ".swiper-button-prev",
                            },
                        });
                    </script>
                </div>

                <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT * FROM movie WHERE releaseDate > GETDATE()"></asp:SqlDataSource>
                
                <div class="tab-pane fade" id="top-selling" role="tabpanel" aria-labelledby="top-selling-tab">
                    <div class="swiper currentSwiper" style="width:100%; margin:20px auto;">
                        <div class="swiper-wrapper m-3">
                            <asp:Repeater ID="topSwiper" runat="server" DataSourceID="SqlDataSource3">
                                <ItemTemplate>
                                    <div class="swiper-slide d-flex">
                                        <div class="bg-transparent card text-light text-center border-0" style="width: 15rem;">
                                            <asp:Image ID="Image2" CssClass="card-img-top image-fluid image-poster" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                                            <h6 class="card-title"><%# Eval("movieName") %></h6>
                                            <div class="d-grid gap-2">
                                                <asp:Button ID="btnViewMore" runat="server" Text="View More" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnViewMore_Command" />
                                                <asp:Button ID="btnBookNow" runat="server" Text="Book Now" CssClass="btn-default" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnBookNow_Command" />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

                    <!-- Initialize Swiper -->
                    <script>
                        var swiper = new Swiper(".currentSwiper", {
                            slidesPerView: 4,
                            spaceBetween: 30,
                            pagination: {
                                el: ".swiper-pagination",
                                type: "fraction",
                            },
                            navigation: {
                                nextEl: ".swiper-button-next",
                                prevEl: ".swiper-button-prev",
                            },
                        });
                    </script>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT TOP (5) m.movieId, m.movieName, COUNT(*) AS ticketsSold, m.posterURL, m.trailerURL FROM Movie AS m INNER JOIN Schedule AS s ON m.movieId = s.movieId INNER JOIN Ticket AS t ON s.scheduleNo = t.scheduleNo INNER JOIN Purchase AS p ON t.purchaseNo = p.purchaseNo WHERE (m.endDate > GETDATE()) GROUP BY m.movieId, m.movieName, m.posterURL, m.trailerURL ORDER BY ticketsSold DESC"></asp:SqlDataSource>
                </div>
            </div>
            
        </div>
    </div>

</asp:Content>
