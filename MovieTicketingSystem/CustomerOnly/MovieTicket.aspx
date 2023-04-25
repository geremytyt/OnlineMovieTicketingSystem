<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="MovieTicket.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.MovieTicket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container bg-dark my-2">
        <div class="text-light mt-2 pt-2 border-bottom d-flex flex-column">
            <asp:Label ID="lbMovieName" runat="server"  CssClass="text-center fs-4"></asp:Label>
            <asp:Label ID="lbMovieInfo" runat="server"  CssClass="text-center fw-light"></asp:Label>
        </div>
        <div class="text-light pt-2 border-bottom d-flex flex-column">
            <asp:Label ID="lbHall" runat="server"  CssClass="text-center"></asp:Label>
            <asp:Label ID="lbDateTime" runat="server"  CssClass="text-center"></asp:Label>
        </div>

        <div class="text-light pt-2 border-bottom row">
            <div class="col-6 text-center d-flex flex-column">
                <label style="color: gray;">Seat(s)</label>
                <asp:Label ID="lbSeatIndex" runat="server" ></asp:Label>
            </div>
            <div class="col-6 text-center d-flex flex-column">
                <label style="color: gray;">Ticket(s)</label>
                <asp:Label ID="lbTicket" runat="server" ></asp:Label>
            </div>

        </div>
    </div>
</asp:Content>
