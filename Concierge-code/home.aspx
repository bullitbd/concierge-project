﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="home.aspx.vb" Inherits="home"
    ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="HTMLEditor" %>
<%@ Register Namespace="ConciergeControls" TagPrefix="custom" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" TagPrefix="obout" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor.ToolbarButton"
    TagPrefix="obout" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Rocket21 Concierge Mailing System</title>
    <link type="text/css" rel="stylesheet" href="http://r21concierge.s3.amazonaws.com/floatbox_427/floatbox.css" />

    <script type="text/javascript" src="http://r21concierge.s3.amazonaws.com/floatbox_427/floatbox.js"></script>

    <script type="text/javascript" src="http://r21concierge.s3.amazonaws.com/floatbox_427/options.js"></script>

    <link href="./css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="http://r21concierge.s3.amazonaws.com/css/concierge.css" rel="stylesheet"
        type="text/css" />
    <link href="./App_Obout/HTMLEditor/CSS/EditorStyles.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            font-family: Arial,helvetica,sans-serif;
            font-size: 10pt;
        }
        .buttonspace
        {
            margin-right: 0px;
        }
        .buttongroup
        {
            margin-left:14px;
        }
        a, img
        {
        border:none;
        }
    </style>

    <script language="javascript" type="text/javascript" src="JavaScript/Maskdiv.js"></script>

    <script language="javascript" type="text/javascript">

        function Popup() {
            var width = 1024;
            var height = 640;
            var left = parseInt((screen.availWidth / 2) - (width / 2));
            var top = parseInt((screen.availHeight / 2) - (height / 2));
            var sURL = "http://2ndstage.rocket21.com/workspaces/child#child=tab1";
            var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=yes,scrollbars=yes,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
            //myWindow = window.open("http://2ndstage.rocket21.com/workspaces/child#child=tab1", "subWind", windowFeatures);
            //myWindow.focus();
            //return false;
            //window.showModalDialog(sURL, "subWind", windowFeatures);            
        }



        function openPopUp() {
            document.forms[0].action = "Send.aspx";
            document.forms[0].method = "post";
            document.forms[0].__VIEWSTATE.name = 'NOVIEWSTATE';
            document.forms[0].submit;
        }
        function PreviewMsg() {

            var width = 800;
            var height = 600;
            var left = parseInt((screen.availWidth / 2) - (width / 2));
            var top = parseInt((screen.availHeight / 2) - (height / 2));
            var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=yes,scrollbars=yes,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
            new_window = window.open('', 'preview', windowFeatures);
            document.forms[0].target = 'preview';
            document.forms[0].action = "SendAjax.aspx";
            document.forms[0].__VIEWSTATE.name = 'NOVIEWSTATE';
            document.forms[0].submit;
            new_window.focus();
        }
        function clearSubject() {
            if (document.forms[0].txtSubject.value == 'Enter Text...') document.forms[0].txtSubject.value = '';
        }
        function clearMsg() {
            if (document.forms[0].txtMsg.value == 'Enter Text...') document.forms[0].txtMsg.value = '';
        }
        function PreviewMsg1() {
            window.showModalDialog("preview.aspx", "Dialog", "dialogWidth:800px;dialogHeight:600px;");
            return false;
        }
        function clearConfirm() {
            var ans;
            ans = confirm("Clear entire Recipient List?");
            if (ans == true)
                return true;
            else
                return false;
        }
        function OpenSL() {
            var sURL = "Concierge.aspx#/Concierge_PivotViewerPage";
            var sName = "slPopup";
            var sFeatures = "top=10,left=100,height=800,width=1200,scrollbars=yes,resizable=yes";
            window.open(sURL, sName, sFeatures, true);
            return false;
        }
        function UploadPopup() {
            var sName = "ImgPopup";
            var width = 400;
            var height = 230;
            var left = parseInt((screen.availWidth / 2) - (width / 2));
            var top = parseInt((screen.availHeight / 2) - (height / 2));
            var sURL = "/ImageUpload.aspx";
            var sFeatures = "width=" + width + ",height=" + height + ",status,resizable=yes,scrollbars=yes,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
            window.open(sURL, sName, sFeatures, true);
            return false;
        }
    </script>

</head>
<body>

    <script language="javascript" type="text/javascript">
        function ParaParse(e) {
            var opener = "";
            var closer = "";
            var pOpen = e.match(/^<p>/);
            var pClose = e.match(/<\/p>$/);
            var rExp = /<br\s?\/>[\r\n]+\s*(<br\s?\/>[\r\n]+){1,2}/gi;
            var rRepl = "</p><p>";
            if (!(e == "")) {
                if (!(pOpen)) {
                    opener = "<p>"
                }
                if (!(pClose)) {
                    closer = "</p>"
                }
            }
            return opener + e.replace(rExp, rRepl) + closer;
        }

        function SendMails() {
            var inside = $find("<%=Editor.ClientID%>").get_content();
            var content = ParaParse(inside);
            document.forms[0].txtMsg.value = content;
            //var content = document.forms[0].Editor.value;
            if (document.forms[0].hidUsers.value == "") { alert("Please select atleast one user"); return false; }
            else if (document.forms[0].txtSubject.value == "" || document.forms[0].txtSubject.value == "Enter Text...")
            { alert("Please enter the subject"); document.forms[0].txtSubject.focus(); return false; }
            else if (content == "")
            { alert("Please enter the Message"); document.forms[0].Editor.focus(); return false; }
            else {

                return true;
                //var width = 800;
                //var height = 600;
                //var left = parseInt((screen.availWidth / 2) - (width / 2));
                //var top = parseInt((screen.availHeight / 2) - (height / 2));
                //var left = screen.availWidth;
                //var top = 0;
                //var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=yes,scrollbars=yes,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
                //new_window = window.open('', 'send', windowFeatures);
                //document.forms[0].txtMsg.value = content;
                //document.forms[0].target = 'send';
                //document.forms[0].action = "Send.aspx";
                //document.forms[0].__VIEWSTATE.name = 'NOVIEWSTATE';
                //document.forms[0].submit;
                //new_window.focus();
            }
        }

        function Preview() {
            var inside = $find("<%=Editor.ClientID%>").get_content();
            var content = ParaParse(inside);
            if (document.forms[0].txtSubject.value == "" || document.forms[0].txtSubject.value == "Enter Text...")
            { alert("Please enter the subject"); document.forms[0].txtSubject.focus(); return false; }
            else if (content == "")
            { alert("Please enter the Message"); document.forms[0].Editor.focus(); return false; }
            else {
                return true;
                //var width = 800;
                //var height = 600;
                //var left = parseInt((screen.availWidth / 2) - (width / 2));
                //var top = parseInt((screen.availHeight / 2) - (height / 2));
                //var left = screen.availWidth;
                //var top = 0;
                //var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=yes,scrollbars=yes,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
                //new_window = window.open('', 'preview', windowFeatures);
                //document.forms[0].txtMsg.value = content;
                //document.forms[0].target = 'preview';
                //document.forms[0].action = "SendAjax.aspx";
                //document.forms[0].__VIEWSTATE.name = 'NOVIEWSTATE';
                //document.forms[0].submit;
                //document.forms[0].NOVIEWSTATE.name = '__VIEWSTATE';
                //new_window.focus();
            }
        }

        function SaveDraft(id) {

            var inside = $find("<%=Editor.ClientID%>").get_content();
            var content = ParaParse(inside);
            //alert(document.forms[0].txtDraftTitle.value);
            if (id == 0) { document.forms[0].DraftID.value = 0; }
            //alert ('Replaced content is:' + content);
            //var content = document.forms[0].Editor.value;
            if (document.forms[0].hidUsers.value == "") { alert("Please select atleast one user"); return false; }
            else if (document.forms[0].txtSubject.value == "" || document.forms[0].txtSubject.value == "Enter Text...")
            { alert("Please enter the subject"); document.forms[0].txtSubject.focus(); return false; }
            else if (content == "")
            { alert("Please enter the Message"); document.forms[0].Editor.focus(); return false; }
            else if (document.forms[0].txtDraftTitle.value == "")
            { alert("Please enter the Draft Title"); document.forms[0].txtDraftTitle.focus(); return false; }
            else {
                document.forms[0].txtMsg.value = content;
                document.forms[0].action = "SaveDraft.aspx";
                document.forms[0].method = "post";
                document.forms[0].__VIEWSTATE.name = 'NOVIEWSTATE';
                document.forms[0].submit;
                //window.open('Send.aspx', 'send', 'height=300,width=400,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=no,status=no');
                return true;
            }
        }

    </script>

    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <div style="border: solid 1px green; width: 1000px; height: 805px; background-color: #FFFBD6;
        margin: 0 auto;">
        <div>
            <asp:HyperLink ID="hypBack" runat="server" NavigateUrl="Default.aspx">Back</asp:HyperLink>
        </div>
        <div style="padding: 5px 1px 5px 5px; background-color: #990000; font-weight: bold;
            color: White; height: 20px; text-align: center;">
            Rocket21 Concierge Mailing System</div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="border: solid 0px green; padding: 10px 1px 1px 10px; width: 450px; float: left;">
                    <table border="0">
                        <tr>
                            <td colspan="2">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                    <ProgressTemplate>
                                        <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; text-align: center;">
                                            <img src="./images/Refresh_animated.gif" style="padding-top: 250px;" alt="processing" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                    </table>
                    <div style="padding: 5px 1px 5px 5px; background-color: #990000; font-weight: bold;
                        color: White; display: none">
                        1.Select Interests
                        <asp:CheckBoxList ID="chkInterests" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem id="optPE" runat="server" Selected="True" Value="PE" />
                            <asp:ListItem id="optGroup" runat="server" Selected="True" Value="Groups" />
                            <asp:ListItem id="optSpecial" runat="server" Selected="True" Value="Special" />
                            <asp:ListItem Selected="True">Demographics</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <span style="font-weight: bold;">Associations (1 or more)</span><br />
                                    <asp:ListBox ID="ListGroups" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="60px" DataSourceID="SDSGroupList" DataTextField="Group_Name" DataValueField="Group_Id">
                                    </asp:ListBox>
                                </td>
                                <td valign="middle" align="center" style="width: 30px">
                                    <asp:Button ID="btnAddGroup" runat="server" Text=">" Width="30px" /><br />
                                    <asp:Button ID="btnRemoveGroup" runat="server" Text="<" Width="30px" />
                                    <br />
                                </td>
                                <td>
                                    <span style="font-weight: bold;">MEMBERS OF</span><br />
                                    <asp:ListBox ID="ListGroupsNew" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="60px"></asp:ListBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-weight: bold;">Custom Groups (1 or more)</span><br />
                                    <asp:ListBox ID="ListCustomGroups" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="60px" DataSourceID="SDSCustomGroupList" DataTextField="Group_Name" DataValueField="Group_Id">
                                    </asp:ListBox>
                                </td>
                                <td valign="middle" align="center" style="width: 30px">
                                    <asp:Button ID="btnAddGroupCustom" runat="server" Text=">" Width="30px" /><br />
                                    <asp:Button ID="btnRemoveGroupCustom" runat="server" Text="<" Width="30px" />
                                    <br />
                                </td>
                                <td>
                                    <span style="font-weight: bold;">MEMBERS OF</span><br />
                                    <asp:ListBox ID="ListCustomGroupsNew" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="60px"></asp:ListBox>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <span style="font-weight: bold;">Categories (1 or more)</span><br />
                                    <asp:ListBox ID="ListCategory" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="60px" DataSourceID="SDSCategoryList" DataTextField="Category" DataValueField="CategoryID">
                                    </asp:ListBox>
                                </td>
                                <td valign="middle" align="center" style="width: 30px">
                                    <asp:Button ID="btnAddCategory" runat="server" Text=">" Width="30px" /><br />
                                    <asp:Button ID="btnRemoveCategory" runat="server" Text="<" Width="30px" />
                                    <br />
                                </td>
                                <td>
                                    <span style="font-weight: bold;">MEMBERS OF</span><br />
                                    <asp:ListBox ID="ListCategoryNew" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="60px"></asp:ListBox>
                                    <br />
                                    <asp:ListBox ID="ListCategoryInterest" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="60px" DataSourceID="SDSInterestList" DataTextField="InterestName" DataValueField="InterestID"
                                        Visible="False"></asp:ListBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-weight: bold;">PEs (1 or more)</span><br />
                                    <asp:ListBox ID="ListInterests" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="150px"></asp:ListBox>
                                </td>
                                <td valign="middle" align="center" style="width: 30px">
                                    <asp:Button ID="btnAddInterest" runat="server" Text=">" Width="30px" /><br />
                                    <asp:Button ID="btnRemoveInterest" runat="server" Text="<" Width="30px" />
                                    <br />
                                </td>
                                <td>
                                    <span style="font-weight: bold;">MEMBERS OF</span><br />
                                    <asp:ListBox ID="ListInterestsNew" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="150px"></asp:ListBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br clear="all" />
                    <div style="padding: 5px 1px 5px 5px; background-color: #990000; font-weight: bold;
                        color: White;">
                        2.Filter recipients by:
                        <asp:CheckBoxList ID="chkUsers" runat="server" RepeatDirection="Horizontal" AutoPostBack="true">
                            <asp:ListItem id="option1" runat="server" Selected="True" Value="B3" />
                            <asp:ListItem id="option2" runat="server" Selected="True" Value="T10" />
                            <asp:ListItem id="option3" runat="server" Selected="True" Value="pGPS" />
                            <asp:ListItem id="option4" runat="server" Selected="True" Value="All" />
                        </asp:CheckBoxList>
                    </div>
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <span style="font-weight: bold;">Users</span>
                                    <br />
                                    <asp:RadioButtonList ID="rdbProfileType" runat="server" AppendDataBoundItems="True"
                                        AutoPostBack="True" Font-Size="Small" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="A">All</asp:ListItem>
                                        <asp:ListItem Value="C">Child</asp:ListItem>
                                        <asp:ListItem Value="P">Pro</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:ListBox ID="ListUsers" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="150px" DataSourceID="ObjectDataSource1" DataTextField="name" DataValueField="id">
                                    </asp:ListBox>
                                </td>
                                <td valign="middle" align="center" style="width: 30px">
                                    <asp:Button ID="btnAddUsers" runat="server" Text=">" Width="30px" /><br />
                                    <asp:Button ID="btnRemoveUsers" runat="server" Text="<" Width="30px" />
                                    <asp:ImageButton ID="imgBtnClear" runat="server" ImageUrl="~/images/clear_list01.jpg"
                                        OnClientClick="return clearConfirm();" ToolTip="Clear Recipient List" />
                                </td>
                                <td>
                                    <span style="font-weight: bold;">Recipient List:</span><asp:Label ID="lblCount" runat="server"
                                        Text=""></asp:Label>
                                    <br />
                                    <asp:Label ID="lblStatus" runat="server" ForeColor="#0033CC" BackColor="#FFFF66"></asp:Label>
                                    <br />
                                    <asp:ListBox ID="ListUsersNew" runat="server" SelectionMode="Multiple" Width="200px"
                                        Height="150px"></asp:ListBox>
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hidUsers" runat="server" />
                        <asp:HiddenField ID="hidMembers" runat="server" />
                        <asp:HiddenField ID="hidGroups" runat="server" />
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsConciergeTableAdapters.sp_users_profile_getTableAdapter">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="rdbProfileType" DbType="Object" DefaultValue="A"
                                    Name="profile_type" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:SqlDataSource ID="SDSGroupList" runat="server" ConnectionString="<%$ ConnectionStrings:Rocket21ConnectionString %>"
                            SelectCommand="SELECT [Group_Id], [Group_Name] FROM [vw_Concierge_Group_Count]">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SDSCustomGroupUsers" runat="server" ConnectionString="<%$ ConnectionStrings:Rocket21ConnectionString %>"
                            SelectCommand="sp_Concierge_CustomGroup_Members" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="group_id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SDSGroupUsers" runat="server" ConnectionString="<%$ ConnectionStrings:Rocket21ConnectionString %>"
                            SelectCommand="sp_Concierge_Group_Members" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="group_id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SDSCustomGroupList" runat="server" ConnectionString="<%$ ConnectionStrings:Rocket21ConnectionString %>"
                            SelectCommand="SELECT [Group_Id], [Group_Name] FROM [vw_Concierge_CustomGroup_Count]">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SDSCategoryList" runat="server" ConnectionString="<%$ ConnectionStrings:Rocket21ConnectionString %>"
                            SelectCommand="SELECT CategoryID, Category FROM vw_Category_Stats"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SDSInterestList" runat="server" ConnectionString="<%$ ConnectionStrings:Rocket21ConnectionString %>"
                            SelectCommand="SELECT InterestID,
       InterestName
FROM vw_Category_Interest
WHERE CategoryID = @CategoryID">
                            <SelectParameters>
                                <asp:Parameter Name="CategoryID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div style="padding: 10px 1px 1px 1px; width: 500px; float: right;">
            <div style="padding: 5px 1px 5px 5px; background-color: #990000; font-weight: bold;
                color: White; height: 20px;">
                3.Compose Message</div>
            <div>
                <table width="490px">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                         <td>
                        </td>
                         <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <span style="font-weight: bold;">Load from Template:</span>
                            <asp:DropDownList ID="ddnTemplate" runat="server" AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight: bold;">TYPE/ICON</span><br />
                            <asp:ListBox ID="lstType" runat="server" SelectionMode="Single" Width="100px" Height="50px"
                                AutoPostBack="true"></asp:ListBox>
                        </td>
                        <td>
                        </td>
                        <td>
                            <span style="font-weight: bold;">WRAPPER</span><br />
                            <asp:ListBox ID="lstWrapper" runat="server" SelectionMode="Single" Width="300px"
                                Height="50px" AutoPostBack="true"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" valign="top">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtIconURL" runat="server" BorderWidth="1" Width="370px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Image ID="imgIcon" Width="25" Height="25" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:TextBox ID="txtWrapper" runat="server" BorderWidth="1" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <span style="font-weight: bold;">SUBJECT:</span><br />
                            <asp:TextBox ID="txtSubject" runat="server" BorderWidth="1" Width="400px" Text="Enter Text..."></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <span style="font-weight: bold;">MESSAGE:</span>
                            <asp:Button ID="btnImgUpload" runat="server" Text="Upload Image" OnClientClick="return UploadPopup();" />
                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <%--                                    <custom:MsgEditor runat="server" Id="Editor"  Height="200px" 
                                        InitialCleanUp="True" Font-Names="Arial,Helvetica,Sans-Serif" 
                                        Font-Size="6pt" DesignPanelCssPath="~/css/EditorFontOverrides.css" />--%>
                            <obout:Editor ID="Editor" runat="server" Height="250px" Width="100%" ShowQuickFormatting="True">
                                <QuickFormatting Width="75px" />
                                <EditPanel InitialCleanUp="False" OnClientLoaded="" DesignPanelCssPath="~/App_Obout/HTMLEditor/CSS/EditorFontOverrides.css">
                                </EditPanel>
                                <TopToolbar Appearance="Custom">
                                    <AddButtons>
                                        <obout:Undo ID="Undo1" runat="server" />
                                        <obout:Redo ID="Redo1" runat="server" />
                                        <obout:HorizontalSeparator ID="HorizontalSeparator1" runat="server" />
                                        <obout:Bold ID="Bold1" runat="server" />
                                        <obout:Italic ID="Italic1" runat="server" />
                                        <obout:Underline ID="Underline1" runat="server" />
                                        <obout:HorizontalSeparator ID="HorizontalSeparator2" runat="server" />
                                        <obout:FixedForeColor ID="FixedForeColorCyan" runat="server" DefaultColor="#00a89d"
                                            Style="padding: 1px;">
                                        </obout:FixedForeColor>
                                        <obout:FixedForeColor ID="FixedForeColorNormal" runat="server" DefaultColor="#444444"
                                            Style="padding: 1px;">
                                        </obout:FixedForeColor>
                                        <obout:HorizontalSeparator ID="HorizontalSeparator7" runat="server" />
                                        <obout:ForeColorGroup ID="ForeColorGroup1" runat="server">
                                        </obout:ForeColorGroup>
                                        <obout:HorizontalSeparator ID="HorizontalSeparator3" runat="server" />
                                        <obout:InsertImage ID="InsertImage" runat="server" />
                                        <obout:InsertLink ID="InsertLink1" runat="server" />
                                        <obout:RemoveLink ID="RemoveLink1" runat="server" />
                                        <obout:HorizontalSeparator ID="HorizontalSeparator6" runat="server" />
                                        <obout:RemoveStyles ID="RemoveStyles1" runat="server" />
                                        <obout:HorizontalSeparator ID="HorizontalSeparator4" runat="server" />
                                        <obout:SelectAll ID="SelectAll1" runat="server" />
                                        <obout:HorizontalSeparator ID="HorizontalSeparator5" runat="server" />
                                        <obout:SpellCheck ID="SpellCheck1" runat="server" />
                                        <obout:Paragraph ID="Paragraph1" runat="server" />
                                    </AddButtons>
                                </TopToolbar>
                            </obout:Editor>
                            <%--<HTMLEditor:Editor runat="server" Id="Editor"  Height="200px" />--%>
                            <%--<asp:TextBox ID="Editor" runat="server" BorderWidth="1" Width="400px" 
                                                    TextMode="MultiLine" Rows="6"></asp:TextBox>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table width="100%">
                                <tr valign="top">
                                    <td>
                                        <span style="font-weight: bold;">FLOATBOX CODE:</span>
                                    </td>
                                </tr>
                                <tr valign="top">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" width="385">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtMedia" runat="server" BorderWidth="1" Width="100%" TextMode="MultiLine"
                                                        Rows="4"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <asp:Panel ID="pnlDTitle" runat="server">
                                                
                                                <tr>
                                                    <td>
                                                        
                                                        <br /><span style="font-weight: bold;">Draft Title:</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtDraftTitle" runat="server" BorderWidth="1" Width="100%" TextMode="singleline"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </asp:Panel>
                                            
                                            <tr>
                                                <td>
                                                <br />
                                                    <asp:Button ID="btnInsertHTML" runat="server" Text="Insert" Width="50px" CssClass="buttonspace"
                                                        ToolTip="Insert Content from Catalog" />
                                                    <asp:Button ID="btnSilverLight" runat="server" Text="Search" OnClientClick="return OpenSL();"
                                                        Width="60px" CssClass="buttonspace" ToolTip="Search for Content" />
                                                    <asp:Button ID="btnClear" runat="server" Text="Clear" Width="50px" CssClass="buttonspace"
                                                        ToolTip="Clear Content" />
                                                    <asp:Button ID="btnPreview" runat="server" Text="Preview" 
                                                        CssClass="buttonspace" Width="75px" />
                                                    <asp:Button ID="btnSaveDraft" runat="server" Text="Save Draft" Width="75px" 
                                                        CssClass="buttonspace" />
                                                
                                                    <asp:Button ID="btnSend" runat="server" Text="Send" Width="50px" />
                                                </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>
                                
                                <asp:Panel ID="pnlUpdate" runat="server" Visible="false">
                                    <tr>
                                        <td>
                                            <table style="border: solid 1px green; background: yellow;">
                                                <tr>
                                                    <td>
                                                        <span style="font-weight: normal;">Updated By</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtUpdatedBy" runat="server" BorderWidth="1" Width="200px" TextMode="SingleLine"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span style="font-weight: normal;">Updated Notes</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtUpdatedNotes" runat="server" BorderWidth="1" Width="200px" TextMode="MultiLine"
                                                            Rows="4"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="right">
                                                        <asp:Button ID="btnUpdateDraft" runat="server" Text="Update Draft" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </asp:Panel>
                            </table>
                        </td>
                        <td align="right">
                            <asp:Literal ID="litPreview" runat="server"></asp:Literal>
                            <asp:HiddenField ID="txtMsg" runat="server" />
                            <asp:HiddenField ID="CPID" runat="server" />
                            <asp:HiddenField ID="MediaType" runat="server" />
                            <asp:HiddenField ID="DraftID" runat="server" />
                        </td>
                        </tr> </table> </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" CancelControlID="btnCancel"
        TargetControlID="btnInsertHTML" PopupControlID="Panel1" PopupDragHandleControlID="PopupHeader"
        Drag="true" BackgroundCssClass="ModalPopupBG">
    </ajaxToolkit:ModalPopupExtender>
    <asp:Panel ID="Panel1" Style="display: none" runat="server">
        <div class="Popup">
            <div class="PopupHeader" id="PopupHeader">
                Select HTML Tags</div>
            <div id="div1" style="width: 1200px; height: 500px; overflow: scroll;" runat="server">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow"
                    BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="AutoID" DataSourceID="ODSTag"
                    Font-Names="Arial" Font-Size="X-Small" ForeColor="Black">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="AutoID" HeaderText="ID" SortExpression="AutoID" />
                        <asp:TemplateField HeaderText="HTMLEmbedTag" SortExpression="HTMLEmbedTag">
                            <ItemTemplate>
                                <asp:Literal ID="litPreview1" Text='<%#Eval("HTMLEmbedTag")%>' runat="server"></asp:Literal>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ModifiedOn" HeaderText="Modified On" SortExpression="ModifiedOn"
                            DataFormatString="{0:d}" />
                        <asp:BoundField DataField="SubmittedBy" HeaderText="Submitted By" SortExpression="SubmittedBy" />
                        <asp:BoundField DataField="MediaType" HeaderText="Type" SortExpression="MediaType" />
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                        <asp:BoundField DataField="Caption" HeaderText="Caption" SortExpression="Caption" />
                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                        <asp:BoundField DataField="AssociatedPEName" HeaderText="PE" SortExpression="AssociatedPEName" />
                        <asp:BoundField DataField="Interest_Category" HeaderText="Category" SortExpression="Interest_Category" />
                        <asp:BoundField DataField="Interest_Group" HeaderText="Group" SortExpression="Interest_Group" />
                        <asp:BoundField DataField="Tags" HeaderText="Tags" SortExpression="Tags" />
                        <asp:BoundField DataField="Keywords" HeaderText="Keywords" SortExpression="Keywords" />
                        <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                    </Columns>
                    <FooterStyle BackColor="Tan" />
                    <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ODSTag" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsConciergeTableAdapters.sp_ContentPicket_MediaGroup_getTableAdapter"
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="AutoID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="AutoID" Type="Int32" />
                        <asp:Parameter Name="WebSiteURL" Type="String" />
                        <asp:Parameter Name="HTMLEmbedTag" Type="String" />
                        <asp:Parameter Name="KeyWords" Type="String" />
                        <asp:Parameter Name="AssociatedPE" Type="String" />
                        <asp:Parameter Name="InternalNotes" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:Parameter Name="DateFrom" Type="DateTime" />
                        <asp:Parameter Name="DateTo" Type="DateTime" />
                        <asp:Parameter Name="SubmittedBy" Type="String" />
                        <asp:Parameter Name="KeyWords" Type="String" />
                        <asp:Parameter Name="AccociatedPE" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="SubmittedBy" Type="String" />
                        <asp:Parameter Name="WebSiteURL" Type="String" />
                        <asp:Parameter Name="HTMLEmbedTag" Type="String" />
                        <asp:Parameter Name="KeyWords" Type="String" />
                        <asp:Parameter Name="AssociatedPE" Type="String" />
                        <asp:Parameter Name="InternalNotes" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </div>
            <div class="Controls">
                <input id="btnCancel" type="button" value="Cancel" />
            </div>
        </div>
    </asp:Panel>
    </form>
</body>
</html>
