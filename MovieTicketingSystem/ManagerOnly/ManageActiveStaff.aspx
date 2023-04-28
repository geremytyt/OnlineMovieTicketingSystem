<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="ManageActiveStaff.aspx.cs" Inherits="MovieTicketingSystem.ManagerOnly.ManageStaff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>
     <script type="text/javascript">
        $(function () {
            $("[id*=gvStaff]").DataTable(
                {
                    bLengthChange: true,
                    bFilter: true,
                    bSort: true,
                    bPaginate: true
                });
        });
     </script>
    <div class="mx-auto" style="width:85%;">
    <h1 class="text-white pt-2">Staff Account</h1>
    <hr width="100%" style="border: 1px solid white"/>
    <div class="row">
        <div class="text-white col-md-8" style="height:600px;">
            <div class="nav nav-tabs border-0"id="nav-tab" role="tablist">
                <asp:Button ID="btnActive" runat="server" Text="Active" CssClass="nav-link active w-25 text-black mb-2 border-0" BackColor="#F4E618" BorderColor="White" CausesValidation="false"/>
                <asp:Button ID="btnResigned" runat="server" Text="Resigned" CssClass="nav-link w-25 text-white mb-2" BorderColor="White" CausesValidation="false" OnClick="btnResigned_Click"/>
            </div>
            <asp:GridView ID="gvStaff" runat="server" AutoGenerateColumns="False" DataKeyNames="staffId" ClientIDMode="Static"
                CssClass="table w-100 table-dark table-striped my-1 table-bordered table-responsive table-hover">
                <Columns>
                    <asp:BoundField DataField="staffId" HeaderText="ID" SortExpression="staffId" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="staffName" HeaderText="Name" SortExpression="staffName"></asp:BoundField>
                    <asp:BoundField DataField="staffEmail" HeaderText="Email" SortExpression="staffEmail"></asp:BoundField>
                    <asp:BoundField DataField="staffIC" HeaderText="IC" SortExpression="staffIC"></asp:BoundField>
                    <asp:BoundField DataField="staffPhoneNo" HeaderText="Phone No" SortExpression="staffPhoneNo"></asp:BoundField>
                    <asp:BoundField DataField="staffGender" HeaderText="Gender" SortExpression="staffGender"></asp:BoundField>
                    <asp:BoundField DataField="position" HeaderText="Position" SortExpression="position"></asp:BoundField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <div class="d-grid gap-2 d-md-flex">
                                <asp:Button ID="btnView" runat="server" Text="View" CommandArgument='<%# Container.DataItemIndex %>' class="btn btn-default"  OnCommand="btnView_Command" CausesValidation="false"/>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="col-md-4">
            <div class="bg-dark rounded-4 text-white mb-2 ">
                <div class="row justify-content-center align-items-center">
                    <h3 class="text-center mt-2">Record</h3>
                        <div class="w-75">
                            <label class="">Staff ID:</label>
                            <asp:Label ID="lblId" runat="server" Text="asd" CssClass="m-2"></asp:Label>
                        </div>
                        <div class="form-floating w-75" id="float">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control userInput" placeholder=" " />
                            <label for="txtName">Name</label>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Please enter name" SetFocusOnError="true" ControlToValidate="txtName" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-floating w-75" id="float1">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Email" />
                            <label for="txtEmail">Email</label>
                            <asp:CustomValidator ID="cvExistEmail" runat="server" ControlToValidate="txtEmail" Cssclass="text-danger" Display="Dynamic" ErrorMessage="This email has been registered" SetFocusOnError="true"></asp:CustomValidator> 
                        </div>
                        <div class="form-floating w-75" id="float5">
                            <asp:TextBox ID="txtIC" runat="server" CssClass="form-control userInput" placeholder=" " />
                            <label for="txtDob">IC</label>
                            <asp:RequiredFieldValidator ID="rfvIC" runat="server" ErrorMessage="Please enter IC" SetFocusOnError="true" ControlToValidate="txtIC" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revIC" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Invalid IC" SetFocusOnError="true" ControlToValidate="txtIC" ValidationExpression="\d{12}"></asp:RegularExpressionValidator>
                        </div>
                        <div class="form-floating w-75" id="float4">
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control userInput" placeholder=" " TextMode="Phone" />
                            <label for="txtPhone">Phone No</label>
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ErrorMessage="Please enter phone no" SetFocusOnError="true" ControlToValidate="txtPhone" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvExistPhone" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="This phone no has been registered" ControlToValidate="txtPhone" SetFocusOnError="true"></asp:CustomValidator>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Invalid format of phone no" SetFocusOnError="true" ControlToValidate="txtPhone" ValidationExpression="^(\+?6?01)[0|1|2|3|4|6|7|8|9]\-*[0-9]{7,8}$"></asp:RegularExpressionValidator>
                        </div>
                        <div class="row my-3 align-items-center w-75">
                            <div class="w-25">
                                <asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
                            </div>
                            <div class="w-75">
                                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="100%">
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvGender" runat="server" ErrorMessage="Please select gender" SetFocusOnError="true" ControlToValidate="rblGender" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                        </div>
                        <div class="row mb-3 align-items-center w-75">
                            <div class="w-25">
                                <asp:Label ID="lblPosition" runat="server" Text="Position:" CssClass="w-25"></asp:Label>
                            </div>
                            <div class="w-75">
                                <asp:DropDownList ID="ddlPosition" CssClass="w-100 p-2 bg-dark" runat="server" ForeColor="White">
                                    <asp:ListItem>Cashier</asp:ListItem>
                                    <asp:ListItem>Usher</asp:ListItem>
                                    <asp:ListItem>Film Projectionist</asp:ListItem>
                                    <asp:ListItem>Cleaner</asp:ListItem>
                                    <asp:ListItem>Mechanic</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select position" SetFocusOnError="true" ControlToValidate="ddlPosition" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-default mx-2 mb-2" OnClick="btnAdd_Click" Width="40%"/>
                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-default mx-2 mb-2" OnClick="btnReset_Click" Width="40%"/>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-default mx-2 mb-4" OnClick="btnEdit_Click" Width="40%" Enabled="false"/>
                        <asp:Button ID="btnDelete" runat="server" Text="Unresign" CssClass="btn btn-default mx-2 mb-4" OnClick="btnDelete_Click" Width="40%" Enabled="false"/>
                    </div>
            </div>
        </div>
        </div>
    </div>
</asp:Content>
