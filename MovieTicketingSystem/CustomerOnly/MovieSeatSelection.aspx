<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="MovieSeatSelection.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.MovieSeatSelection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container bg-dark my-2">
        <div class="text-light mt-2 pt-2 border-bottom d-flex flex-column">
            <asp:Label ID="lbMovieName" runat="server"  CssClass="text-center fs-4"></asp:Label>
            <asp:Label ID="lbMovieInfo" runat="server"  CssClass="text-center fw-light"></asp:Label>
        </div>
        <div class="text-light pt-2 border-bottom d-flex flex-column">
            <asp:Label ID="lbHall" runat="server"  CssClass="text-center"></asp:Label>
            <asp:Label ID="lbDateTime" runat="server"  CssClass="text-center"></asp:Label>
        </div>
        <div> 
            <ul class="showcase text-light">
                <li>
                    <div class="seat"></div>
                    <small>Available</small>
                </li>
                <li>
                    <div class="seat selected"></div>
                    <small>Selected</small>
                </li>
                <li>
                    <div class="seat sold"></div>
                    <small>Sold</small>
                </li>
            </ul>
        </div>
        <div class="d-flex justify-content-center outer-container">
            <div class="seat-container w-75 justify-content-center" runat="server" id="seatContainer">
                <div class="screen"></div>

            </div>
        </div>
        <div class="d-grid">
            <asp:Button ID="btnConfirm" CssClass="btn btn-default p-2 m-2" runat="server" Text="Confirm" OnClick="btnNext_Click"/>
        </div>

    </div>
    <script src="../js/Script.js"></script>
</asp:Content>

