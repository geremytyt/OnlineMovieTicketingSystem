<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="MovieDetails.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.MovieDetails" %>

<asp:Content ID="movieDetails" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container text-light">
        <div class="row">
            <%-- Poster image --%>
            <div class="col-lg-4 col-md-6 contain-poster">
                <asp:Image ID="imgMoviePoster" CssClass="my-2 image-fluid rounded float-end" runat="server"/>
            </div>
            <div class="col-lg-8 col-md-6">
                <asp:Label ID="lbMovieName" runat="server" CssClass="fw-bold mb-0 fs-2" >Testing</asp:Label>
                <table class="table table-borderless text-light">
                    <tr>
                        <td>
                                <label>Release Date :  </label>
                                <asp:Label ID="lbReleaseDate" runat="server"/>
                        </td>
                        <td>
                                <label>Language :  </label>
                                <asp:Label ID="lbLanguage" runat="server"/>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                                <label>Duration :  </label>
                                <asp:Label ID="lbDuration" runat="server"/>
                        </td>
                        <td>
                                <label>Genre :  </label>
                                <asp:Label ID="lbGenre" runat="server"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                                <label>Clasification :  </label>
                                <asp:Label ID="lbClassification" runat="server"/>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                                <label class="fw-bold">Director :</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                                <asp:Label ID="lbDirector" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                                <label class="fw-bold">Actor :</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            
                            <asp:Label ID="lbActor" runat="server" />
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4">
                                <label class="fw-bold">Synopsis: </label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                                <asp:Label ID="lbSynopsis" runat="server" /></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                                <label class="fw-bold">Movie Trailer: </label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:Panel ID="pnlVideoPreview" runat="server" />
                        </td>
                    </tr>
                </table>
                <asp:Button ID="btnBuy" runat="server" Text="Buy Now" CssClass="btn btn-default m-2 px-4" OnCommand="btbBuy_Command"/>
            </div>
        </div>

    </div>
</asp:Content>