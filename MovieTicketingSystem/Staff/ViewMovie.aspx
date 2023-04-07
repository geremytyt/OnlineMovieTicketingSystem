<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMovie.aspx.cs" MasterPageFile="~/Staff.Master" Inherits="MovieTicketingSystem.Staff.ViewMovie" %>

<asp:Content ID="viewMovie" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container">
        <h1 class="text-light">
            Details of Movie
        </h1>
        <div class="row bg-secondary bg-gradient">
            <div class="col-lg-4 col-md-5 my-3">
                <asp:Image ID="posterImage" ImageUrl="~/Image/230303_ThePope'sExorcist_big.jpg" CssClass="card-img-top imgPoster" runat="server" />
            </div>
            <div class="col-lg-8 col-md-7">
                <table class="table table-borderless table-responsive">
                    <tr>
                        <td> 
                            <asp:Label ID="lbMovieNo" runat="server" Text="Movie No" CssClass="form-label"></asp:Label> 
                        </td>
                        <td>
                            <asp:Label ID="lbMovieName" runat="server" Text="Movie Name" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtMovieNo" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMovieName" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>
                   
                    <tr>
                        <td>
                            <asp:Label ID="lbReleaseDate" runat="server" Text="Release date" CssClass="form-label"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDuration" runat="server" Text="Duration" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtDate" TextMode="Date" runat="server" CssClass="form-control" Enabled="false" ></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lbGenre" runat="server" Text="Genre" CssClass="form-label"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbLanguage" runat="server" Text="Language" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtGenre" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtLanguage" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lbActor" runat="server" Text="Actor" CssClass="form-label"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDirector" runat="server" Text="Director" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtActor" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDirector" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbAge" runat="server" Text="Age Rating" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtAge" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lbMovieURL" runat="server" Text="Movie Trailer URL" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:TextBox ID="txtMovieUrl" TextMode="Url" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lbSynopsis" runat="server" Text="Synopsis" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:TextBox ID="txtSynopsis" TextMode="MultiLine" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
                        </td>
                    </tr>
                    
                </table>
            </div>
                <div class="gap-2 btnGroup my-2" >
                    <asp:Button ID="btnView" runat="server" Text="Modify" class="btn btn-warning" />
                    <asp:Button ID="btnEdit" runat="server" Text="Back" class="btn btn-danger" />
                    
                </div>
            </div>
    </div>
</asp:Content>
