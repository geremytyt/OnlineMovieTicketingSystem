﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="UserReport.aspx.cs" Inherits="MovieTicketingSystem.ManagerOnly.UserReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
<div class="container row" id="reportContainer" style="height:700px;">
  <div class="col-md-4 p-3">
         <div class="row ">
                <h1  class="nav nav-tabs flex-column align-items-center border-0" >Report Type</h1>
                <ul class="nav nav-tabs flex-column align-items-center profileTab border-0">
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnSale" runat="server" Text="Sale Report" class="profileTab nav-link " OnClick="btnSale_Click"  type="button" CausesValidation="false"/>
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnMovieReport" runat="server" Text="Movie Report" class="profileTab  nav-link" type="button" OnClick="btnMovieReport_Click"  CausesValidation="false"/>
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnFoodReport" runat="server" Text="Food Sale Report " class="profileTab  nav-link " type="button" OnClick="btnFoodReport_Click"  CausesValidation="false" />
                    </li>
                    <li class="nav-item mb-3">
                        <asp:Button ID="btnUser" runat="server" Text="User Report" class="profileTab active nav-link" type="button" OnClick="btnUser_Click" CausesValidation="false"/>
                    </li>
                </ul>
        </div>
      </div>


    <div class="col-md-8" style="height:650px;">
        <div class="tab-content container-fluid" id="nav-tabContent">
           <div class="tab-pane fade show active p-3" id="reportContenier">
               <div class="text-white w-100">
                   <!----Start uour report here --->    
                   <h1> User Report</h1>
               
               
               </div>
           </div>
        </div>
    </div>
</div>
</asp:Content>
