<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SongWritingContest.aspx.vb" Inherits="SongWritingContest" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" TagPrefix="obout" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor.ContextMenu" TagPrefix="obout" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.HTMLEditor.ToolbarButton" %>
<%@ Register assembly="Obout.Ajax.UI" namespace="Obout.Ajax.UI.HTMLEditor.Popups" tagprefix="obout" %>
<%@ Register assembly="Obout.Ajax.UI" namespace="Obout.Ajax.UI.HTMLEditor.ToolbarButton" tagprefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Rocket21 Song Writing Contest</title>
    <link href="./css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="http://r21concierge.s3.amazonaws.com/css/concierge.css" rel="stylesheet" type="text/css" />
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
</head>
<body>
   <form id="form1" runat="server">
   <div style="border: solid 1px green; width: 600px; background-color: #FFF; margin: 0 auto;">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        <div style="padding: 5px 1px 5px 5px; background-color: #990000; font-weight: bold; font-family:arial;
            color: White; height: 20px; text-align: center;">
            Rocket21 Song Writing Contest</div>
        
        <div style="padding: 10px 10px 10px 10px; background-color: #fff; font-weight: normal; font-family:arial; color: black;">
            Description goes here. 
        </div>
         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="padding: 10px 10px 10px 10px;">
                        <table style="background-color: #FFFBD6;font-weight: bold; font-size:small; font-family:arial; color: black; border:solid 1px green; margin: 0 auto;">
                         <tr>
                            <td style="width:100px;"></td><td style="width:450px;" ></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><asp:Label ID="lblStatus" runat="server" Visible="false" BackColor="#ffff99" ForeColor="Red"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>Screen Name</td><td><asp:TextBox ID="txtScreenName" runat="server" BorderWidth="1" Width="450px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Song Title</td><td><asp:TextBox ID="txtSongTitle" runat="server" BorderWidth="1" Width="450px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Select Genre</td><td><asp:DropDownList ID="ddnGenre" runat="server" BorderWidth="1" Width="450px"></asp:DropDownList> </td>
                        </tr>
                        <tr>
                            <td>Lyrics</td><td>
<%--                            <asp:TextBox ID="txtLyrics" runat="server" BorderWidth="1" Width="450px" TextMode="MultiLine"  Rows="4" ></asp:TextBox>
--%>       
                                <obout:Editor ID="Editor" runat="server" Height="340px" Width="450px">
                             
                             
                          </obout:Editor>                     
                            </td>
                         </tr>
                         <tr>
                            <td></td><td><asp:Button ID="btnSubmit" runat="server" Text="Submit" /></td>
                         </tr>
                        </table>
                    </div>
                </ContentTemplate>
        </asp:UpdatePanel>   
        
    </div>
    </form>
</body>
</html>
