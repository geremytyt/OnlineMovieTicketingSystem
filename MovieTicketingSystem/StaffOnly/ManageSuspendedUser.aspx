<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="ManageSuspendedUser.aspx.cs" Inherits="MovieTicketingSystem.StaffOnly.ManageSuspendedUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>
     <script type="text/javascript">
        $(function () {
            $("[id*=gvUser]").DataTable(
                {
                    bLengthChange: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true
                });
        });
    </script>
    <div class="mx-auto" style="width:85%;">
    <h1 class="text-white pt-2">Users Account</h1>
    <hr width="100%" style="border: 1px solid white"/>
    <div class="row">
        <div class="text-white col-md-8 " style="height:600px;">
            <div class="nav nav-tabs border-0"id="nav-tab" role="tablist">
                <asp:Button ID="btnActive" runat="server" Text="Active" CssClass="nav-link w-25 text-white mb-2" OnClick="btnActive_Click" BorderColor="White" CausesValidation="false"/>
                <asp:Button ID="btnSuspended" runat="server" Text="Suspended" CssClass="nav-link active w-25 text-black mb-2 border-0" BackColor="#F4E618" CausesValidation="false"/>
            </div>
            <asp:GridView ID="gvUser" runat="server" AutoGenerateColumns="False" DataKeyNames="custId" ClientIDMode="Static"
                CssClass="table w-100 table-dark table-striped my-1 table-bordered table-responsive table-hover">
                <Columns>
                    <asp:BoundField DataField="custId" HeaderText="ID" ReadOnly="True" SortExpression="custId"></asp:BoundField>
                    <asp:BoundField DataField="custName" HeaderText="Name" SortExpression="custName"></asp:BoundField>
                    <asp:BoundField DataField="custEmail" HeaderText="Email" SortExpression="custEmail"></asp:BoundField>
                    <asp:BoundField DataField="custDob" HeaderText="DoB" SortExpression="custDob" DataFormatString="{0:d}"></asp:BoundField>
                    <asp:BoundField DataField="custPhoneNo" HeaderText="PhonenNo" SortExpression="custPhoneNo"></asp:BoundField>
                    <asp:BoundField DataField="custGender" HeaderText="Gender" SortExpression="custGender">
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <div class="d-grid gap-2 d-md-flex">
                                <asp:Button ID="btnView" runat="server" Text="View" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default" OnCommand="btnView_Command" CausesValidation="false"/>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>     
        <div class="col-md-4">
            <div class="bg-dark rounded-4 text-white mb-2">
                <div class="row">
                    <h3 class="text-center mt-2">Record</h3>
                    <div class="m-4">
                        <label>Customer ID:</label>
                        <asp:Label ID="lblId" runat="server" Text="" CssClass="m-2"></asp:Label>
                        <div class="form-floating w-75" id="float">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control userInput" placeholder=" " />
                            <label for="txtName">Name</label>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Please enter name" Display="Dynamic" CssClass="text-danger" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-floating w-75" id="float1">
                            <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" CssClass="form-control userInput" placeholder=" " TextMode="Email" />
                            <label for="txtEmail">Email</label>
                            <asp:CustomValidator ID="cvExistEmail" runat="server" ControlToValidate="txtEmail" Cssclass="text-danger" Display="Dynamic" ErrorMessage="This email has been registered" SetFocusOnError="true"></asp:CustomValidator> 
                        </div>
                        <div class="form-floating w-75" id="float5">
                            <asp:TextBox ID="txtDob" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Date" />
                            <label for="txtDob">Date Of Birth</label>
                            <asp:RequiredFieldValidator ID="rfvDob" runat="server" ErrorMessage="Please enter date of birth" Display="Dynamic" CssClass="text-danger" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-floating w-75" id="float4">
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Phone" />
                            <label for="txtPhone">Phone No</label>
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ErrorMessage="Please enter phone no" Display="Dynamic" CssClass="text-danger" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Invalid format of phone no" SetFocusOnError="true" ControlToValidate="txtPhone" ValidationExpression="^(\+?6?01)[0|1|2|3|4|6|7|8|9]\-*[0-9]{7,8}$"></asp:RegularExpressionValidator>
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
                            <asp:RequiredFieldValidator ID="rfvGender" runat="server" ErrorMessage="Please select gender" Display="Static" CssClass="text-danger" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                        </div>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-default" OnClick="btnEdit_Click" Width="40%" Enabled="false"/>
                        <asp:Button ID="btnDelete" runat="server" Text="Suspend" CssClass="btn btn-default" OnClick="btnDelete_Click" Width="40%" Enabled="false"/>
                    </div>
                </div>  
            </div>
        </div>
    </div>
    </div>
</asp:Content>
