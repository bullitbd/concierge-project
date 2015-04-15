<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AKOM_Landing.aspx.vb" Inherits="AKOM_Landing" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Rocket21 - Webinars</title>
</head>
<body>
<script language="javascript" type="text/javascript">
     function SubmitWebinar() {
         if (document.forms[0].txtFirstName.value == "") { alert("Please enter First Name"); return false; }
         else if (document.forms[0].txtLastName.value == "" || document.forms[0].txtSubject.value == "Enter Text...")
         { alert("Please enter the subject"); document.forms[0].txtSubject.focus(); return false; }
         else if (content == "")
         { alert("Please enter the Message"); document.forms[0].Editor.focus(); return false; }
         else {

             return true;
             
         }
     }
    </script>
    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <div style="border: solid 1px green; width: 600px; background-color: #FFF; margin: 0 auto;">
        <div><table style="width: 600px;"><tr><td align="center">
            <br /><img src="images/rocket21.jpg" alt="Rocket21" style="height: 76px"/><br /><br /></td></tr></table></div>
        <div style="padding: 5px 1px 5px 5px; background-color: #ff0000; font-weight: bold; font-family:arial;
            color: White; height: 20px; text-align: center;">
            Rocket21 WEBINARS for Connecting Minds Educators</div>
        
        <div style="padding: 10px 10px 5px 10px; background-color: #fff; font-weight: normal; font-family:arial; color: black;">
            <b>It’s easy!</b>  Just click on the session you prefer and enter your name and email address in the space provided.  
            The Rocket21 team will send you an email invitation to the webinar and instructions for how to log in.  
            (Don’t worry, we’ll remind you before the event.)
        </div>
        <div style="padding: 5px 10px 10px 10px; background-color: #fff; font-weight: normal; font-family:arial; color: black;">
            <b>NOTE:</b> <i>If you are not sure which webinar you will be able to attend, 
            you can select more than one and we’ll send you an invitation and reminders for all that you select. </i>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="padding: 10px 10px 10px 10px;">
                    
                    <table style="background-color: #cccccc;font-weight: bold; font-size:small; font-family:arial; color: black; border:solid 1px green; margin: 0 auto;">
                     <tr>
                        <td></td><td></td>
                    </tr>
                    <asp:Label ID="lblWeb" runat="server" Visible="false" BackColor="#ffff99" ForeColor="Red"></asp:Label>
                    <tr>
                        <td colspan="2"><asp:CheckBox ID="CheckBox1" runat="server" Text="Webinar 1: Tuesday, October 18 at 4:00PM, ET" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><asp:CheckBox ID="CheckBox2" runat="server" Text="Webinar 2: Thursday, October 20 at 8:00PM, ET"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><asp:CheckBox ID="CheckBox3" runat="server"  Text="Webinar 3: Tuesday, October 25 at 4:00PM, ET"/></td>
                    </tr>
                    <tr>
                        <td>First Name</td><td><asp:TextBox ID="txtFirstName" runat="server" BorderColor="Black" BorderWidth="1" Width="250px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Last Name</td><td><asp:TextBox ID="txtLastName" runat="server" BorderColor="Black" BorderWidth="1" Width="250px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Email Address</td><td><asp:TextBox ID="txtEmail" runat="server" BorderColor="Black" BorderWidth="1" Width="250px"></asp:TextBox></td>
                     </tr>
                     <tr>
                        <td></td><td><asp:Button ID="btnWebinarSubmit" runat="server" Text="Submit" /></td>
                     </tr>
                    </table>
                    <br />
                </div>
        
                <div style="padding: 5px 1px 5px 5px; background-color: #ff0000; font-weight: bold; font-family:arial;
                    color: White; height: 20px; text-align: center;">
                    Rocket21 Email Updates</div>
                
                <div style="padding: 10px 10px 10px 10px; background-color: #fff; font-weight: normal; color: black; font-family:arial;">
                    If you’d like to receive email updates regarding new developments and opportunities available for students and educators at Rocket21, 
                    please click the box below to Opt-In for Rocket21 Email Alerts.  If you haven’t provided your name and email address above, please add it here.
                </div>
                <div style="padding: 10px 10px 10px 10px;">
                    <table style="background-color: #cccccc;font-weight: bold; font-size:small; font-family:arial; color: black; border:solid 1px green; margin: 0 auto;">
                     <tr>
                        <td></td><td></td>
                    </tr>
                     <asp:Label ID="lblEmail" runat="server" Visible="false" BackColor="#ffff99" ForeColor="Red"></asp:Label>
                    <tr>
                        <td colspan="2"><asp:CheckBox ID="CheckBox4" runat="server" Text="Please send me periodic Rocket21 information alerts" AutoPostBack="true" /></td>
                    </tr>
                    <tr>
                        <td>First Name</td><td><asp:TextBox ID="txtEFname" runat="server" BorderColor="Black" BorderWidth="1" Width="250px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Last Name</td><td><asp:TextBox ID="txtELname" runat="server" BorderColor="Black" BorderWidth="1" Width="250px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Email Address</td><td><asp:TextBox ID="txtEEmail" runat="server" BorderColor="Black" BorderWidth="1" Width="250px"></asp:TextBox></td>
                     </tr>
                     <tr>
                        <td></td><td><asp:Button ID="btnEmailSubmit" runat="server" Text="Submit" /></td>
                     </tr>
                    </table>
                    <br />
                </div> 
                
                <div style="padding: 5px 1px 5px 5px; background-color: #ff0000; font-weight: bold; font-family:arial;
                    color: White; height: 20px; text-align: center;">
                    Questions or Comments?</div>
                <div style="padding: 10px 10px 10px 10px; background-color: #fff; font-weight: normal; color: black; font-family:arial;">
                    Please let us know if you have any questions, or experienced any difficulty registering for these webinars.  
                    If for any reason your email is being rejected, please leave it here and will follow up with you very soon.  Thanks!
                </div>
                <div style="padding: 10px 10px 10px 10px;">
                    <table style="background-color: #cccccc;font-weight: bold; font-size:small; font-family:arial; color: black; border:solid 1px green; margin: 0 auto;">
                     <tr>
                         <td></td>
                    </tr>
                     <asp:Label ID="lblComment" runat="server" Visible="false" BackColor="#ffff99" ForeColor="Red"></asp:Label>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtComment" runat="server" BorderColor="Black" BorderWidth="1" 
                                Width="375px" TextMode="MultiLine" Columns="5" Rows="5"></asp:TextBox>
                        </td>
                     </tr>
                     <tr>
                         <td style="text-align: center"><asp:Button ID="btnSubmitComment" runat="server" 
                                 Text="Submit" /></td>
                     </tr>
                    </table>
                    <br />
                </div>                  
            </ContentTemplate>
        </asp:UpdatePanel>   
    </div>
    <asp:SqlDataSource ID="SDS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:R21Conn %>" 
        DeleteCommand="DELETE FROM [WebinarComment] WHERE [CommentID] = @CommentID" 
        InsertCommand="sp_WebinarComment_ins" InsertCommandType="StoredProcedure" 
        SelectCommand="SELECT [CommentID] FROM [WebinarComment]">
        <DeleteParameters>
            <asp:Parameter Name="CommentID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="txtComment" Name="comment" PropertyName="Text" 
                Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
