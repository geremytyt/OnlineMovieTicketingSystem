<%@ Page Language="C#" AutoEventWireup="true" Title="View Movie" CodeBehind="ViewMovie.aspx.cs" MasterPageFile="~/Staff.Master" Inherits="MovieTicketingSystem.Staff.ViewMovie" %>

<asp:Content ID="viewMovie" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container">
        <div class="row">
            <h1 class="text-light col-lg-4">Movie Details
            </h1>
            <div class="gap-2 d-flex my-2 col-lg-8">
                <asp:Button ID="btnModify" runat="server" Text="Modify" class="btn btn-default" OnClick="btnModify_Click" />
                <asp:Button ID="btnEdit" runat="server" Text="Back" class="btn btn-default" OnClick="btnEdit_Click" />
            </div>
        </div>
        <hr style="width:100%; border-color:white;"/>
        <div class="row">
            <div class="col-lg-4 col-md-5 my-3">
                <asp:Image ID="posterImage" CssClass="card-img-top imgPoster" runat="server" />
            </div>
            <div class="col-lg-8 col-md-7">
                <table class="table table-borderless table-responsive text-light">
                    <tr>
                        <td> 
                            <asp:Label ID="lbMovieId" runat="server" Text="Movie ID" CssClass="form-label"></asp:Label> 
                        </td>
                        <td>
                            <asp:Label ID="lbMovieName" runat="server" Text="Movie Name" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtMovieId" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
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
                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" Enabled="false" ></asp:TextBox>
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
                            <asp:Label ID="lbAge" runat="server" Text="Classification" CssClass="form-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtAge" runat="server" CssClass="form-control" Enabled="false" Text="test"></asp:TextBox>
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
                    <tr>
                        <td colspan="2">
                            <div class="row">
                                <div class="col-lg-6">
                                    <asp:Label ID="lbMovieURL" runat="server" Text="Movie Trailer URL" CssClass="form-label"></asp:Label>
                                    <asp:TextBox ID="txtMovieURL" CssClass="form-control" runat="server" TextMode="Url" Enabled="false"></asp:TextBox>
                                </div>
                                <div class="col-lg-6">
                                    <asp:Panel ID="pnlVideoPreview" runat="server" />
                                </div>
                            </div>
                            
                        </td>
                    </tr>
                                        
                </table>
            </div>
            </div>
    </div>
</asp:Content>
