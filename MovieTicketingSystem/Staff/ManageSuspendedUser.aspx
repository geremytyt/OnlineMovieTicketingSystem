<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="ManageSuspendedUser.aspx.cs" Inherits="MovieTicketingSystem.Staff.ManageSuspendedUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
  <div class="mx-auto" style="width:85%;">
    <h1 class="text-white pt-2">Users Account</h1>
    <hr width="100%" style="border: 1px solid white"/>
    <div class="row">
        <div class="text-white col-md-8 " style="height:600px;">
            <div class="nav nav-tabs border-0"id="nav-tab" role="tablist">
                <asp:Button ID="btnActive" runat="server" Text="Active" CssClass="nav-link w-25 text-white mb-2" OnClick="btnActive_Click" BorderColor="White"/>
                <asp:Button ID="btnSuspended" runat="server" Text="Suspended" CssClass="nav-link active w-25 text-black mb-2 border-0" BackColor="#F4E618" />
            </div>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="custId" DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True" 
                OnSelectedIndexChanged="GridView2_SelectedIndexChanged" HorizontalAlign="Center" ItemStyle-CssClass="gridview-cell" Width="100%">
                <Columns>
                    <asp:BoundField DataField="custId" HeaderText="ID" ReadOnly="True" SortExpression="custId"></asp:BoundField>
                    <asp:BoundField DataField="custName" HeaderText="Name" SortExpression="custName"></asp:BoundField>
                    <asp:BoundField DataField="custEmail" HeaderText="Email" SortExpression="custEmail"></asp:BoundField>
                    <asp:BoundField DataField="custDob" HeaderText="DoB" SortExpression="custDob" DataFormatString="{0:d}"></asp:BoundField>
                    <asp:BoundField DataField="custPhoneNo" HeaderText="PhonenNo" SortExpression="custPhoneNo"></asp:BoundField>
                    <asp:BoundField DataField="custGender" HeaderText="Gender" SortExpression="custGender">
                    </asp:BoundField>
                    <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                </Columns>
                <RowStyle Height="50px" BackColor="#262626" ForeColor="White" BorderColor="White" HorizontalAlign="Center"/>
                <AlternatingRowStyle BackColor="#5c5c5c" ForeColor="White" BorderColor="White" />
                <HeaderStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#f4e618" ForeColor="Black"/>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MovieConnectionString %>" SelectCommand="SELECT DISTINCT [custId], [custName], [custEmail], [custDob], [custPhoneNo], [custGender] FROM [Customer] WHERE ([custStatus] = @custStatus)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="Suspended" Name="custStatus" Type="String"></asp:Parameter>
                </SelectParameters>

            </asp:SqlDataSource>
        </div>     
        <div class="col-md-4">
            <div class="bg-dark rounded-4 text-white mb-2">
                <div class="row">
                    <h3 class="text-center mt-2">Record</h3>
                    <div>
                        <asp:TextBox ID="txtSearch" runat="server" style="width:70%;" Cssclass="ms-4 rounded-4 p-2" placeholder="Search"></asp:TextBox>
                        <button class="btn btn-default my-2" style="width:40px" type="submit"><i class="fas fa-search"></i></button>
                    </div>
                    <div class="m-4">
                        <label>Customer ID:</label>
                        <asp:Label ID="lblId" runat="server" Text="" CssClass="m-2"></asp:Label>
                        <div class="form-floating w-75" id="float">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control userInput" placeholder=" " />
                            <label for="txtName">Name</label>
                        </div>
                        <div class="form-floating w-75" id="float1">
                            <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" CssClass="form-control userInput" placeholder=" " TextMode="Email" />
                            <label for="txtEmail">Email</label>
                        </div>
                        <div class="form-floating w-75" id="float5">
                            <asp:TextBox ID="txtDob" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Date" />
                            <label for="txtDob">Date Of Birth</label>
                        </div>
                        <div class="form-floating w-75" id="float4">
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Phone" />
                            <label for="txtPhone">Phone No</label>
                        </div>
                        <div class="row my-3 ms-1 align-items-center">
                            <div class="w-25">
                                <asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
                            </div>
                            <div class="w-50">
                                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="100%">
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-default" OnClick="btnEdit_Click" Width="40%" Enabled="false"/>
                        <asp:Button ID="btnDelete" runat="server" Text="Unsuspend" CssClass="btn btn-default" OnClick="btnDelete_Click" Width="40%" Enabled="false"/>
                    </div>
                </div>  
            </div>
        </div>
    </div>
    </div>
</asp:Content>
