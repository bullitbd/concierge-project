<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Catalog_JG.aspx.vb" Inherits="Catalog_JG"
    ValidateRequest="false" %>

<%@ Register Assembly="obout_Flyout2_NET" Namespace="OboutInc.Flyout2" TagPrefix="cc3" %>
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
        function ComboBox1_SelectedIndexChanged(sender, selectedIndex) {
            var sType = '';
            //var currentLogs = '\r\n' + OboutTextBox1.value();
            //OboutTextBox1.value('SelectedIndexChanged was raised - new selected index: ' + selectedIndex + currentLogs);
            //alert(selectedIndex);
            switch (selectedIndex) {
                case 0:
                    sType = 'Partner';
                    break;
                case 1:
                    sType = 'Partner';
                    break;
                case 2:
                    sType = 'Partner';
                    break;
                case 3:
                    sType = 'Partner';
                    break;
                case 4:
                    sType = 'Partner';
                    break;
                case 5:
                    sType = 'Partner';
                    break;
                case 6:
                    sType = 'Partner';
                    break;
                case 7:
                    sType = 'Partner';
                    break;
                case 8:
                    sType = 'Sponsor';
                    break;
                case 9:
                    sType = 'Sponsor';
                    break;
                default:
                    sType = 'Partner';
                    break;
            }
            document.getElementById("txtOwnerType").value = sType;
            return true;
        }
        function linkChkChanged() {
            var linkTextBox = document.getElementById("linkInfoTbo");
            var linkComboBox = document.getElementById("linkInfoCbo");

            switch (true) {
                case document.getElementById("rbnLinkThumb").checked:
                    linkTextBox.style.display = 'block';
                    linkComboBox.style.display = 'none';
                    break;
                case document.getElementById("rbnLinkButton").checked:
                    linkTextBox.style.display = "none";
                    linkComboBox.style.display = 'block';
                    break;
                case document.getElementById("rbnLinkText").checked:
                    linkTextBox.style.display = 'block';
                    linkComboBox.style.display = 'none';
                    break;
            }

            return false;
        }
        function clearBox() {
            txtLinkInfo.value("");
            return false;
        }
        
    </script>

    <style type="text/css">
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <%--//Topmost panel - item can be posted to catalog and/or Send Message --%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <asp:Panel ID="pnlMain" runat="server" Style="height: 690px;" class="panelDiv">
        <asp:HyperLink ID="hypBack" NavigateUrl="~/Default.aspx" runat="server">Back</asp:HyperLink>
        <%--[TODO] Help - Work in process BOB--%>
        <cc3:Flyout ID="Flyout1" runat="server" AttachTo="helpButton" OpenTime="200" PageOpacity="75"
            Opacity="100" Position="ABSOLUTE" Align="RIGHT" PageColor="#333333" 
            RelativeLeft="-460" RelativeTop="-5" FlyingEffect="TOP_RIGHT" 
            DelayTime="600">
            <div style="width: 480px; height:580px; background-color: #ffffff; padding: 20px 10px 10px 10px; border: solid 1px brown;">
                
                <iframe frameborder="0" width="480px" height="560px" src="New_Help.htm"></iframe>
                    
            </div>
        </cc3:Flyout>
        <table width="100%">
            <tr>
                <td align="left">
                    <asp:Label ID="lblStatus" runat="server" ForeColor="#cc3300" Font-Bold="true"></asp:Label>
                </td>
            </tr>
        </table>
        <table width="99%">
            <tr>
                <td width="20%">
                </td>
                <td width="60%">
                    <span class="panelTitle">Concierge Catalog - Add Media</span>
                </td>
                <td width="15%" style="text-align: right; padding-right: 30px;">
                    <div id="helpButton">
                        <img border="0" src="http://concierge.rocket21.com/images/ttqmarksmall.png" alt="Help" /></div>
                </td>
            </tr>
        </table>
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
                        Owner <span class="reqdField">*</span>
                    </td>
                    <td class="boxTitle">
                        Campaign <span class="reqdField">*</span>
                    </td>
                    <td class="boxTitle">
                        Owner Type
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
                            <cc2:ComboBoxItem ID="cboMedia4" runat="server" Text="Document" Value="Document" />
                            <cc2:ComboBoxItem ID="cboMedia5" runat="server" Text="Web Site" Value="Web Site" />
                            <cc2:ComboBoxItem ID="cboMedia6" runat="server" Text="Web Page" Value="Web Page" />
                            <cc2:ComboBoxItem ID="cboMedia7" runat="server" Text="HTML" Value="HTML" />
                        </cc2:ComboBox>
                    </td>
                    <td>
                        <cc2:ComboBox ID="cboSubmitted" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="100px" MenuWidth="100px" TabIndex="3">
                            <cc2:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="logged user" Value="logged user" />
                            <cc2:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="admin" Value="admin" />
                            <cc2:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="alleng" Value="alleng" />
                            <cc2:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="bobd" Value="bobd" />
                            <cc2:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="marshallr" Value="marshallr" />
                            <cc2:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="steves" Value="steves" />
                            <cc2:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="lisal" Value="lisal" />
                            <cc2:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="jodells" Value="jodells" />
                            <cc2:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="rajivg" Value="rajivg" />
                        </cc2:ComboBox>
                    </td>
                    <td>
                        <cc2:ComboBox ID="cboOwner" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="140px" MenuWidth="200px" TabIndex="4" DataSourceID="ODSConciergeMaster"
                            DataTextField="OwnerName" DataValueField="OwnerID" OnSelectedIndexChanged="cboOwner_SelectedIndexChanged" 
                            EmptyText="Select an Owner..." AutoPostBack="True">
                        </cc2:ComboBox>
                        </td>
                        <td>
                        <cc2:ComboBox ID="cboCampaign" runat="server" FolderStyle="./css/oboutSuite/ComboBox/styles/plain"
                            Width="110px"
                            Height="150" DataSourceID="ODSConciergeDetail" DataValueField="CampaignId" DataTextField="CampaignName"
                            EmptyText="Select a campaign..." Enabled="False">
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
                            Width="40px" TabIndex="5" ToolTip="You may adjust the content's displayed size up or down by the percentage in this box. See &quot;Changing Content Size&quot;"></cc1:OboutTextBox>&nbsp;%
                        of Original
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
                            Width="90%" SelectionMode="Multiple" MultiSelectionSeparator=", " DataSourceID="ODSCategory"
                            DataTextField="name" DataValueField="id" EnableVirtualScrolling="True" TabIndex="11"
                            OpenOnFocus="False">
                        </cc2:ComboBox>
                    </td>
                </tr>
                <tr class="boxTitle">
                    <td>
                        Suggesed PEs
                    </td>
                </tr>
                <tr>
                    <td class="boxRow">
                        <cc2:ComboBox ID="ddlAssociatedPE" runat="server" FolderStyle="css/oboutSuite/ComboBox/styles/plain/style.css"
                            Width="90%" SelectionMode="Multiple" DataSourceID="ODSInterest" DataTextField="name"
                            DataValueField="id" MenuWidth="600px" TabIndex="12" OpenOnFocus="False">
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
                        <cc2:ComboBox ID="ddnAssociations" runat="server" FolderStyle="css/oboutSuite/ComboBox/styles/plain"
                            Width="90%" SelectionMode="Multiple" DataSourceID="ODSGroup" DataTextField="name"
                            DataValueField="id" TabIndex="13" OpenOnFocus="False">
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
                        <cc1:OboutRadioButton ID="rbnLinkThumb" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutRadioButton"
                            GroupName="rbgLinkStyle" Text="Thumb" Checked="True" ToolTip="Choose to Enter a Clickable Image Below">
                            <ClientSideEvents OnCheckedChanged="linkChkChanged" OnClick="clearBox" />
                        </cc1:OboutRadioButton>&nbsp;&nbsp;&nbsp;
                        <cc1:OboutRadioButton ID="rbnLinkButton" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutRadioButton"
                            GroupName="rbgLinkStyle" Text="Button" ToolTip="Choose to Select a Clickable Button Below">
                            <ClientSideEvents OnCheckedChanged="linkChkChanged" />
                        </cc1:OboutRadioButton>&nbsp;&nbsp;&nbsp;
                        <cc1:OboutRadioButton ID="rbnLinkText" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutRadioButton"
                            GroupName="rbgLinkStyle" Text="Text" ToolTip="Choose to Enter Link Text Below">
                            <ClientSideEvents OnCheckedChanged="linkChkChanged" OnClick="clearBox" />
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
                <%-- <tr>
                    <td colspan="2">
                        <cc1:OboutTextBox ID="txtLinkInfo" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            Width="90%" TabIndex="15" Enabled="True" Visible="True">
                        </cc1:OboutTextBox>
                    </td>
                </tr>--%>
                <%--<tr>
                    <td>
                        <b>Thumb URL</b></td>
                    <td>
                        <cc1:OboutTextBox ID="txtThumb" runat="server" Enabled="True" 
                            FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox" TabIndex="15" 
                            Visible="True" Width="90%"></cc1:OboutTextBox>
                    </td>
                </tr>--%>
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
                    <td style="text-align: center" title="This area displays the actual clickable link to the content. Click to view Floatbox preview.">
                        Content Preview
                    </td>
                </tr>
                <tr>
                    <td width="80%">
                        <cc1:OboutTextBox ID="txtContent" runat="server" Height="9em" TextMode="MultiLine"
                            ToolTip="Place Media Embed Code or Page URL Here." Width="99%" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutTextBox"
                            TabIndex="1" WatermarkText="Paste Embed or URL Here"></cc1:OboutTextBox>
                    </td>
                    <td style="background: #dddddd; text-align: center;" title="Click to view FB Preview">
                        <asp:Literal ID="litPreview" runat="server"></asp:Literal>
                    </td>
                </tr>
            </table>
        </div>
        <div class="bottomButtons">
            <div class="btnLeftGroup">
                <cc1:OboutButton ID="btnPrevious" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="MENU" Width="80px" Font-Size="10pt" OnClientClick="return goBack();" ToolTip="Close and Return to Main Menu">
                </cc1:OboutButton></div>
            <div class="btnLeftGroup">
                <cc1:OboutButton ID="btnNew" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="NEW" Width="80px" Font-Size="10pt" ToolTip="Reset all Fields and Start Over.  CAUTION: ALL DATA WILL BE LOST IF NOT SAVED">
                </cc1:OboutButton></div>
            <div class="btnLeftGroup">
                <cc1:OboutButton ID="btnOptions" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="OPTIONS" Width="80px" Font-Size="10pt" OnClientClick="return showCustom();"
                    ToolTip='Click to Choose FB Content Options.  See "FB Options"'>
                </cc1:OboutButton>
                <%--<input type="button" value="More" id="btnMore"  onclick="showMore();" />--%></div>
            <div class="btnLeftGroup">
                <cc1:OboutButton ID="btnBuild" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="BUILD" OnClientClick="return ValidateForm();" Width="80px" Font-Size="10pt"
                    ToolTip="Click to Build a Content Preview.  You may change fields and re-build as often as you like.">
                </cc1:OboutButton></div>
            <div class="btnRightGroup">
                <cc1:OboutButton ID="btnSave" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="SAVE" Width="80px" OnClientClick="return ValidateForm();" Font-Size="10pt"
                    ToolTip="Save this Entry to Catalog">
                </cc1:OboutButton></div>
            <div class="btnRightGroup">
                <cc1:OboutButton ID="btnMsg" runat="server" FolderStyle="css/oboutSuite/Interface/styles/plain/OboutButton"
                    Text="MESSAGE" Width="80px" Font-Size="10pt" ToolTip="Save this Content & Open Populated Messaging Dialog ">
                </cc1:OboutButton></div>
        </div>
    </asp:Panel>
    </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <%--<input type="button" value="More" id="btnMore"  onclick="showMore();" />--%>
    <asp:Panel ID="pnlShowCustom" runat="server" class="panelDiv3" Style="height: 250px;">
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
        <asp:HiddenField ID="hdnBuildCount" runat="server" />
        <asp:GridView ID="gvOwner" runat="server" AutoGenerateColumns="False" DataKeyNames="OwnerID"
            DataSourceID="ODSConciergeMaster" Visible="False">
            <Columns>
                <asp:BoundField DataField="OwnerID" HeaderText="OwnerID" ReadOnly="True" SortExpression="OwnerID" />
                <asp:BoundField DataField="OwnerName" HeaderText="OwnerName" SortExpression="OwnerName" />
                <asp:BoundField DataField="OwnerType" HeaderText="OwnerType" SortExpression="OwnerType" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:ObjectDataSource ID="ODSCategory" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsConciergeTableAdapters.interest_categoriesTableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ODSGroup" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsConciergeTableAdapters.interest_groupsTableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ODSInterest" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsConciergeTableAdapters.interestsTableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ODSMediaType" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsConciergeTableAdapters.Concierge_mediatypeTableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ODSConciergeOwner" runat="server" SelectMethod="GetData"
        TypeName="dsConciergeTableAdapters.Concierge_OwnerTableAdapter" OldValuesParameterFormatString="original_{0}" />
    <asp:ObjectDataSource ID="ODSConciergeMaster" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="dsConciergeTableAdapters.vw_Concierge_Owner_CampaignTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ODSConciergeDetail" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="dsConciergeTableAdapters.vw_Concierge_Owner_Campaign1TableAdapter">
        <SelectParameters>
            <asp:Parameter Name="OwnerID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </form>
    
</body>
</html>
