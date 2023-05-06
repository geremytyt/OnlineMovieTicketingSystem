<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Staff.Master" CodeBehind="AddMovie.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.AddMovie" %>

<asp:Content ID="addMovie" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <div class="container">
         <div class="row">
             <h1 class="text-light col-lg-4">Add New Movie
             </h1>
             <div class="gap-2 d-flex my-2 col-lg-8">
                 <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-default" OnClick="btnSave_Click"  />
                 <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-default" OnClientClick="return confirm(&quot;Are you sure you want to reset the page?&quot;);" OnClick="btnReset_Click" CausesValidation="False" />
                 <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-default" OnClick="btnBack_Click" CausesValidation="False" />
             </div>
         </div>
         <label style="color:red">* Required Field</label>
         <hr class="text-light"/>
         <script>
             function posterImg() {
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
         <div class="row">
             <div class="col-lg-4 col-md-5 my-3 text-light">
                 <asp:Image ID="imageView" runat="server" CssClass="img-rounded my-2 w-100 h-auto" ImageUrl="~/Image/default.jpeg" />
                 <label class="form-label requiredField" for="posterFile">Poster Image</label>                
                 <asp:FileUpload ID="posterFile" runat="server" CssClass="form-control my-2" ClientIDMode="Static" onchange="posterImg();" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorFile" runat="server" ErrorMessage="Please select an Image file" ControlToValidate="posterFile" CssClass="invalid-feedback mb-3" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
             </div>
             <div class="col-lg-8 col-md-7">
                 <table class="table table-borderless table-responsive text-light">
                     <tr>
                         <td colspan="2">
                             <div class="form-floating mb-2">
                                 <asp:TextBox ID="txtMovieName" placeholder=" " ClientIDMode="Static" runat="server" CssClass="form-control userInput"></asp:TextBox>
                                 <label for="txtMovieName" class="requiredField">Movie Name</label>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter a movie name" ControlToValidate="txtMovieName" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:TextBox ID="txtDuration" placeholder=" " ClientIDMode="Static" TextMode="Number" runat="server" CssClass="form-control userInput"></asp:TextBox>
                                 <label for="txtDuration" class="requiredField">Duration (minutes)</label>
                                 <asp:RangeValidator ID="RangeValidatorDuration" runat="server" ErrorMessage="Invalid format of duration, Please enter a valid duration (Min.1)" MinimumValue="1" MaximumValue="1000" Type="Integer" ControlToValidate="txtDuration" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RangeValidator>
                             </div>
                         </td>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:DropDownList ID="ddlAge" runat="server" CssClass="form-select w-100 bg-dark arrow userInput" ForeColor="White">
                                     <asp:ListItem>U</asp:ListItem>
                                     <asp:ListItem>P12</asp:ListItem>
                                     <asp:ListItem>P13</asp:ListItem>
                                     <asp:ListItem>P16</asp:ListItem>
                                     <asp:ListItem>P18</asp:ListItem>
                                 </asp:DropDownList>

                                 <label for="ddlAge" class="requiredField">Age Rating</label>
                             </div>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:TextBox ID="txtDate" TextMode="Date" placeholder=" " ClientIDMode="Static" runat="server" CssClass="form-control userInput"></asp:TextBox>
                                 <label for="txtDate" class="requiredField">Release Date</label>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorDate1" runat="server" ErrorMessage="Please enter a release date" ControlToValidate="txtDate" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                         </td>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:TextBox ID="txtEndDate" TextMode="Date" placeholder=" " ClientIDMode="Static" runat="server" CssClass="form-control userInput"></asp:TextBox>
                                 <label for="txtEndDate" class="requiredField">End Date</label>
                                 <asp:CustomValidator ID="EndDateValidator" runat="server" ErrorMessage="Invalid End Date,End Date cannot less than Start Date" OnServerValidate="EndDateValidator_ServerValidate" CssClass="invalid-feedback" ControlToValidate="txtEndDate" Display="Dynamic"></asp:CustomValidator>
                             </div>
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2">
                             <div class="mb-2">
                                 <label for="txtSynopsis" class="form-label requiredField">Synopsis</label>
                                 <asp:TextBox ID="txtSynopsis" ClientIDMode="Static" TextMode="MultiLine" runat="server" CssClass="form-control bg-transparent" ForeColor="White"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please enter a synopsis" ControlToValidate="txtSynopsis" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                         </td>
                     </tr>

                     <tr>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:DropDownList ID="ddlGenre" runat="server" CssClass="form-select w-100 bg-dark userInput arrow" ForeColor="White">
                                     <asp:ListItem Value="Action"></asp:ListItem>
                                     <asp:ListItem Value="Adventure"></asp:ListItem>
                                     <asp:ListItem Value="Animation"></asp:ListItem>
                                     <asp:ListItem Value="Comedy"></asp:ListItem>
                                     <asp:ListItem Value="Crime"></asp:ListItem>
                                     <asp:ListItem Value="Drama"></asp:ListItem>
                                     <asp:ListItem Value="Fantasy"></asp:ListItem>
                                     <asp:ListItem Value="Horror"></asp:ListItem>
                                     <asp:ListItem Value="Mystery"></asp:ListItem>
                                     <asp:ListItem Value="Sports"></asp:ListItem>
                                     <asp:ListItem Value="Romance"></asp:ListItem>
                                 </asp:DropDownList>
                                 <label for="ddlGenre" class="requiredField">Genre</label>
                             </div>
                         </td>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-select w-100 bg-dark userInput arrow" ForeColor="White">
                                     <asp:ListItem Value="ENG">English ENG</asp:ListItem>
                                     <asp:ListItem Value="CN">Chinese CN</asp:ListItem>
                                     <asp:ListItem Value="BM">Melayu BM</asp:ListItem>
                                     <asp:ListItem Value="JPN">Japan JPN</asp:ListItem>
                                     <asp:ListItem Value="TAM">Tamil TAM</asp:ListItem>
                                 </asp:DropDownList>
                                 <label for="ddlLanguage" class="requiredField">Language</label>
                             </div>
                         </td>
                     </tr>

                     <tr>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:TextBox ID="txtActor" placeholder=" " ClientIDMode="Static" runat="server" CssClass="form-control userInput"></asp:TextBox>
                                 <label for="txtActor" class="requiredField">Actor</label>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter actor" ControlToValidate="txtActor" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                         </td>
                         <td>
                             <div class="form-floating mb-2">
                                 <asp:TextBox ID="txtDirector" placeholder=" " ClientIDMode="Static" runat="server" CssClass="form-control userInput"></asp:TextBox>
                                 <label for="txtDirector" class="requiredField">Director</label>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter director" ControlToValidate="txtDirector" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>
                         </td>
                     </tr>

                     <tr>
                         <td>
                             <div class="form-floating">
                                 <asp:TextBox ID="txtMovieURL" TextMode="Url" placeholder=" " ClientIDMode="Static" runat="server" CssClass="form-control userInput"></asp:TextBox>
                                 <label for="txtMovieURL" class="requiredField">Movie URL</label>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a movie url" ControlToValidate="txtMovieURL" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             </div>

                             <asp:ScriptManager runat="server"></asp:ScriptManager>
                             <div class="my-2 mb-2">
                                 <asp:UpdatePanel ID="trailerContainer" runat="server">
                                     <ContentTemplate>
                                         <iframe id="iframeTrailer" runat="server" style='background-image: url("../Image/no-video.png"); background-size: contain; background-repeat: no-repeat;'></iframe>
                                     </ContentTemplate>
                                 </asp:UpdatePanel>
                             </div>
                         </td>
                         <td>
                             <div>
                                 <label for="slideFile" class="requiredField">Slide Image</label>
                                 <asp:FileUpload ID="slideFile" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="img();" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" />
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please select an Image file" ControlToValidate="posterFile" CssClass="invalid-feedback mb-3" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                 <asp:Image ID="slideImageView" runat="server" CssClass="img-rounded my-2 w-75" ImageUrl="../Image/noImage.png" />
                             </div>
                         </td>
                     </tr>
                 </table>

                  <script>
                                 $(document).ready(function () {
                                     $('#<%= txtMovieURL.ClientID %>').on('input', function () { // Bind the input event to the textbox
                                         var url; // Get the URL from the value of the textbox
                                         try {
                                             url = new URL($(this).val());
                                             $('#<%= iframeTrailer.ClientID %>').attr('src', url); // Set the src attribute of the iframe to the URL
                                         } catch (_) {
                                             url = "";
                                         }
                                     });
                                 });
                 </script>
                 <script>
                                 function img() {
                                     var url;
                                     var inputElement = document.getElementById("<%=slideFile.ClientID %>");
                                     if (inputElement.files.length > 0) {
                                         url = inputToURL(inputElement);
                                     } else {
                                         url = "../Image/noImage.png";
                                     }
                                         document.getElementById("<%=slideImageView.ClientID %>").src = url;
                                 }
                                 function inputToURL(inputElement) {
                                     var file = inputElement.files[0];
                                     return window.URL.createObjectURL(file);
                                 }
                 </script>
             </div>
         </div>
    </div>
</asp:Content>
