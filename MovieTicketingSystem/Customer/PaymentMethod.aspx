<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Customer.Master" CodeBehind="PaymentMethod.aspx.cs" Inherits="MovieTicketingSystem.View.PaymentMethod" %>

<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
   <div style="height:700px;">
    <link href="../css/payment.css" rel="stylesheet" />
    <div class="paymentContainer mx-auto mt-3">
        <div class="heading">
            <h1>Add Credit Card</h1>
            <div class="cards">
                <img src="../Image/mastercard.png" />
            </div>
        </div>
        
        <div class="first-row">
            <div class="owner">
                <h6>Cardholder Name</h6>
                <div class="paymentInput">    
                    <asp:TextBox ID="txtCardName" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="cvv">
                <h6>CVV</h6>
                <div class="paymentInput">
                    <asp:TextBox ID="txtCvv" TextMode="Password" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="second-row">
            <div class="card-number">
                <h6>Card Number</h6>
                <div class="paymentInput">
                    <asp:TextBox ID="txtCardNo" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="third-row">
            <h6>Expiry Date</h6>
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
                        <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                        <asp:ListItem Text="2025" Value="2025"></asp:ListItem>
                        <asp:ListItem Text="2026" Value="2026"></asp:ListItem>
                        <asp:ListItem Text="2027" Value="2027"></asp:ListItem>
                        <asp:ListItem Text="2028" Value="2028"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                
            </div>    
        </div>
        <asp:Button ID="btnPaymentConfirm" class="btnPaymentConfirm" runat="server" Text="Confirm" OnClick="btnPaymentConfirm_Click" />
    </div>
        </div>
</asp:Content>
