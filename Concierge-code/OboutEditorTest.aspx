<%@ Page Language="VB" AutoEventWireup="false" Debug="true" CodeFile="OboutEditorTest.aspx.vb"
    Inherits="OboutEditorTest" ValidateRequest="false" %>

<%@ Register Assembly="obout_ComboBox" Namespace="Obout.ComboBox" TagPrefix="cc2" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" TagPrefix="obout" %>
<%@ Register assembly="obout_Interface" namespace="Obout.Interface" tagprefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>oBout editor test</title>
    <style type="text/css">
        body
        {
            font-family: Arial, helvetica, Sans-Serif;
        }
        .divider
        {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <div class="divider">
            <asp:TextBox ID="txtInput" runat="server" Width="500px" TextMode="MultiLine" Height="80px"></asp:TextBox></div>
        <div class="divider">
            <asp:Button ID="btnSubmit" runat="server" Text="Load Text" /></div>
        <div class="divider">
            Image Combo-Box using ODSIcon as Object datasource:<br />
            <cc2:ComboBox ID="ComboBox1" runat="server" 
                DataSourceID="ODSIcon" DataTextField="AltText" DataValueField="IconID" 
                ShowSelectedImage="True"  AutoPostBack="false">
            </cc2:ComboBox>
            <asp:ObjectDataSource ID="ODSIcon" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                TypeName="dsConciergeTableAdapters.ConciergeIconTableAdapter">
            </asp:ObjectDataSource>
       </div>    
        <div class="divider">
            <obout:Editor ID="editor" runat="server" Height="300px" Width="800px">
            </obout:Editor>
        </div>
    </div>
    </form>
</body>
</html>
