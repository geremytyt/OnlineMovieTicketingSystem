<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditMovie.aspx.cs" MasterPageFile="~/Staff.Master" Inherits="MovieTicketingSystem.Staff.EditMovie" %>

<asp:Content ID="editMovie" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <script>
        function img() {
            var url;
            var inputElement = document.getElementById("<%=posterFile.ClientID %>");
            if (inputElement.files.length > 0) {
                url = inputToURL(inputElement);
            } else {
                url = "../Image/default.jpeg";
            }
            document.getElementById("<%=imageView.ClientID %>").src = url;
        }
        function inputToURL(inputElement) {
            var file = inputElement.files[0];
            return window.URL.createObjectURL(file);
        }
    </script>
     <div class="container">
         <div class="row">
             <h1 class="text-light col-lg-4">Edit Movie Details
             </h1>
             <div class="gap-2 d-flex my-2 col-lg-8">
                 <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-default" OnClick="btnSave_Click" />
                 <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-default" OnClick="btnReset_Click" />
                 <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-default" OnClick="btnBack_Click" />
             </div>
         </div>
         <label style="color:red">* Required Field</label>
         <hr class="text-light"/>
         <div class="row">
             <div class="col-lg-4 col-md-5 my-3">
                 <asp:Image ID="imageView" runat="server" CssClass="img-rounded my-2 w-100 h-auto" ImageUrl="~/Image/default.jpeg" />
                 <asp:FileUpload ID="posterFile" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="img();" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" />
                 <asp:ScriptManager runat="server"></asp:ScriptManager>
                 <div class="my-2">
                     <asp:UpdatePanel ID="trailerContainer" runat="server">
                         <ContentTemplate>
                             <iframe id="iframeTrailer" runat="server" ></iframe>
                         </ContentTemplate>
                     </asp:UpdatePanel>
                 </div>
                 <asp:Label ID="lbMovieURL" runat="server" Text="Movie URL" CssClass="form-label requiredField text-light"></asp:Label>
                 <asp:TextBox ID="txtMovieURL" CssClass="form-control" runat="server" TextMode="Url" ></asp:TextBox>
                                  <%-- handel the iframe event --%>
                 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                 <script>
                     $(document).ready(function () {
                         $('#<%= txtMovieURL.ClientID %>').on('input', function () { // Bind the input event to the textbox
                             var url = $(this).val(); // Get the URL from the value of the textbox
                             $('#<%= iframeTrailer.ClientID %>').attr('src', url); // Set the src attribute of the iframe to the URL
                         });
                     });
                 </script>
             </div>
             <div class="col-lg-8 col-md-7">
                 <table class="table table-borderless table-responsive text-light">
                     <tr>
                         <td>
                             <asp:Label ID="lbMovieId" runat="server" Text="Movie Id" CssClass="form-label"></asp:Label>
                         </td>
                         <td>
                             <asp:Label ID="lbMovieName" runat="server" Text="Movie Name" CssClass="form-label requiredField"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <asp:TextBox ID="txtMovieId" runat="server" Enabled="false" CssClass="form-control"></asp:TextBox>
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
                             <asp:Label ID="lbDuration" runat="server" Text="Duration (minutes)" CssClass="form-label requiredField"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <asp:TextBox ID="txtDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
                         </td>
                         <td>
                             <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control"></asp:TextBox>
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
                             <asp:DropDownList ID="ddlGenre" runat="server" CssClass="form-select">
                                 <asp:ListItem Value="Action"></asp:ListItem>
                                 <asp:ListItem Value="Adventure"></asp:ListItem>
                                 <asp:ListItem Value="Comedy"></asp:ListItem>
                                 <asp:ListItem Value="Crime"></asp:ListItem>
                                 <asp:ListItem Value="Drama"></asp:ListItem>
                                 <asp:ListItem Value="Fantasy"></asp:ListItem>
                                 <asp:ListItem Value="Horror"></asp:ListItem>
                                 <asp:ListItem Value="Mystery"></asp:ListItem>
                                 <asp:ListItem Value="Sports"></asp:ListItem>
                                 <asp:ListItem Value="Romance"></asp:ListItem>
                                 <asp:ListItem Value="Animation"></asp:ListItem>
                             </asp:DropDownList>
                         </td>
                         <td>
                             <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-select">
                                 <asp:ListItem Value="ENG">English ENG</asp:ListItem>
                                 <asp:ListItem Value="CN">Chinese CN</asp:ListItem>
                                 <asp:ListItem Value="BM">Melayu BM</asp:ListItem>
                                 <asp:ListItem Value="JPN">Japan JPN</asp:ListItem>
                                 <asp:ListItem Value="HIN">Hindi</asp:ListItem>
                             </asp:DropDownList>
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
                             <asp:TextBox ID="txtActor" runat="server" CssClass="form-control"></asp:TextBox>
                         </td>
                         <td>
                             <asp:TextBox ID="txtDirector" runat="server" CssClass="form-control"></asp:TextBox>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <asp:Label ID="lbAge" runat="server" Text="Age Rating" CssClass="form-label requiredField"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <asp:DropDownList ID="ddlAge" runat="server" CssClass="form-select">
                                 <asp:ListItem>U</asp:ListItem>
                                 <asp:ListItem>P12</asp:ListItem>
                                 <asp:ListItem>P13</asp:ListItem>
                                 <asp:ListItem>P16</asp:ListItem>
                                 <asp:ListItem>P18</asp:ListItem>
                             </asp:DropDownList>
                         </td>
                     </tr>

                 </table>
             </div>
         </div>
    </div>
</asp:Content>
	
