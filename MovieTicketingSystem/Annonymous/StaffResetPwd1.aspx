﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="StaffResetPwd1.aspx.cs" Inherits="MovieTicketingSystem.Annonymous.StaffResetPwd1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div id="content" class="text-light d-flex align-items-center justify-content-center"  style="min-height: 100vh;">
        <div class="bg-black rounded col-md-5 col-lg-3 col-sm-6">     
            <div class="nav-link active flex-grow-1 loginTab p-3 text-center">Reset Password</div> 
                <div class="row mt-2 justify-content-center">
                    <i class="fa-solid fa-user" style="width:10%;margin-top:30px"></i>
                    <div class="form-floating" id="float" style="width:60%;">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control userInput" placeholder=" " />
                        <label for="txtEmail">Email</label>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Please enter your email" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEmail" CssClass="text-danger" runat="server" ErrorMessage="Invalid Email" Display="Dynamic" SetFocusOnError="true"></asp:CustomValidator>
                    </div>
                </div>
            <div class="text-center">
                <asp:Button class="btn btn-default my-4" ID="btnToken" runat="server" Text="Send Token" OnClick="btnToken_Click" />
            </div>
        </div>
    </div>
</asp:Content>
