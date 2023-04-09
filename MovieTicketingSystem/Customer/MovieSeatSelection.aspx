<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="MovieSeatSelection.aspx.cs" Inherits="MovieTicketingSystem.MovieSeatSelection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../css/movie.css" rel="stylesheet" />
    <div class="container">
        <div class="row">
            <div class="col-lg-3 my-2">
                <div class="bg-transparent card text-light text-center border-0" style="width: 15rem;">
                    <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid" runat="server" ImageAlign="Middle" />
                    <asp:Label ID="lbMovieName" runat="server"></asp:Label>
                </div>
            </div>
            <div class="col-lg-9 my-2">
                <table class="table table-dark table-borderless">
                    <tr>
                        <td>
                             <label class="form-label">Hall : </label>
                        </td>
                        <td>
                                <asp:Label ID="lbHall" runat="server" Text="Label"></asp:Label>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Date & Time : </label>
                        </td>
                        <td>
                            <asp:Label ID="lbDateTime" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <img src="../Image/Seat.png" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div>
                                <label class="form-label">Select Seat</label>
                                <asp:TextBox ID="txtSeat" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div>
                                <label class="form-label fw-bold text-decoration-underline">Ticket</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Adult</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAdult" runat="server" TextMode="Number" CssClass="form-control" Text="0"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Child</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtKid" runat="server" TextMode="Number" CssClass="form-control" Text="0"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="form-label">Senior Citizen</label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSenior" runat="server" TextMode="Number" CssClass="form-control" Text="0"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn btn-default m-2" OnClick="btnNext_Click"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>