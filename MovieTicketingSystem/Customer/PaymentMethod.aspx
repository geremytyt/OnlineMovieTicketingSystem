<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Customer.Master" CodeBehind="PaymentMethod.aspx.cs" Inherits="MovieTicketingSystem.View.PaymentMethod" %>

<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    <link href="../css/payment.css" rel="stylesheet" />
    <div class="paymentBody">
    <div class="paymentContainer">
        <div class="heading">
            <h1>Add Credit Card</h1>
            <div class="cards">
                <img src="../Image/mastercard.png" />
            </div>
        </div>
        
        <div class="first-row">
            <div class="owner">
                <h3>Cardholder Name</h3>
                <div class="paymentInput">    
                    <asp:TextBox ID="txtCardName" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="cvv">
                <h3>CVV</h3>
                <div class="paymentInput">
                    <asp:TextBox ID="txtCvv" TextMode="Password" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="second-row">
            <div class="card-number">
                <h3>Card Number</h3>
                <div class="paymentInput">
                    <asp:TextBox ID="txtCardNo" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="third-row">
            <h3>Card Number</h3>
            <div class="selection">
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
                        <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                        <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                        <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                        <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                        <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                        <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                        <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                        <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                
            </div>    
        </div>
        <asp:Button ID="btnPaymentConfirm" class="btnPaymentConfirm" runat="server" Text="Confirm" OnClick="btnPaymentConfirm_Click" />
    </div>
</asp:Content>
