'[TODO] Validate 40 <= iPercent <= 400
'[TODO] Populate txtPct with sPercent **DONE
'[TODO] Store old ht/width values
'[TODO] Tab order of controls - across top, down right... **DONE
'[TODO] On load place focus in cboMediaType  **DONE
'[TODO] See Todos in parseEmbed (default path...)
'[TODO] Size not working in Pct functionality... **DONE for Videos - this works in conjucntion with Native/Full/Custom buttons...
'[TODO] Add sPct to Catalog table
'5/31/2011 BD added hidden field "buildCount" to store value of parsePass between postbacks.
'[TODO] see https://www.obout.com/combobox/aspnet_apiclient_items_columns.aspx for info on adding items to combos
'[TODO] see https://www.obout.com/combobox/aspnet_columns_multiple.aspx for info on fixing pe item display
'[TODO] RAJIV see https://www.obout.com/combobox/aspnet_master_detail.aspx for info on Owner/Campaign box implementation
Imports System.Data
Imports System.Data.SqlClient
Imports DataAccess
Partial Class Catalog_JG
    Inherits System.Web.UI.Page
    Dim sText As String
    Dim sWidth As String
    Dim sHeight As String
    Dim sPercent As String = "100"
    Dim sFileDate As String = DateTime.Now.ToString("yymmddhhmmssff")

    'NEW vars - Aspect Ratio, Thumbnail
    Dim nRatio As Double = 1.0
    Dim sRatio As String
    Dim sThumb As String = ""
    Dim sButton As String = "" '[TODO] this will pick up the button field of the cboLinkInfo control.

    Dim sContent As String
    Dim sURL As String

    Dim sWebSite As String
    Dim sCaption As String
    Dim sCaption1 As String

    Dim sLinkStyle As String
    Dim sLinkText As String

    Dim parsePass As Integer 'parse function counter

    'Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
    '    If Not Page.IsPostBack Then
    '        txtPct.Text = sPercent
    '        hdnBuildCount.Value = 0
    '        txtContent.Focus()
    '        btnSave.Enabled = False
    '        btnMsg.Enabled = False
    '    End If
    'End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'pnlShowMore.Style.Add("visibility", "hidden")
            pnlShowCustom.Style.Add("visibility", "hidden")
            txtPct.Text = sPercent
            hdnBuildCount.Value = 0
            'set up Link buttons, text state to thumbnail;
            rbnLinkThumb.Checked = True 'defaults Thumb button on load [TODO] This needs to happen client side - MediaType and Link logic interact.
            'txtLinkInfo.Visible = True
            'cboLinkInfo.Visible = False
            'cboLinkInfo.Attributes.Add("display", "none")
            'rbnLinkThumb.Attributes.Add("onCheckedChanged", "return linkChkChanged();")

            'cboLinkInfo.AllowCustomText = True
            'cboLinkInfo.Mode = Obout.ComboBox.ComboBoxMode.TextBox
            'cboLinkInfo.AllowEdit = True
            'place initial focus in Embed box ready for paste
            txtContent.Focus()
            'disable saving until after preview;
            btnSave.Enabled = False
            btnMsg.Enabled = False

        End If
    End Sub
    Protected Sub linkLogic()

    End Sub
    Protected Sub parseContent()

        Dim iPercent As Integer
        iPercent = CInt(txtPct.Text)
        sContent = txtContent.Text
        parsePass = hdnBuildCount.Value

        '// Parse sContent relative to media type...

        'Reference class
        Dim oParse As New ParseEmbed
        'oParse = New ParseEmbed(sContent, cboMedia.SelectedIndex + 1, iPercent)
        With oParse
            .mtype = cboMedia.SelectedIndex + 1
            .pct = iPercent
            .sdate = sFileDate
            .title = txtTitle.Text
            'if Thumbnail radio button is checked, send contents of txtLinkInfo to oParse as .thumb property.
            'It is checked there for a valid image url match.  If no match (ie bad or empty),
            'dropped and normal parse thumb routine is done
            If rbnLinkThumb.Checked Then
                .thumb = txtLinkInfo.Text
            End If
            .input = sContent


        End With

        '// Make collection & call the parse class, return collection oParse.results
        Dim oVars As New Dictionary(Of String, String)

        '// Copy oParse.results into local oVars
        oVars = oParse.results

        '// Assign oVars to local vars
        sURL = oVars("url")
        'If parsePass = 0 Then  'Check for existence - if none there, allow entry.
        '    If oVars("thumb").IndexOf("http://") = 0 Then
        '        sThumb = oVars("thumb")
        '    End If
        'Else
        '    If oVars("thumb") = txtThumbURL.Text Then
        '        sThumb = oVars("thumb")
        '    Else
        '        '[TODO??] sThumb = txtThumbURL.Text
        '    End If

        'End If
        sThumb = oVars("thumb")
        sWebSite = oVars("web")
        sHeight = oVars("height")
        sWidth = oVars("width")
        'sRatio = oVars("ratio")
        parsePass += 1
        hdnBuildCount.Value = parsePass
        assembleFB()
    End Sub 'parseContent()

    Function ImageSize() As Integer
        '[TODO] Hook this up later... temp Return 1
        'Select Case True
        '    Case rbNative.Checked
        '        Return 1
        '    Case rbFullscreen.Checked
        '        Return 2
        '    Case rbCustom.Checked
        '        Return 3
        'End Select
        Return 1
    End Function
    Protected Sub assembleFB()
        Dim iImageSize As Integer = 1

        Dim buildFB As New FBBuilder
        With buildFB
            .mediaType = cboMedia.SelectedText
            .mediaURL = sURL
            .height = sHeight
            .width = sWidth
            .size = ImageSize()
            'If rbnLinkButton.Checked Then 'sends literal sButton url to build instead of sThumb from ovars parse '[TODO] set sButton
            '    .thumb = sButton
            'Else
            '    .thumb = sThumb
            'End If
            .title = txtTitle.Text
            .caption = txtCaption.Text
            .tip = txtTip.Text
            .infoLink = txtInfoLink.Text
            .print = txtPrint.Text
            '[TODO] add commented out Alt checkbox and popup field;  for now, default to Title
            .alt = txtTitle.Text  'txtAlt.Text

            '[TODO] !Put in function! and flesh out procedure. linkType and linkText refer to rbgLinkStyle button group ("Link")
            'and cboLinkInfo / txtLinkInfo.  See notes at bottom of Use Case Document

            Select Case True
                Case rbnLinkThumb.Checked
                    sLinkStyle = "Thumbnail"
                    'this needs to happen at parse, not here...
                    'a link is typed into txtLinkInfo.Text;
                    'if it's there, it is sent to parse and returned as url for the content;  if not, normal routine is returned.
                    'so, slinktext is either oparse("thumb") or one of the others.  Any content can be parsed with a manual thumb...
                    sLinkText = sThumb
                Case rbnLinkButton.Checked
                    sLinkStyle = "Button"
                    sLinkText = cboLinkInfo.SelectedText
                Case rbnLinkText.Checked
                    sLinkStyle = "Text"
                    sLinkText = txtLinkInfo.Text
            End Select
            .linkType = sLinkStyle
            .linkText = sLinkText
        End With
        '*****************[SITE OR PAGE URL - ADD TO EDIT] if Text Button checked AND Media is 'Web.. or 'Page' AND Link Text box is empty, don't build an FB string (sText="")
        If Not (rbnLinkText.Checked = True And (cboMedia.SelectedIndex = 7 Or cboMedia.SelectedIndex = 6) And sLinkText = "") Then
            sText = buildFB.getFB()
        Else
            sText = ""
        End If
        '******************[END PAGE URL ROUTINE]


        Session("content") = sText
        litPreview.Text = sText
        litPreview.Visible = True
        txtFB.Value = sText
        ''txtMediaType.Text = ddnMedia.SelectedItem.Value
        litPreview.Visible = True
        pnlMain.Visible = True '[TODO] What is this for?
        'btnNext.Visible = False
        'btnRefresh.Visible = True
        ''If ddnMedia.SelectedIndex <> 4 Then 'if Group, leave blank
        '[TODO] Below are in 2nd Panel, currently commented out
        'txtWebsite.Text = sWebSite
        'txtWidth.Text = sWidth
        'txtHeight.Text = sHeight
        ''txtPercent.Text = sPercent
        ''txtRatio.Text = sRatio
        'txtURL.Text = sURL
        'txtThumbURL.Text = sThumb 'can be thumbUrl or button text or inline text...
        ' ''Else
        ''chkHasGroup.Enabled = False

        ''End If

    End Sub 'assembleFB
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'pnlShowMore.Style.Add("visibility", "hidden")
        Call parseContent()
        Call postData()
    End Sub
    Protected Sub postData()
        Dim iContentID As Integer
        Dim SubmittedBy As String = cboSubmitted.SelectedValue
        Dim WebSiteURL As String = sWebSite
        Dim HTMLEmbedTag As String = txtFB.Value
        Dim KeyWords As String = ddlKeywords.Text
        Dim InternalNotes As String = txtNotes.Text
        Dim Message As String = "" 'txtTags.Text
        Dim OwnerType As String = txtOwnerType.Text
        Dim Description As String = txtDescription.Text
        Dim Caption As String = txtCaption.Text
        Dim MediaURL As String = sURL
        Dim MediaType As String = cboMedia.SelectedValue
        Dim Title As String = txtTitle.Text
        Dim ThumbURL As String = sThumb '[TODO] sort out which of these need be stored - sLinkText actually has all the info
        Dim LinkStyle As String = sLinkStyle
        Dim LinkText As String = sLinkText
        Dim Owner As String = cboOwner.SelectedValue
        Dim sCampainID As String = cboCampaign.SelectedValue
        Dim AlternateText As String = txtTitle.Text '[TODO].txtAlt.Text
        Dim HasTip As Boolean = 0
        If chkTip.Checked Then HasTip = 1
        Dim HasInfo As Boolean = 0
        If chkInfo.Checked Then HasInfo = 1
        Dim CanPrint As Boolean = 0
        If chkPrint.Checked Then CanPrint = 1
        Dim TestOnly As Boolean = 0
        If chkTestOnly.Checked Then TestOnly = 1

        Dim sCategory As String = lstCategory.SelectedValue
        Dim sGroup As String = ddnAssociations.SelectedValue
        Dim sAssociatedPE As String = ddlAssociatedPE.SelectedValue

        Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString
        Try
            Dim myConnection = New SqlConnection(sConn)
            myConnection.Open()
            Dim myCommand = New SqlCommand
            myCommand.Connection = myConnection
            myCommand.CommandType = CommandType.StoredProcedure
            myCommand.CommandText = "sp_ContentPicker_Ins"
            'parameters required for the stpred procedure
            myCommand.Parameters.AddWithValue("@SubmittedBy", SubmittedBy)
            myCommand.Parameters.AddWithValue("@WebSiteURL", WebSiteURL)
            myCommand.Parameters.AddWithValue("@HTMLEmbedTag", HTMLEmbedTag)
            myCommand.Parameters.AddWithValue("@KeyWords", KeyWords)
            myCommand.Parameters.AddWithValue("@AssociatedPE", sAssociatedPE)
            myCommand.Parameters.AddWithValue("@InternalNotes", InternalNotes)
            myCommand.Parameters.AddWithValue("@Message", Message)
            myCommand.Parameters.AddWithValue("@OwnerType", OwnerType)
            myCommand.Parameters.AddWithValue("@Description", Description)
            myCommand.Parameters.AddWithValue("@Caption", Caption)
            myCommand.Parameters.AddWithValue("@MediaURL", MediaURL)
            myCommand.Parameters.AddWithValue("@MediaType", MediaType)
            myCommand.Parameters.AddWithValue("@Title", Title)
            myCommand.Parameters.AddWithValue("@ThumbURL", ThumbURL)
            myCommand.Parameters.AddWithValue("@LinkStyle", LinkStyle)
            myCommand.Parameters.AddWithValue("@LinkText", LinkText)
            myCommand.Parameters.AddWithValue("@Owner", Owner)
            myCommand.Parameters.AddWithValue("@CampaignID", sCampainID)
            myCommand.Parameters.AddWithValue("@HasTip", HasTip)
            myCommand.Parameters.AddWithValue("@HasInfo", HasInfo)
            myCommand.Parameters.AddWithValue("@CanPrint", CanPrint)
            myCommand.Parameters.AddWithValue("@Tags", Message)
            myCommand.Parameters.AddWithValue("@Height", 1) '[TODO]
            myCommand.Parameters.AddWithValue("@Width", 1)
            myCommand.Parameters.AddWithValue("@AltText", AlternateText)
            myCommand.Parameters.AddWithValue("@TestOnly", TestOnly)
            myCommand.Parameters.Add("@ContentID", SqlDbType.Int)
            myCommand.Parameters("@ContentID").Direction = ParameterDirection.Output

            myCommand.ExecuteNonQuery()

            iContentID = myCommand.Parameters("@ContentID").Value

            Dim myCommand1 = New SqlCommand
            myCommand1.Connection = myConnection
            myCommand1.CommandType = CommandType.StoredProcedure
            myCommand1.CommandText = "sp_ContentPicker_Modify"
            myCommand1.Parameters.AddWithValue("@AutoID", iContentID)
            myCommand1.Parameters.AddWithValue("@Category", sCategory)
            myCommand1.Parameters.AddWithValue("@Group", sGroup)
            myCommand1.Parameters.AddWithValue("@AssociatedPE", sAssociatedPE)
            myCommand1.ExecuteNonQuery()

            ''If MediaType.Contains("Image") Then
            ''    Dim cmdMedGrps As New SqlCommand
            ''    cmdMedGrps.Connection = myConnection
            ''    cmdMedGrps.CommandType = CommandType.StoredProcedure
            ''    cmdMedGrps.CommandText = "sp_MediaGroups_Ins"
            ''    cmdMedGrps.Parameters.AddWithValue("@ContentPickerID", iContentID)
            ''    cmdMedGrps.Parameters.AddWithValue("@Name", GroupName)
            ''    cmdMedGrps.Parameters.AddWithValue("@Title", Title)
            ''    cmdMedGrps.Parameters.AddWithValue("@Caption", Caption)
            ''    cmdMedGrps.Parameters.AddWithValue("@Display", rbldisplayas.Text)
            ''    cmdMedGrps.Parameters.AddWithValue("@Size", rblImgSize.Text)
            ''    cmdMedGrps.Parameters.AddWithValue("@End", rblshowend.Text)
            ''    cmdMedGrps.Parameters.AddWithValue("@GroupItems", MemberIDs)
            ''    cmdMedGrps.ExecuteNonQuery()
            ''    cmdMedGrps.Dispose()
            ''End If

            myCommand.Dispose()
            myCommand1.Dispose()
            myConnection.Close()

            btnSave.Enabled = False

            lblStatus.Text = "Saved: ID " & iContentID.ToString

        Catch ex As Exception
            lblStatus.Text = ex.Message
        End Try

        lblStatus.Text = "Saved: ID " & iContentID.ToString


    End Sub

    Protected Sub btnBuild_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBuild.Click
        Call parseContent()
    End Sub

    Protected Sub btnMsg_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMsg.Click
        Call parseContent()
        Call postData()
        Session("FLOATBOX") = txtFB.Value
        Session("R21CATEGORY") = lstCategory.SelectedValue
        Session("ASSOCIATION") = ddnAssociations.SelectedValue
        Session("INTERESTS") = ddlAssociatedPE.SelectedValue

        Page.ClientScript.RegisterStartupScript(Me.Page.GetType(), "", "window.open('home.aspx','Home','height=800,width=900,top=10,left=200,resizable=yes,scrollbars=yes');", True)
        'Response.Redirect("./home.aspx")
        '[TODO] Open and populate home.aspx
    End Sub

    Protected Sub btnPrevious_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPrevious.Click
        Response.Redirect("./Default.aspx")
        Response.End()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Response.Redirect("./Catalog_JG.aspx", True)
        Response.End()
    End Sub
    ''[TODO] these should be client side (or updatePanel) using OnCheckChanged routine in control attributes
    'Protected Sub rbnLinkThumb_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbnLinkThumb.CheckedChanged
    '    If rbnLinkThumb.Checked Then
    '        txtLinkInfo.Visible = True
    '        cboLinkInfo.Visible = False
    '    End If
    'End Sub
    ''[TODO] this doesn't set anything until after postback... see TODO above in page_load handler
    'Protected Sub cboMedia_SelectedIndexChanged(ByVal sender As Object, ByVal e As Obout.ComboBox.ComboBoxItemEventArgs) Handles cboMedia.SelectedIndexChanged
    '    Select Case cboMedia.SelectedIndex
    '        Case 0 'Video
    '            rbnLinkThumb.Checked = True
    '        Case 1 'R21 Video
    '            rbnLinkThumb.Checked = True 'changed from button 5/31 BD
    '        Case 2 'Image
    '            rbnLinkThumb.Checked = True
    '    End Select
    'End Sub
    ''[TODO] these should be client side (or updatePanel)
    'Protected Sub rbnLinkButton_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbnLinkButton.CheckedChanged
    '    If rbnLinkButton.Checked Then
    '        txtLinkInfo.Visible = False
    '        cboLinkInfo.Visible = True
    '    End If
    'End Sub

    'Protected Sub rbnLinkText_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbnLinkText.CheckedChanged
    '    '6/1 BD changed these to conform to logic
    '    If rbnLinkText.Checked Then
    '        txtLinkInfo.Visible = True
    '        cboLinkInfo.Visible = False
    '    End If
    'End Sub

    Protected Sub cboOwner_SelectedIndexChanged(ByVal sender As Object, ByVal e As Obout.ComboBox.ComboBoxItemEventArgs) Handles cboOwner.SelectedIndexChanged
        If Not String.IsNullOrEmpty(e.Item.Value) Then
            If IsNumeric(e.Item.Value) Then
                ODSConciergeDetail.SelectParameters(0).DefaultValue = CInt(e.Item.Value)

                cboCampaign.Enabled = True
                cboCampaign.Items.Clear()
                cboCampaign.SelectedValue = ""
                cboCampaign.SelectedIndex = -1
                cboCampaign.DataBind()

                Dim gvItem As GridViewRow = gvOwner.Rows(cboOwner.SelectedIndex)
                txtOwnerType.Text = gvItem.Cells(2).Text
            End If

        End If
    End Sub
End Class
