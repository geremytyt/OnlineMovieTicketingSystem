<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Movie.aspx.cs" Inherits="Movie_Ticketing_System.View.WebForm1" %>

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
                <table class="table table-stripped table-dark">
                    <tr>
                        <td>
                            <label class="form-label">Select Date</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlDate" runat="server" CssClass="form-control" ></asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
