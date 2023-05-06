<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="MoviePurchase.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.MoviePurchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            .swiper-slide {
                background-position: center;
                background-size: cover;
                width: -webkit-fit-content;
                height: auto;
            }

            .textLabel{
                color:yellow;
            }
            
            .form-control:disabled{
                background-color:transparent;
            }
        </style>
        <div class="bg-dark bg-gradient my-2  text-light">
            
            <div class="text-light movieSelect" >
                <div class="swiper movieSwiper" id="swapper">
                    <div class="swiper-wrapper">
                        <asp:Repeater ID="CurrentMovieRepeater" runat="server" DataSourceID="SqlDataSource1">
                            <ItemTemplate>
                                <div class="swiper-slide">
                                    <div class="bg-transparent card text-light text-center border-0 shadow" style="width: 15rem;">
                                        <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid image-poster" ImageUrl='<%# ResolveUrl((string)Eval("posterURL")) %>' runat="server" ImageAlign="Middle" />
                                        <h6 class="card-title"><%# Eval("movieName") %></h6>
                                        <asp:Button ID="btnSelect" runat="server" Text="Select" CssClass="btn btn-default button-select" CommandArgument='<%# Eval("movieId") %>' OnCommand="btnSelect_Command"/>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
                    <!-- Initialize Swiper -->
                    <script>
                        function getCookie(cname) {
                            let name = cname + "=";
                            let decodedCookie = decodeURIComponent(document.cookie);
                            let ca = decodedCookie.split(';');
                            for (let i = 0; i < ca.length; i++) {
                                let c = ca[i];
                                while (c.charAt(0) == ' ') {
                                    c = c.substring(1);
                                }
                                if (c.indexOf(name) == 0) {
                                    return c.substring(name.length, c.length);
                                }
                            }
                            return "";
                        }
                        var cookieValue = getCookie("Slide");
                        var swiper = new Swiper(".movieSwiper", {
                            effect: "coverflow",
                            grabCursor: true,
                            centeredSlides: true,
                            slidesPerView: "auto",
                            coverflowEffect: {
                                rotate: 30,
                                stretch: 0,
                                depth: 100,
                                modifier: 1,
                                slideShadows: true,
                            },
                            pagination: {
                                el: ".swiper-pagination",
                            },
                        });
                        var slideIndex = parseInt(cookieValue);
                        swiper.slideTo(slideIndex-1);
                    </script>
                    </div>
                </div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT * FROM Movie WHERE (releaseDate &lt;= GETDATE() AND endDate > GETDATE())"></asp:SqlDataSource>
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table class="table table-borderless d-flex">
                        <tr>
                            <td>
                                <label class="form-label textLabel p-1">Movie Selected : </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMovie" runat="server" Enabled="false" CssClass="form-control w-auto text-light txtMovieSelect"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                                <label class="form-label textLabel p-1">Select Date :  </label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDate" runat="server" CssClass="text-light px-3 py-1" BackColor="Black" DataSourceID="SqlDataSource2" DataTextField="scheduleDateTime" DataValueField="scheduleDateTime" DataTextFormatString="{0:dd/MM/yyyy}" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label class="form-label textLabel p-1">Select Time :  </label>
                            </td>
                            
                            <td>
                                <asp:DropDownList ID="ddlTime" runat="server" CssClass="text-light px-3 py-1" BackColor="Black" DataSourceID="SqlDataSource3" DataTextField="scheduleDateTime" DataValueField="scheduleNo" DataTextFormatString="{0:hh:mm tt}"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn btn-default m-2" OnClick="btnNext_Click"/>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT DISTINCT CAST(scheduleDateTime AS DATE) AS scheduleDateTime FROM Schedule WHERE (movieId = @Id) AND (status = 'Active') GROUP BY CAST(scheduleDateTime AS DATE), scheduleNo">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="movieId" Name="Id"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT * FROM Schedule WHERE CAST([scheduleDateTime] AS DATE) = CAST(@date AS DATE) AND (movieId = @Id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlDate" PropertyName="SelectedValue" Name="date"></asp:ControlParameter>
                    <asp:QueryStringParameter QueryStringField="movieId" Name="Id"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        
    </div>
</asp:Content>
