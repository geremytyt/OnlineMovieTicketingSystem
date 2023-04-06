<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="PaymentMethod.aspx.cs" Inherits="MovieTicketingSystem.View.PaymentMethod" %>

<asp:Content ID="Payment" ContentPlaceHolderID="main" runat="server">
    <link href="../css/payment.css" rel="stylesheet" />
    <div class="paymentBody">
    <div class="paymentContainer">
        <h1>Add Credit Card</h1>
        <div class="first-row">
            <div class="owner">
                <h3>Cardholder Name</h3>
                <div class="paymentInput">
                    <input type="text">
                </div>
            </div>
            <div class="cvv">
                <h3>CVV</h3>
                <div class="paymentInput">
                    <input type="password">
                </div>
            </div>
        </div>
        <div class="second-row">
            <div class="card-number">
                <h3>Card Number</h3>
                <div class="paymentInput">
                    <input type="text">
                </div>
            </div>
        </div>
        <div class="third-row">
            <h3>Card Number</h3>
            <div class="selection">
                <div class="date">
                    <select name="months" id="months">
                        <option value="Jan">Jan</option>
                        <option value="Feb">Feb</option>
                        <option value="Mar">Mar</option>
                        <option value="Apr">Apr</option>
                        <option value="May">May</option>
                        <option value="Jun">Jun</option>
                        <option value="Jul">Jul</option>
                        <option value="Aug">Aug</option>
                        <option value="Sep">Sep</option>
                        <option value="Oct">Oct</option>
                        <option value="Nov">Nov</option>
                        <option value="Dec">Dec</option>
                      </select>
                      <select name="years" id="years">
                        <option value="2020">2020</option>
                        <option value="2019">2019</option>
                        <option value="2018">2018</option>
                        <option value="2017">2017</option>
                        <option value="2016">2016</option>
                        <option value="2015">2015</option>
                      </select>
                </div>
                <div class="cards">
                    <img src="mc.png" alt="">
                    <img src="vi.png" alt="">
                    <img src="pp.png" alt="">
                </div>
            </div>    
        </div>
        <asp:Button ID="btnPaymentConfirm" class="btnPaymentConfirm" runat="server" Text="Confirm" OnClick="btnPaymentConfirm_Click" />
    </div>
</asp:Content>
