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
                 <br />
                 <label for="lbMovieName" class="form-label requiredField">Movie Name</label> 
                 <asp:TextBox ID="txtMovieName" runat="server" CssClass="form-control my-2"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" ErrorMessage="Please enter a movie name" ControlToValidate="txtMovieName" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
             </div>
             <div class="col-lg-8 col-md-7">
                 <table class="table table-borderless table-responsive text-light">
                     <tr>
                         <td>
                             <asp:Label ID="lbDuration" runat="server" Text="Duration (minutes)" CssClass="form-label requiredField"></asp:Label>
                         </td>
                         <td>
                             <asp:Label ID="lbAge" runat="server" Text="Age Rating" CssClass="form-label requiredField"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <asp:TextBox ID="txtDuration" TextMode="Number" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidatorDuration" runat="server" ErrorMessage="Please enter a duration" ControlToValidate="txtDuration" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Please enter a valid duration (Min.1)" Type="Integer" MinimumValue="1" MaximumValue="1000" ControlToValidate="txtDuration" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true" ></asp:RangeValidator>
                         </td>
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
                     <tr>
                         <td>
                             <asp:Label ID="lbReleaseDate" runat="server" Text="Release date" CssClass="form-label requiredField"></asp:Label>
                         </td>
                         <td>
                              <asp:Label ID="lbEndDate" runat="server" Text="End date" CssClass="form-label requiredField"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <asp:TextBox ID="txtDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidatorDate1" runat="server" ErrorMessage="Please enter a release date" ControlToValidate="txtDate" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                         </td>
                         <td>
                             <asp:TextBox ID="txtEndDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidatorDate2" runat="server" ErrorMessage="Please enter a end date" ControlToValidate="txtEndDate" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Invalid End Date,End Date cannot less than Start Date" ClientValidationFunction="checkDate" CssClass="invalid-feedback" ControlToValidate="txtEndDate" Display="Dynamic"></asp:CustomValidator>
                             <script type="text/javascript">
                                 function checkDate(source,arguments) {
                                     var startDate = new Date($('#startDate').val());
                                     var endDate = new Date($('#endDate').val());

                                     if (Date.parse(startDate) < Date.parse(endDate)) {
                                         arguments.IsValid = true;
                                     } else {
                                         arguments.IsValid = false;
                                     }
                                 }
                             </script>
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
                             <asp:RequiredFieldValidator ID="RequiredFieldValidatorSynopsis" runat="server" ErrorMessage="Please enter a synopsis" ControlToValidate="txtSynopsis" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
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
                         </td>
                         <td>
                             <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-select">
                                 <asp:ListItem Value="ENG">English ENG</asp:ListItem>
                                 <asp:ListItem Value="CN">Chinese CN</asp:ListItem>
                                 <asp:ListItem Value="BM">Melayu BM</asp:ListItem>
                                 <asp:ListItem Value="JPN">Japan JPN</asp:ListItem>
                                 <asp:ListItem Value="TAM">Tamil TAM</asp:ListItem>
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
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter actor" ControlToValidate="txtActor" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                         </td>
                         <td>
                             <asp:TextBox ID="txtDirector" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter director" ControlToValidate="txtDirector" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             <asp:ScriptManager runat="server"></asp:ScriptManager>
                             <asp:Label ID="lbMovieURL" runat="server" Text="Movie URL" CssClass="form-label requiredField text-light"></asp:Label>
                             <asp:TextBox ID="txtMovieURL" CssClass="form-control" runat="server" TextMode="Url"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter a movie url" ControlToValidate="txtMovieURL" CssClass="invalid-feedback" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                             <div class="my-2">
                                 <asp:UpdatePanel ID="trailerContainer" runat="server">
                                     <ContentTemplate>
                                         <iframe id="iframeTrailer" runat="server" style='background-image:url("../Image/no-video.png");background-size: contain;background-repeat: no-repeat;'>
                                         </iframe>
                                     </ContentTemplate>
                                 </asp:UpdatePanel>
                             </div>
                             <%-- handel the iframe event --%>
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
                         </td>
                         <td>
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
                             <asp:Label ID="lbSlideImage" runat="server" Text="Slide Image" CssClass="form-label requiredField text-light"></asp:Label>
                             <asp:FileUpload ID="slideFile" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="img();" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" />
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please select an Image file" ControlToValidate="slideFile" CssClass="invalid-feedback mb-3" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                             <asp:Image ID="slideImageView" runat="server" CssClass="img-rounded my-2 w-75" ImageUrl="../Image/noImage.png"/>  
                         </td>
                     </tr>
                 </table>
             </div>
         </div>
    </div>
</asp:Content>
