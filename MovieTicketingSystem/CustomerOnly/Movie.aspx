<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Movie.aspx.cs" Inherits="MovieTicketingSystem.CustomerOnly.Movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 my-2">
                <div class="bg-transparent card text-light text-center border-0" style="width: 15rem;">
                    <asp:Image ID="imgPoster" CssClass="card-img-top image-fluid image-poster" runat="server" ImageAlign="Middle" />
                    <asp:Label ID="lbMovieName" runat="server"></asp:Label>
                </div>
            </div>
            <div class="col-lg-9 my-2">
                <table class="table table-striped table-dark table-borderless">
                    <tr>
                        <td>
                            <label class="form-label">Select Date</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlDate" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="scheduleDateTime" DataValueField="scheduleNo"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MovieConnectionString %>' SelectCommand="SELECT * FROM Schedule WHERE movieId = @Id">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="movieId" Name="Id"></asp:QueryStringParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn btn-default m-2" OnClick="btnNext_Click"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
