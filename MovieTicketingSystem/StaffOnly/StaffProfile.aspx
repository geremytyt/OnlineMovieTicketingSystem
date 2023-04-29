<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffProfile.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.StaffProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
<div class="col-md-10 py-5 mx-auto text-white">
        <div class="row bg-black rounded-4">
            <div class="col-md-4 p-3">
                <asp:Image ID="imgPreview" runat="server" class="mt-3 mx-auto d-block" Width="200px" Height="200px" AlternateText="No Picture Uploaded" ImageAlign="AbsMiddle" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" ImageUrl="~/Image/default.jpeg"/>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control d-block mx-auto w-75 mt-2" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" onchange="uploadImg()"/>
                <hr class="mx-auto w-75" style="border:1px solid white;"/>
                <div class="row ">
                    <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnProfile" runat="server" Text="My Profile" class="profileTab nav-link active" type="button" OnClick="btnProfile_Click" CausesValidation="false" />
                        </li>
                        <li class="nav-item mb-3">
                            <asp:Button ID="btnResetPwd" runat="server" Text="Reset Password" class="profileTab nav-link" type="button" OnClick="btnResetPwd_Click" CausesValidation="false"/>
                        </li>
                    </ul>
            </div>
            <hr class="mx-auto w-75" style="border:1px solid white;"/>
            </div>
            <div class="col-md-8" style="height:650px;">
                <div class="tab-content container-fluid" id="nav-tabContent">
                    <div class="tab-pane fade show active p-3" id="nav-myProfile">
                        <h3 class="text-white">My Profile</h3>
                        <hr style="border:1px solid white"/>
                            <div class="my-4 mx-auto row">
                                <h6 class="w-25 align-self-end">Name</h6>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control w-75 userInput" placeholder=" "/>
                                <i class="w-25"></i>
                                <asp:RequiredFieldValidator ID="rfvName" CssClass="text-danger w-75" Display="Dynamic" runat="server" ErrorMessage="Please enter your name" SetFocusOnError="true" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                            </div>
                            <div class="my-4 mx-auto row">
                                <h6 class="w-25 align-self-end">Email</h6>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control w-75 userInput" placeholder=" " ReadOnly="true" />
                            </div>
                            <div class="my-4 mx-auto row">
                                <h6 class="w-25 align-self-end">Phone No</h6>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control w-75 userInput" placeholder=" " TextMode="Phone"/>
                                <i class="w-25"></i>
                                <asp:CustomValidator ID="cvExistPhone" runat="server" CssClass="text-danger w-75" Display="Dynamic" ErrorMessage="This phone no has been registered" SetFocusOnError="true"></asp:CustomValidator>
                                <asp:RequiredFieldValidator ID="rfvPhone" CssClass="text-danger w-75" Display="Dynamic" runat="server" ErrorMessage="Please enter your phone no" SetFocusOnError="true" ControlToValidate="txtPhone"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPhone" runat="server" Display="Dynamic" CssClass="text-danger w-75" ErrorMessage="Invalid format of phone no" SetFocusOnError="true" ControlToValidate="txtPhone" ValidationExpression="^(\+?6?01)[0|1|2|3|4|6|7|8|9]\-*[0-9]{7,8}$"></asp:RegularExpressionValidator>
                            </div>
                            <div class="my-4 mx-auto row">
                                <h6 class="w-25 align-self-end">IC</h6>
                                <asp:TextBox ID="txtIC" runat="server" CssClass="form-control w-75 userInput" placeholder=" "/>
                                <i class="w-25"></i>
                                <asp:CustomValidator ID="cvExistIC" runat="server" CssClass="text-danger w-75" Display="Dynamic" ErrorMessage="This IC has been registered" SetFocusOnError="true"></asp:CustomValidator>
                                <asp:RequiredFieldValidator ID="rfvIC" CssClass="text-danger w-75" Display="Dynamic" runat="server" ErrorMessage="Please enter your IC" SetFocusOnError="true" ControlToValidate="txtIC"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revIC" runat="server" ErrorMessage="Incorrect format of IC" CssClass="text-danger w-75" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtIC" ValidationExpression="\d{12}"></asp:RegularExpressionValidator>
                            </div>
                            <div class="my-4 mx-auto row">
                                <h6 class="w-25 align-self-end">Gender</h6>
                                <asp:RadioButtonList ID="rblGender" CssClass="text-center" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="75%">
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:RadioButtonList>
                                <i class="w-25"></i>
                                <asp:RequiredFieldValidator ID="rfvGender" CssClass="text-danger w-75" Display="Dynamic" runat="server" ErrorMessage="Please select your gender" SetFocusOnError="true" ControlToValidate="rblGender"></asp:RequiredFieldValidator>
                            </div>
                            <div class="my-4 mx-auto row">
                                <h6 class="w-25 align-self-end">Position</h6>
                                <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control w-75 userInput" placeholder=" " ReadOnly="true"/>
                                <i class="w-25"></i>
                            </div>
                        <asp:Button class="btn btn-default btn-block w-25 my-3 float-end" ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
                    </div>
                </div>
            </div>
        </div>
    <script>
        function uploadImg() {
            var fileInput = document.getElementById("<%=fileUpload.ClientID%>");
            var file = fileInput.files[0];
            if (file) {
                var reader = new FileReader(); 
                reader.onload = function (e) {
                    var fileUrl = e.target.result;
                    var imgPreview = document.getElementById("<%=imgPreview.ClientID%>");
                    imgPreview.src = fileUrl;
                };
                reader.readAsDataURL(file);
            }
        }

    </script>
    </div>
</asp:Content>