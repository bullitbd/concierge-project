<%@ Page Language="VB" AutoEventWireup="false" Debug="true" CodeFile="OboutEditorTestSQL.aspx.vb"
    Inherits="OboutEditorTestSQL" ValidateRequest="false" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" TagPrefix="obout" %>
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
            <table>
                <tr>
                    <td>
                        Draft ID:
                        <asp:TextBox ID="txtId" runat="server" Width="30px">0</asp:TextBox>
                    </td>
                    <td style="padding-left: 40px;">
                        <asp:Button ID="btnSubmit" runat="server" Text="Load Table" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="divider">
            <obout:Editor ID="editor" runat="server" Height="300px" Width="800px">
            </obout:Editor>
        </div>
        <div class="divider">
            <asp:TextBox ID="txtInput" runat="server" Width="500px" TextMode="MultiLine" Height="80px"></asp:TextBox>
        </div>
    </div>
    </form>
</body>
</html>
