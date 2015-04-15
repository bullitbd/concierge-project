<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Copy of Catalog_Edit_JG.aspx.vb" Inherits="Catalog_Edit_JG" ValidateRequest="false" %>


<%@ Register Assembly="obout_ComboBox" Namespace="Obout.ComboBox" TagPrefix="cc2" %>
<%@ Register Assembly="obout_Interface" Namespace="Obout.Interface" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link type="text/css" rel="stylesheet" href="http://r21concierge.s3.amazonaws.com/floatbox_427/floatbox.css" />

    <script type="text/javascript" src="http://r21concierge.s3.amazonaws.com/floatbox_427/floatbox.js"></script>

    <script type="text/javascript" src="http://r21concierge.s3.amazonaws.com/floatbox_427/options.js"></script>

    <link type="text/css" rel="stylesheet" href="http://r21concierge.s3.amazonaws.com/css/concierge.css" />
    <link href="./css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="./css/concierge_edit.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="./css/Catalog_New.css" />
    <title>Rocket21 Concierge Add Media</title>

    <script type="text/javascript">

        function pageLoad(sender, args) {
            if (args.get_isPartialLoad()) {
                fb.activateElements();
            }
        }

        function showCustom() {

            // document.forms[0].pnlShowMore.visibility = "visible";
            document.getElementById("pnlShowCustom").style.visibility = "visible";
            return false;
        }
        function showLess() {
            document.getElementById("pnlShowMore").style.visibility = "hidden";
            document.getElementById("pnlShowCustom").style.visibility = "hidden";
            return false;
        }
        function goBack() {
            if (confirm("Are you sure you want to leave this page? All data will be lost.") == true)
                return true;
            else
                return false;
        }

        function ValidateForm() {
            if (document.forms[0].cboMedia.value == "") {
                alert("Please select a Media Type");
                return false;
            }
        }
        function ValidateForm1() {
            if (document.forms[0].cboMedia.value == "") {
                alert("Please select a Media Type");
                return false;
            }
            if (document.forms[0].cboSubmitted.value == "") {
                alert("Please select a Submitter.");
                return false;
            }
            if (document.forms[0].txtTitle.value == "") {
                alert("Please select a Title.");
                return false;
            }
            if (document.forms[0].txtDescription.value == "") {
                alert("Please Enter a description");
                return false;
            }
            if (document.forms[0].txtContent.value == "") {
                alert("Please Enter Embed Code or URL");
                return false;
            }
            if (document.forms[0].txtTitle.value == "") {
                alert("Please Enter a Title");
                return false;
            }

        }
        function okCustom() {
            document.getElementById("pnlShowCustom").style.visibility = "hidden";
            return false;
        }
        function enableSave() {
            btnSave.enable();
            btnMsg.enable();
            return false;
        }

        fbPageOptions = {
            afterBoxEnd: enableSave
        }
            
    </script>

    <style type="text/css">
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <%--//Topmost panel - item can be posted to catalog and/or Send Message --%>
    <asp:Panel ID="pnlMain" runat="server" Style="height: 690px;" class="panelDiv">
        <table width="100%">
            <tr>
                <td align="center">
                    <asp:Label ID="lblStatus" runat="server" ForeColor="#cc3300" Font-Bold="true"></asp:Label>
                </td>
            </tr>
        </table>
        <span class="panelTitle">Concierge Catalog - Add Media</span>
        <div class="topWide">
            <table width="100%">
                <tr>
                    <td colspan="5" class="boxTitle">
                            <cc1:OboutCheckBox ID="chkTestOnly" runat="server" 
                            FolderStyle="css/oboutSuite/Interface/styles/plain/OboutCheckBox" 
                            TextAlign="left">
                            </cc1:OboutCheckBox><span>&nbsp;Test Only </span>
                    </td>
                    
                </tr>
                <tr>
                    <td class="boxTitle">
                        Media Type <span class="reqdField">*</span>
                    </td>
                    <td class="boxTitle">
                        Submitter <span class="reqdField">*</span>
                    </td>
                    <td class="boxTitle">
                        Owner / Campaign <span class="reqdField">*</span>
                    </td>
                    <td class="boxTitle">
                        Type
                    </td>
                    <td class="boxTitle">
                        Modify Size To:
                    </td>
                </tr>
                <tr>
                    <td>
                        <cc2:ComboBox ID="cboMedia" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="100px" MenuWidth="100px" TabIndex="2">
                            <cc2:ComboBoxItem ID="cboMedia1" runat="server" Text="Video" Value="Video" />
                            <cc2:ComboBoxItem ID="cboMedia2" runat="server" Text="R21 Video" Value="R21 Video" />
                            <cc2:ComboBoxItem ID="cboMedia3" runat="server" Text="Image" Value="Image" />
                        </cc2:ComboBox>
                        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:Rocket21ConnectionString %>" 
                            SelectCommand="SELECT [type] FROM [Concierge_MediaType]">
                        </asp:SqlDataSource>--%>
                        <%--<cc1:OboutDropDownList ID="ddnMedia" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutDropDownList"
                            >
                        </cc1:OboutDropDownList>--%>
                    </td>
                    <td>
                        <cc2:ComboBox ID="cboSubmitted" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="100px" MenuWidth="100px" TabIndex="3">
                            <cc2:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="logged user" Value="logged user" />
                            <cc2:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="admin" Value="admin" />
                            <cc2:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="alleng" Value="alleng" />
                            <cc2:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="bobd" Value="bobd" />
                        </cc2:ComboBox>
                    </td>
                    <td>
                        <cc2:ComboBox ID="cboOwner" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="200px" MenuWidth="200px" TabIndex="4">
                        </cc2:ComboBox>
                        <cc2:ComboBox ID="cboCampaign" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="200" Height="150" >
                        </cc2:ComboBox>
                    </td>
                    <td>
                        <cc1:OboutTextBox ID="txtOwnerType" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="80px" Text="SPONSOR" Enabled="False"></cc1:OboutTextBox>
                    </td>
                    <td>
                        <%--<cc1:OboutDropDownList ID="ddnAddToGroup" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutDropDownList"
                            Width="80px">
                            <asp:ListItem> </asp:ListItem>
                        </cc1:OboutDropDownList>--%>
                        <cc1:OboutTextBox ID="txtPct" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="40px" TabIndex="5"></cc1:OboutTextBox>&nbsp;% of Original
                    </td>
                </tr>
            </table>
        </div>
        <div class="topLeft">
            <table width="100%">
                <tr class="boxTitle">
                    <td>
                        R21 Categories
                    </td>
                </tr>
                <tr>
                    <td class="boxRow">
                        <cc2:ComboBox ID="lstCategory" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="90%" SelectionMode="Multiple" MultiSelectionSeparator=", " 
                            EnableVirtualScrolling="True" TabIndex="11"
                            OpenOnFocus="False">
                        </cc2:ComboBox>
                    </td>
                </tr>
                <tr class="boxTitle">
                    <td>
                        Suggested PEs
                    </td>
                </tr>
                <tr>
                    <td class="boxRow">
                        <cc2:ComboBox ID="ddlAssociatedPE" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="90%" SelectionMode="Multiple"  TabIndex="13" OpenOnFocus="False">
                        </cc2:ComboBox>
                    </td>
                    </tr>
                <tr class="boxTitle">
                    <td>
                        Associations
                    </td>
                </tr>
                <tr>
                    <td class="boxRow">
                        <cc2:ComboBox ID="ddnAssociations" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="90%" SelectionMode="Multiple"  TabIndex="13" OpenOnFocus="False">
                        </cc2:ComboBox>
                    </td>
                </tr>
                <tr class="boxTitle">
                    <td>
                        Groups
                    </td>
                </tr>
                <tr>
                    <td class="boxRow">
                        <cc2:ComboBox ID="listGroups" runat="server" Width="90%" FolderStyle="css/oboutSuite/ComboBox/styles/plain"
                            SelectionMode="Multiple" TabIndex="14" OpenOnFocus="False">
                            <cc2:ComboBoxItem ID="ComboBox4Item1" runat="server" Text="someword" Value="1" />
                            <cc2:ComboBoxItem ID="ComboBox4Item2" runat="server" Text="another" Value="2" />
                            <cc2:ComboBoxItem ID="ComboBox4Item3" runat="server" Text="haberdasher" Value="3" />
                        </cc2:ComboBox>
                    </td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td class="boxTitleNoPad" style="width: 50px">
                        Link
                    </td>
                    <td style="float: left;">
                        <cc1:OboutRadioButton ID="rbnLinkThumb" runat="server" Checked="True" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutRadioButton"
                            GroupName="rbgLinkStyle" Text="Thumb">
                        </cc1:OboutRadioButton>&nbsp;&nbsp;&nbsp;
                        <cc1:OboutRadioButton ID="rbnLinkButton" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutRadioButton"
                            GroupName="rbgLinkStyle" Text="Button">
                        </cc1:OboutRadioButton>&nbsp;&nbsp;&nbsp;
                        <cc1:OboutRadioButton ID="rbnLinkText" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutRadioButton"
                            GroupName="rbgLinkStyle" Text="Text">
                        </cc1:OboutRadioButton>
                    </td>
                </tr>
                <%--These controls are displayed/hidden via their surrounding divs --%>
                <tr>
                    <td colspan="2">
                        <div id="linkInfoCbo" style="display: none;">
                            <cc2:ComboBox ID="cboLinkInfo" runat="server" FolderStyle="css/oboutSuite/ComboBox/styles/plain"
                                Width="90%" TabIndex="0" OpenOnFocus="False" Enabled="true" ShowSelectedImage="True"
                                ToolTip="Select Button to be used for content link">
                            </cc2:ComboBox>
                        </div>
                        <div id="linkInfoTbo">
                            <cc1:OboutTextBox ID="txtLinkInfo" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                                Width="90%" TabIndex="15" Enabled="True" Visible="True">
                                
                            </cc1:OboutTextBox>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="topRight">
            <table width="100%">
                <tr class="boxTitle">
                    <td>
                        Title <span class="reqdField">*</span>
                    </td>
                    <%--<td class="boxTitle"><span style="float:right;">Alt/Hover Different? 
                            <cc1:OboutCheckBox ID="chkDiffAlt" runat="server" 
                            FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox" 
                            TextAlign="Right">
                            </cc1:OboutCheckBox></span>
                    </td>--%>
                </tr>
                <tr>
                    <td>
                        <cc1:OboutTextBox ID="txtTitle" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            runat="server" ToolTip="Appears at the Top Center  of the Media Frame." Width="100%"
                            Rows="2" TabIndex="6"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr class="boxTitle">
                    <td>
                        2nd Caption
                    </td>
                </tr>
                <tr>
                    <td>
                        <cc1:OboutTextBox ID="txtCaption" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            runat="server" ToolTip="Appears at the Top Center  of the Media Frame." Width="100%"
                            Rows="2" TabIndex="7"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr class="boxTitle">
                    <td>
                        Keywords
                    </td>
                </tr>
                <tr>
                    <td>
                        <cc1:OboutTextBox ID="ddlKeywords" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            runat="server" ToolTip="Separate Keywords with Commas" Width="100%" TabIndex="8"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr class="boxTitle">
                    <td>
                        Description <span class="reqdField">*</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <cc1:OboutTextBox ID="txtDescription" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            runat="server" TextMode="MultiLine" ToolTip="Please be Descriptive" Width="100%"
                            TabIndex="9"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="boxTitleNoPad">
                        Notes
                    </td>
                </tr>
                <tr>
                    <td>
                        <cc1:OboutTextBox ID="txtNotes" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="100%" TabIndex="10"></cc1:OboutTextBox>
                    </td>
                </tr>
                <%--<tr>
                
                <td class="boxTitleNoPad">
                    Alt &amp; Hover Text</td>
            </tr>
            <tr>
                <td>
                    <cc1:OboutTextBox ID="txtAlt" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                        Width="100%"></cc1:OboutTextBox>
                </td>
            </tr>--%>
            </table>
        </div>
        <div id="centerWide">
            <table width="100%" cellspacing="5px">
                <tr class="boxTitle">
                    <td width="80%">
                        Embed Code <span class="reqdField">*</span>
                    </td>
                    <td style="text-align: center">
                        Content Preview
                    </td>
                </tr>
                <tr>
                    <td width="80%">
                        <cc1:OboutTextBox ID="txtContent" runat="server" Height="9em" TextMode="MultiLine"
                            ToolTip="Place Media Embed Code or Page URL Here." Width="99%" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            TabIndex="1" WatermarkText="Paste Embed or URL Here"></cc1:OboutTextBox>
                    </td>
                    <td style="background: #dddddd; text-align: center;">
                        <asp:Literal ID="litPreview" runat="server"></asp:Literal>
                    </td>
                </tr>
            </table>
        </div>
        <div class="bottomButtons">
            <div class="btnLeftGroup">
                <cc1:OboutButton ID="btnOptions" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="OPTIONS" OnClientClick="return showCustom();" Width="80px" Font-Size="10pt">
                </cc1:OboutButton>
                <%--<input type="button" value="More" id="btnMore"  onclick="showMore();" />--%></div>
            <div class="btnLeftGroup">
                <cc1:OboutButton ID="btnBuild" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="BUILD" OnClientClick="return ValidateForm();" Width="80px" Font-Size="10pt">
                </cc1:OboutButton></div>
            <div class="btnRightGroup">
                <cc1:OboutButton ID="btnModify" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="Save" Width="80px" OnClientClick="return ValidateForm();" Font-Size="10pt">
                </cc1:OboutButton></div>
             <div class="btnRightGroup">
                <cc1:OboutButton ID="btnSaveAs" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="Save As" Width="80px" OnClientClick="return ValidateForm();" Font-Size="10pt">
                </cc1:OboutButton></div>   
        </div>
    </asp:Panel>
    <br />
    <%-- //////Top of ShowCustom Panel///////////////////////////////////////////////////////////--%>
     <asp:Panel ID="pnlShowCustom" runat="server" class="panelDiv3" Style="height: 400px;">
        <span class="panelTitle">Floatbox Option Settings</span>
        <div class="topWide">
            <table class="tableTop">
                <tr>
                    <td width="27px">
                        <cc1:OboutCheckBox ID="chkTip" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutCheckBox"
                            Width="22px" ControlsToEnable="txtTip">
                        </cc1:OboutCheckBox>
                    </td>
                    <td class="boxTitleNoPad">
                        Has Tooltip?
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:OboutTextBox ID="txtTip" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="100%"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr>
                    <td width="27px">
                        <cc1:OboutCheckBox ID="chkInfo" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutCheckBox"
                            Font-Bold="False" Width="22px" ControlsToEnable="txtInfoLink">
                        </cc1:OboutCheckBox>
                    </td>
                    <td class="boxTitleNoPad">
                        Has Info Link?
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:OboutTextBox ID="txtInfoLink" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="100%"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr>
                    <td width="27px">
                        <cc1:OboutCheckBox ID="chkPrint" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutCheckBox"
                            Font-Bold="False" Width="22px" ControlsToEnable="txtPrint">
                        </cc1:OboutCheckBox>
                    </td>
                    <td class="boxTitleNoPad">
                        Can Print?
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:OboutTextBox ID="txtPrint" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="100%"></cc1:OboutTextBox>
                    </td>
                </tr>
                 <tr>
                    <td colspan="2" class="boxTitleNoPad">
                        Website URL
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:OboutTextBox ID="txtWebsite" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="100%"></cc1:OboutTextBox>
                    </td>
                </tr>
                 <tr>
                    <td colspan="2" class="boxTitleNoPad">
                        Media URL
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:OboutTextBox ID="txtURL" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="100%"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="boxTitleNoPad">
                        Thumb URL
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:OboutTextBox ID="txtThumbURL" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="100%"></cc1:OboutTextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <cc1:OboutButton ID="btnCustomOK" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                            Text="OK" Width="60px" OnClientClick="return okCustom();" UseSubmitBehavior="False">
                        </cc1:OboutButton>
                    </td>
                </tr>
            </table>
        </div>
        
    </asp:Panel>
    <div>
        <asp:HiddenField ID="txtFB" runat="server" />
    </div>
    
    </form>
    
</body>
</html>
