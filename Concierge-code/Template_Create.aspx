<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Template_Create.aspx.vb" Inherits="Template_Create" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" TagPrefix="obout" %>
<%@ Register Assembly="obout_ComboBox" Namespace="Obout.ComboBox" TagPrefix="cc2" %>
<%@ Register Assembly="obout_Interface" Namespace="Obout.Interface" TagPrefix="cc1" %>
<%@ Register TagPrefix="custom" Namespace="CustomToolbarButton" %>
<%@ Register namespace="CustomPopups" tagprefix="custom" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor.ContextMenu" TagPrefix="obout" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.HTMLEditor.ToolbarButton" %>
<%@ Register assembly="Obout.Ajax.UI" namespace="Obout.Ajax.UI.HTMLEditor.Popups" tagprefix="obout" %>
<%@ Register assembly="Obout.Ajax.UI" namespace="Obout.Ajax.UI.HTMLEditor.ToolbarButton" tagprefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Rocket21 Concierge Template Creation</title>
    <link type="text/css" rel="stylesheet" href="http://r21concierge.s3.amazonaws.com/floatbox_427/floatbox.css" />
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
    <script type="text/javascript" >
        function DeleteTemplate() {
            var id;
            id = document.forms[0].ddnTemplate.value;
            if (id == 111111) { alert("Please select a template to delete"); return false; }
            else {
                var ans;
                ans = confirm("Do you want to delete this template?");
                if (ans == true) 
                    return true;
                else
                    return false;
            }
       }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <div style="border: solid 1px green; width: 800px; height: 650px; background-color: #FFFBD6;
        margin: 0 auto;">
        <div>
            <asp:HyperLink ID="hypBack" runat="server" NavigateUrl="Default.aspx">Back</asp:HyperLink>
        </div>
        <div style="padding: 5px 1px 5px 5px; background-color: #990000; font-weight: bold;
            color: White; height: 20px; text-align: center;">
            Rocket21 Concierge Create Template</div>
         <div>
         
            <table width="790px">
                    <tr>
                        <td>&nbsp;</td>
                         <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center"><asp:Label ID="lblStatus" runat="server" Visible="false" BackColor="#ffff99" ForeColor="Red"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight: normal;">Select a Template</span>
                         </td>
                        <td>
                           <asp:DropDownList ID="ddnTemplate" runat="server" Width="350" MenuWidth="300" AutoPostBack="true"
                                DataSourceID="sds1" DataTextField="TemplateName" DataValueField="TemplateID">
                           </asp:DropDownList>&nbsp;&nbsp;
                            <asp:ImageButton ID="imgDelete" ToolTip="Delete Template" AlternateText="Delete Template" runat="server" ImageUrl="~/images/delete.png" Width="20px" Height="20px"/>
                            <asp:SqlDataSource ID="sds1" runat="server" SelectCommand="SELECT * FROM (SELECT 111111 'TemplateID', 'Select a Template' 'TemplateName' UNION SELECT TemplateID, CAST(TemplateID AS VARCHAR(10)) + ' : ' + TemplateName + ' : ' + CAST(created_at AS VARCHAR(50)) TemplateName FROM ConciergeTemplate) DT ORDER BY TemplateID DESC"
		                    ConnectionString="Data Source=W2008SRV;Initial Catalog=Rocket21;User Id=webuser;Password=h31pLe@rn;" providerName="System.Data.SqlClient"></asp:SqlDataSource>
	                   </td>
                    </tr>
                    <tr><td colspan="2" style="height:2px;"></td></tr>
                    <tr>
                        <td>
                            <span style="font-weight: normal;">Template Name</span>
                         </td>
                        <td>
                            <asp:TextBox ID="txtTemplateName" runat="server" BorderWidth="1" Width="640px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:2px;"></td></tr>
                    
                    <tr>
                        <td>
                            <span style="font-weight: normal;">Icon URL</span>
                         </td>
                        <td>
                        <%--<cc2:ComboBox runat="server" ID="ComboBox2" Width="200" MenuWidth="300" ShowSelectedImage="true"
                            DataSourceID="sds1" DataTextField="AltText" DataValueField="IconID" EmptyText="Select a customer ..." />
    
                            <asp:SqlDataSource ID="sds1" runat="server" SelectCommand="SELECT IconID, AltText, IconURL FROM ConciergeIcon"
		                    ConnectionString="Data Source=W2008SRV;Initial Catalog=Rocket21;User Id=webuser;Password=h31pLe@rn;" providerName="System.Data.SqlClient"></asp:SqlDataSource>
	                    --%>
	                    <cc2:ComboBox runat="server" ID="cboIconURL" ShowSelectedImage="true" Width="350">
                            <Items>
                                <cc2:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="Select an ICON ..." Value="0" ImageUrl="" />
                                <cc2:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="Concierge" Value="http://s3.amazonaws.com/r21concierge/images/concierge.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="Concierge 1" Value="http://s3.amazonaws.com/r21concierge/images/concierge_01.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_01.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="Concierge 2" Value="http://s3.amazonaws.com/r21concierge/images/concierge_02.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_02.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="Concierge 3" Value="http://s3.amazonaws.com/r21concierge/images/concierge_03.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_03.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="Concierge 4" Value="http://s3.amazonaws.com/r21concierge/images/concierge_04.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_04.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="Concierge 5" Value="http://s3.amazonaws.com/r21concierge/images/concierge_05.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_05.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="Concierge 6" Value="http://s3.amazonaws.com/r21concierge/images/concierge_06.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_06.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem9" runat="server" Text="Concierge 7" Value="http://s3.amazonaws.com/r21concierge/images/concierge_07.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_07.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Concierge 8" Value="http://s3.amazonaws.com/r21concierge/images/concierge_08.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_08.png" />
                                <cc2:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Concierge 9" Value="http://s3.amazonaws.com/r21concierge/images/concierge_09.png" ImageUrl="http://s3.amazonaws.com/r21concierge/images/concierge_09.png" />
                            </Items>
                        </cc2:ComboBox>
                       
                    </tr>
                    <tr><td colspan="2" style="height:2px;"></td></tr>
                    <tr>
                        <td>
                            <span style="font-weight: normal;">Wrapper Text</span>
                         </td>
                        <td>
                            <asp:TextBox ID="txtWrapper" runat="server" BorderWidth="1" Width="640px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:2px;"></td></tr>
                    <tr>
                        <td>
                            <span style="font-weight: normal;">Title</span>
                         </td>
                        <td>
                            <asp:TextBox ID="txtTitle" runat="server" BorderWidth="1" Width="640px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:2px;"></td></tr>
                    <tr>
                        <td valign="top">
                            <span style="font-weight: normal;">Body</span>
                         </td>
                        <td>
                        <obout:EditorPopupHolder runat="server" id="popupHolder" />
                         <obout:Editor ID="Editor" runat="server" Height="340px" Width="640px" PopupHolderID="popupHolder" RelImgUrls="false">
                             <BottomToolbar ShowFullScreenButton="True">
                             </BottomToolbar>
                             
                          </obout:Editor>
                        
                        </td>
                    </tr>
                    
                    <tr><td colspan="2" style="height:2px;"></td></tr>
                    <tr>
                        <td class="style1"></td>
                        <td class="style1">
                           <asp:button id="btnCreateTemplate" runat="server" text="Save Template" />
                           <asp:button id="btnSaveAs" runat="server" text="Save Template As" />
                           <asp:button id="btnNewTemplate" runat="server" text="Create New Template" />
                           <asp:button id="btnInsertFlot" runat="server" text="Insert Floatbox Content" />
                           <asp:Button ID="btnPreview" runat="server" Text="Preview" />
                           <asp:HiddenField ID="HidID" runat="server" />
                        </td>
                      </tr>
                </table>
               
               </div>
               
               <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" CancelControlID="btnCancel"
        TargetControlID="btnInsertFlot" PopupControlID="Panel1" PopupDragHandleControlID="PopupHeader"
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
    
    </div>
    </form>
</body>
</html>
