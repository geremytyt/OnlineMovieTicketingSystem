﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Customer.Master" CodeBehind="PaymentMethod.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.PaymentMethod" %>

<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
    
    <div style="height:700px;">
        <br />
    <div class="paymentContainer mx-auto mt-3">
        <div class="paymentHeading">
            <h1>Add Credit Card</h1>
            <div class="paymentCards">
                <img src="../Image/mastercard.png" />
            </div>
        </div>
        
        <div class="cardFirst-row">
            <div class="cardOwner">
                <h6>Cardholder Name</h6>
                <div class="paymentInput">    
                    <asp:TextBox ID="txtCardName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCardName" CssClass="error" Display="Dynamic" ErrorMessage="Please enter the cardholder name" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="cvv">
                <h6>CVV</h6>
                <div class="paymentInput">
                    <asp:TextBox ID="txtCvv" TextMode="Password" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtCvv" runat="server" ValidationExpression="\d{3}" ErrorMessage="Please enter a 3 digit CVV" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>
        <div class="cardSecond-row">
            <div class="card-number">
                <h6>Card Number</h6>
                <div class="paymentInput">
                    <asp:TextBox ID="txtCardNo" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtCardNo" runat="server" ValidationExpression="^5[1-5][0-9]{14}|^(222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)[0-9]{12}$" 
                        ErrorMessage="Please enter a valid MasterCard number" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>
        <div class="cardThird-row">
            <h6>Expiry Date</h6>
            <div class="cardDateSelection">
                <div class="date">
                    <asp:DropDownList ID="ddlMonths" runat="server">
                        <asp:ListItem Text="Jan" Value="Jan"></asp:ListItem>
                        <asp:ListItem Text="Feb" Value="Feb"></asp:ListItem>
                        <asp:ListItem Text="Mar" Value="Mar"></asp:ListItem>
                        <asp:ListItem Text="Apr" Value="Apr"></asp:ListItem>
                        <asp:ListItem Text="May" Value="May"></asp:ListItem>
                        <asp:ListItem Text="Jun" Value="Jun"></asp:ListItem>
                        <asp:ListItem Text="Jul" Value="Jul"></asp:ListItem>
                        <asp:ListItem Text="Aug" Value="Aug"></asp:ListItem>
                        <asp:ListItem Text="Sep" Value="Sep"></asp:ListItem>
                        <asp:ListItem Text="Oct" Value="Oct"></asp:ListItem>
                        <asp:ListItem Text="Nov" Value="Nov"></asp:ListItem>
                        <asp:ListItem Text="Dec" Value="Dec"></asp:ListItem>
                    </asp:DropDownList>
                      <asp:DropDownList ID="ddlYears" runat="server">
                        <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                        <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                        <asp:ListItem Text="2025" Value="2025"></asp:ListItem>
                        <asp:ListItem Text="2026" Value="2026"></asp:ListItem>
                        <asp:ListItem Text="2027" Value="2027"></asp:ListItem>
                        <asp:ListItem Text="2028" Value="2028"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="CustomValidator"></asp:CustomValidator>
                </div>
                
            </div>    
        </div>
        <asp:Button ID="btnCardConfirm" class="btnCardConfirm" runat="server" Text="Confirm" OnClick="btnCardConfirm_Click" />
    </div>
   
   </div>
</asp:Content>
