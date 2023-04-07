<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditMovie.aspx.cs" MasterPageFile="~/Staff.Master" Inherits="MovieTicketingSystem.Staff.EditMovie" %>

<asp:Content ID="editMovie" ContentPlaceHolderID="main" runat="server">
    <script>
        function img() {
            var url = inputToURL(document.getElementById("<%=formFile.ClientID %>"));
            document.getElementById("<%=imageView.ClientID %>").src = url;
        }
        function inputToURL(inputElement) {
            var file = inputElement.files[0];
            return window.URL.createObjectURL(file);
        }
    </script>
    
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container">
        <div class="bg-secondary bg-gradient">
            <h1 class="text-heading">Edit Existing Movie
            </h1>
            <asp:Label ID="lbMessage" runat="server" ForeColor="Red"> * Required Fields</asp:Label>
            <table class="table table-borderless table-responsive">
                <tr>
                    <td>
                        <asp:Label ID="lbMovieNo" runat="server" Text="Movie No"  CssClass="form-label"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbMovieName" runat="server" Text="Movie Name" CssClass="form-label requiredField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtMovieNo" runat="server" Enabled="false" CssClass="form-control"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMovieName" runat="server" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                        <td>
                            <asp:Label ID="lbReleaseDate" runat="server" Text="Release date" CssClass="form-label requiredField"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDuration" runat="server" Text="Duration" CssClass="form-label requiredField"></asp:Label>
                        </td>
                    </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtDate" TextMode="Date" runat="server" CssClass="form-control" ></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lbSynopsis" runat="server" Text="Synopsis" CssClass="form-label requiredField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:TextBox ID="txtSynopsis" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbGenre" runat="server" Text="Genre" CssClass="form-label requiredField"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbLanguage" runat="server" Text="Language" CssClass="form-label requiredField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlGenre" runat="server" CssClass="form-select"></asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-select"></asp:DropDownList>
                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:Label ID="lbActor" runat="server" Text="Actor" CssClass="form-label requiredField"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbDirector" runat="server" Text="Director" CssClass="form-label requiredField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtActor" runat="server" CssClass="form-control" ></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDirector" runat="server" CssClass="form-control" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbAge" runat="server" Text="Age Rating" CssClass="form-label requiredField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlAge" runat="server" CssClass="form-select"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbPostImage" AssociatedControlID="formFile" runat="server" Text="Poster Image" CssClass="form-label requiredField"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbMovieURL" runat="server" Text="Movie URL" CssClass="form-label requiredField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:FileUpload ID="formFile" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="img();" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtMovieURL" CssClass="form-control" runat="server" TextMode="Url" AutoPostBack="true" OnTextChanged="txtMovieURL_TextChanged"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="col-md-4 px-0">
                            <asp:Image ID="imageView" runat="server" CssClass="displayImage img-fluid img-rounded" />
                        </div>
                    </td>
                    <td>
                        <asp:Panel ID="pnlVideoPreview" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="gap-2 btnGroup my-2">
                            <asp:Button ID="btnView" runat="server" Text="Save" class="btn btn-success" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-warning" />
                            <asp:Button ID="btnEdit" runat="server" Text="Back" class="btn btn-danger" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
