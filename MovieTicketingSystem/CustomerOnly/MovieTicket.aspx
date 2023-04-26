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

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="text-light pt-2 border-bottom row">
                    <div class="col-6 text-center d-flex flex-column">
                        <label style="color: gray;">Seat(s)</label>
                        <asp:Label ID="lbSeatIndex" runat="server"></asp:Label>
                    </div>
                    <div class="col-6 text-center d-flex flex-column">
                        <label style="color: gray;">Ticket(s)</label>
                        <asp:Label ID="lbAdultTicket" CssClass="text-light" runat="server"></asp:Label>
                        <asp:Label ID="lbChildrenTicket" CssClass="text-light" runat="server"></asp:Label>
                        <asp:Label ID="lbSeniorTicket" CssClass="text-light" runat="server"></asp:Label>
                        <asp:Label ID="lbTotalTicket" CssClass="text-light" runat="server"></asp:Label>
                    </div>

                </div>
                <table class="text-light table table-borderless text-center d-flex justify-content-center">
                    <tr>
                        <td class="align-middle">
                            <label id="lbAdult" class="form-label p-2 m-1">Adult</label></td>
                        <td class="align-middle">
                            <div class="input-group">
                                <asp:Button ID="btnAdultAdd" runat="server" CssClass="btn btn-warning" Text="+" CommandArgument="+" OnCommand="btnAdult_Command" />
                                <asp:Label ID="lbAdultCount" runat="server" Text="0" CssClass="p-2 border"></asp:Label>
                                <asp:Button ID="btnAdultMinus" CssClass="btn btn-warning" runat="server" Text="-" CommandArgument="-" OnCommand="btnAdult_Command" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="align-middle">
                            <label id="lbChildren" class="form-label p-2 m-1">Children</label></td>
                        <td class="align-middle">
                            <div class="input-group">
                                <asp:Button ID="btnChildrenAdd" runat="server" CssClass="btn btn-warning" Text="+" CommandArgument="+" OnCommand="btnChildren_Command" />
                                <asp:Label ID="lbChildrenCount" runat="server" Text="0" CssClass="p-2 border"></asp:Label>
                                <asp:Button ID="btnChildrenMinus" CssClass="btn btn-warning " runat="server" Text="-" CommandArgument="-" OnCommand="btnChildren_Command"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="align-middle">
                            <label id="lbSenior" class="form-label p-2 m-1">Senior</label></td>
                        <td class="align-middle">
                            <div class="input-group">
                                <asp:Button ID="btnSeniorAdd" runat="server" CssClass="btn btn-warning" Text="+" CommandArgument="+" OnCommand="btnSenior_Command"/>
                                <asp:Label ID="lbSeniorCount" runat="server" Text="0" CssClass="p-2 border"></asp:Label>
                                <asp:Button ID="btnSeniorMinus" CssClass="btn btn-warning" runat="server" Text="-" CommandArgument="-" OnCommand="btnSenior_Command"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

         <div class="d-grid gap-2 col-6 mx-auto">
            <asp:Button ID="btnFood" CssClass="btn btn-default p-2 m-2" runat="server" Text="Proceed to food" CommandArgument="Food" OnCommand="NextPage_Command"/>
            <asp:Button ID="btnPayment" CssClass="btn btn-default p-2 m-2" runat="server" Text="Proceed to payment" CommandArgument="Payment" OnCommand="NextPage_Command"/>
        </div>
    </div>
</asp:Content>
