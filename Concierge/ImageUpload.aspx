<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ImageUpload.aspx.vb" Inherits="ImageUpload" %>

<%@ Register assembly="obout_FileUpload" namespace="OboutInc.FileUpload" tagprefix="fup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Concierge: Image Uploader</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="background-color: #FFCCFF">
    
        <b>Concierge Image Upload Utility</b><br />
        Select Image Location :<br />
        <asp:FileUpload ID="FileUpload1" runat="server" Width="250px" />
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="FileUpload1" ErrorMessage="Please select a file to upload!"></asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button ID="btnUpload" runat="server" Text="Upload" />
        <br />
        <asp:Label ID="lblStatus" runat="server"></asp:Label>
        <br />
        <br />
        <asp:HyperLink ID="hypFileLink" runat="server" Target="_blank" Visible="False">[hypFileLink]</asp:HyperLink>
        <br />
        <br />
        <asp:Button ID="btnClose" runat="server" onclientclick="self.close();" 
            Text="Close Window" />
    
    </div>
    </form>
</body>
</html>
