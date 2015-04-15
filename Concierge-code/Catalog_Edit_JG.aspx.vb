Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports DataAccess
Imports System.Web.HttpUtility
Partial Class Catalog_Edit_JG
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


    Dim sContent As String
    Dim sURL As String

    Dim sWebSite As String
    Dim sCaption As String
    Dim sCaption1 As String

    Dim sLinkStyle As String = ""

    Dim parsePass As Integer = 0 'parse function counter
    Protected Sub parseContent()
        Dim iPercent As Integer
        iPercent = CInt(txtPct.Text)
        sContent = txtContent.Text

        '// Parse sContent relative to media type...

        'Reference class
        Dim oParse As New ParseEmbed
        'oParse = New ParseEmbed(sContent, cboMedia.SelectedIndex + 1, iPercent)
        With oParse
            .mtype = cboMedia.SelectedIndex + 1
            .pct = iPercent
            .sdate = sFileDate
            .title = txtTitle.Text
            .input = sContent
        End With

        '// Make collection & call the parse class, return collection oParse.results
        Dim oVars As New Dictionary(Of String, String)

        '// Copy oParse.results into local oVars
        oVars = oParse.results

        '// Assign oVars to local vars
        sURL = oVars("url")
        'If parsePass = 0 Then  'Check for existence - if none there, allow entry.
        If oVars("thumb").IndexOf("http://") = 0 Then
            sThumb = oVars("thumb")
            'End If
            'Else
            'If oVars("thumb") = txtThumbURL.Text Then
            'sThumb = oVars("thumb")
        Else
            '[TODO??] sThumb = txtThumbURL.Text
        End If

        'End If
        sWebSite = oVars("web")
        sHeight = oVars("height")
        sWidth = oVars("width")
        'sRatio = oVars("ratio")
        parsePass += 1
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
            .mediaType = Trim(cboMedia.SelectedText)
            .mediaURL = sURL
            .height = sHeight
            .width = sWidth
            .size = ImageSize()
            .thumb = sThumb
            .title = txtTitle.Text
            .caption = txtCaption.Text
            .tip = "" 'txtTip.Text
            .infoLink = "" 'txtInfoLink.Text
            .print = "" 'txtPrint.Text
            '[TODO] add commented out Alt checkbox and popup field;  for now, default to Title
            .alt = txtTitle.Text  'txtAlt.Text

            '[TODO] !Put in function! and flesh out procedure. linkType and linkText refer to rbgLinkStyle button group ("Link")
            'and cboLinkInfo.  See notes at bottom of Use Case Document

            Select Case True
                Case rbnLinkThumb.Checked
                    sLinkStyle = "Thumbnail"
                Case rbnLinkButton.Checked
                    sLinkStyle = "Button"
                Case rbnLinkText.Checked
                    sLinkStyle = "Text"
            End Select
            .linkType = sLinkStyle
            .linkText = txtLinkInfo.Text
        End With

        sText = buildFB.getFB()

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
        txtWebsite.Text = sWebSite
        'txtWidth.Text = sWidth
        'txtHeight.Text = sHeight
        ''txtPercent.Text = sPercent
        ''txtRatio.Text = sRatio
        txtURL.Text = sURL
        txtThumbURL.Text = sThumb 'can be thumbUrl or button text or inline text...
        ' ''Else
        ''chkHasGroup.Enabled = False

        ''End If

    End Sub 'assembleFB
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            pnlShowCustom.Style.Add("visibility", "hidden")

            If (Request.Cookies("LoginAuth") Is Nothing) Then
                Response.Redirect("~/Login.aspx")
            End If

            Dim sSQL As String
            Dim CID As Integer
            CID = Request.QueryString("id")
            sSQL = "SELECT * FROM [ContentPicker] WHERE AutoID = " & CID
            Dim cdt As DataTable = GetData(sSQL)

            txtPct.Text = sPercent
            txtDescription.Text = FixDBNull(cdt.Rows(0)("Description").ToString)
            txtTitle.Text = FixDBNull(cdt.Rows(0)("Title").ToString)
            txtCaption.Text = FixDBNull(cdt.Rows(0)("Caption").ToString)
            ddlKeywords.Text = FixDBNull(cdt.Rows(0)("Keywords").ToString)
            txtOwnerType.Text = FixDBNull(cdt.Rows(0)("OwnerType").ToString)
            txtContent.Text = FixDBNull(cdt.Rows(0)("HTMLEmbedTag").ToString)
            cboMedia.SelectedValue = FixDBNull(cdt.Rows(0)("MediaType").ToString)
            cboSubmitted.SelectedValue = LCase(FixDBNull(cdt.Rows(0)("SubmittedBy").ToString))
            txtLinkInfo.Text = FixDBNull(cdt.Rows(0)("LinkText").ToString)
            txtNotes.Text = FixDBNull(cdt.Rows(0)("InternalNotes").ToString)

            Call PopulateListBox("ddlAssociatedPE", ddlAssociatedPE, CID)
            Call PopulateListBox("lstCategory", lstCategory, CID)
            Call PopulateListBox("ddnAssociations", ddnAssociations, CID)
            Call PopulateListBox("cboOwner", cboOwner, FixDBNull(cdt.Rows(0)("Owner").ToString))
            Call PopulateListBox("cboCampaign", cboCampaign, FixDBNull(cdt.Rows(0)("CampaignID").ToString))

            txtURL.Text = FixDBNull(cdt.Rows(0)("MediaURL").ToString)
            txtWebsite.Text = FixDBNull(cdt.Rows(0)("WebSiteURL").ToString)
            'txtFbMore.Text = FixDBNull(cdt.Rows(0)("InternalNotes").ToString)
            'txtTags.Text = FixDBNull(cdt.Rows(0)("Message").ToString)
            txtFB.Value = FixDBNull(cdt.Rows(0)("HTMLEmbedTag").ToString)
            'txtTitle.Text = FixDBNull(cdt.Rows(0)("Title").ToString)
            txtThumbURL.Text = FixDBNull(cdt.Rows(0)("ThumbURL").ToString)
            'txtLinkText.Text = FixDBNull(cdt.Rows(0)("LinkText").ToString)
            'txtAlt.Text = FixDBNull(cdt.Rows(0)("AltText").ToString)

            litPreview.Text = FixDBNull(cdt.Rows(0)("HTMLEmbedTag").ToString)
            If cdt.Rows(0)("has_info") Then
                chkInfo.Checked = True
            End If
            If cdt.Rows(0)("has_tip") Then
                chkTip.Checked = True
            End If
            If cdt.Rows(0)("can_print") Then
                chkPrint.Checked = True
            End If
            txtPrint.Text = FixDBNull(cdt.Rows(0)("canprint_text").ToString)
            txtTip.Text = FixDBNull(cdt.Rows(0)("hastip_text").ToString)
            txtInfoLink.Text = FixDBNull(cdt.Rows(0)("hasinfo_text").ToString)
            If cdt.Rows(0)("TestOnly") Then
                chkTestOnly.Checked = True
            End If
            'Call PopulateDropDown(ddnMedia, PopulateDropDownContent("ddnMedia"), FixDBNull(cdt.Rows(0)("MediaType").ToString))
            'Call PopulateDropDown(ddnSubmitted, PopulateDropDownContent("ddnSubmitted"), FixDBNull(cdt.Rows(0)("SubmittedBy").ToString))
            'Call PopulateDropDown(ddnLinkStyle, PopulateDropDownContent("ddnLinkStyle"), FixDBNull(cdt.Rows(0)("LinkStyle").ToString))
            'Call PopulateDropDown(ddnOwnerType, PopulateDropDownContent("ddnOwnerType"), FixDBNull(cdt.Rows(0)("OwnerType").ToString))
            'Call PopulateDropDown(ddnOwner, PopulateDropDownContent("ddnOwner"), FixDBNull(cdt.Rows(0)("Owner").ToString))

            'ddnGroup.Items.Add("g_name")
            'ddnCampaign.Items.Add("Campaign")
            cdt.Dispose()


        End If
    End Sub

    Private Sub PopulateListBox(ByVal lstName As String, ByVal lstBoxFrom As Obout.ComboBox.ComboBox, ByVal id As Integer)

        Dim sSQL As String = ""
        If lstName = "lstCategory" Then
            sSQL = "SELECT ic.id, ic.name, 'Selected' Selected FROM ConciergeCategory cc JOIN R21EY.interest_categories ic ON cc.CategoryID = ic.id WHERE cc.ContentPicketID = " & id & " "
            sSQL = sSQL + "UNION SELECT [id], [name], 'NotSelected' FROM [Rocket21].[R21EY].[interest_categories] "
            sSQL = sSQL + "WHERE id NOT IN (SELECT ic.id FROM ConciergeCategory cc JOIN R21EY.interest_categories ic ON cc.CategoryID = ic.id WHERE cc.ContentPicketID = " & id & ") "
            sSQL = sSQL + "ORDER BY Selected DESC"
        ElseIf lstName = "ddnAssociations" Then
            sSQL = "SELECT ic.id, ic.name, 'Selected' Selected FROM ConciergeGroup cc JOIN R21EY.interest_groups ic ON cc.GroupID = ic.id WHERE cc.ContentPicketID = " & id & " "
            sSQL = sSQL + "UNION SELECT [id], [name], 'NotSelected' FROM [Rocket21].[R21EY].[interest_groups] "
            sSQL = sSQL + "WHERE id NOT IN (SELECT ic.id FROM ConciergeGroup cc JOIN R21EY.interest_groups ic ON cc.GroupID = ic.id WHERE cc.ContentPicketID = " & id & ") "
            sSQL = sSQL + "ORDER BY Selected DESC"
        ElseIf lstName = "ddlAssociatedPE" Then
            sSQL = " SELECT ic.id, ic.name, 'Selected' Selected FROM ConciergePE cc JOIN R21EY.interests ic ON cc.PeID = ic.id WHERE cc.ContentPicketID = " & id & " "
            sSQL = sSQL + "UNION SELECT [id], [name], 'NotSelected' FROM [Rocket21].[R21EY].[interests] "
            sSQL = sSQL + "WHERE id NOT IN (SELECT ic.id FROM ConciergePE cc JOIN R21EY.interests ic ON cc.PeID = ic.id WHERE cc.ContentPicketID = " & id & ") "
            sSQL = sSQL + "ORDER BY Selected DESC"
        ElseIf lstName = "cboOwner" Then
            sSQL = "SELECT OwnerID id, OwnerName name FROM vw_Concierge_Owner_Campaign ORDER BY OwnerID"
            'sSQL = "SELECT OwnerID id, OwnerName name, 'Selected' Selected FROM vw_Concierge_Owner_Campaign WHERE OwnerID = " & id & " GROUP BY OwnerID, OwnerName,OwnerType "
            'sSQL = sSQL + "UNION SELECT OwnerID id, OwnerName name, 'NotSelected'  FROM vw_Concierge_Owner_Campaign WHERE OwnerID <> " & id & " GROUP BY OwnerID, OwnerName,OwnerType "
            'sSQL = sSQL + "ORDER BY Selected DESC,name"
        Else
            sSQL = "SELECT CampaignId id ,CampaignName name, 'Selected' Selected FROM vw_Concierge_Owner_Campaign ORDER BY CampaignId"
            'sSQL = "SELECT CampaignId id ,CampaignName name, 'Selected' Selected FROM vw_Concierge_Owner_Campaign WHERE CampaignId = " & id & " UNION "
            'sSQL = "SELECT CampaignId id ,CampaignName name,'NotSelected' Selected FROM vw_Concierge_Owner_Campaign WHERE CampaignId <> " & id & " ORDER BY Selected DESC,id"

        End If

        lstBoxFrom.DataSource = GetData(sSQL)
        lstBoxFrom.DataTextField = "name"
        lstBoxFrom.DataValueField = "id"
        lstBoxFrom.DataBind()

        If lstName = "cboOwner" Or lstName = "cboCampaign" Then
            For I As Integer = 0 To lstBoxFrom.Items.Count - 1
                If lstBoxFrom.Items(I).Value = id Then
                    lstBoxFrom.SelectedIndex = I
                    Exit For
                End If
            Next
        Else
            Dim dt As DataTable = GetData(sSQL)
            Dim SelectedIndices As String = ""
            For i = 0 To dt.Rows.Count - 1
                If dt.Rows(i)(2).ToString = "Selected" Then
                    SelectedIndices = SelectedIndices & "," & i.ToString
                End If
            Next
            If SelectedIndices <> "" Then
                SelectedIndices = Mid(SelectedIndices, 2)
            End If
            lstBoxFrom.SelectedIndexes = SelectedIndices
        End If
    End Sub

    Private Sub PopulateDropDown(ByVal drpName As DropDownList, ByVal sMembers As String, ByVal sSelected As String)

        Dim MyArray() As String = Split(sMembers, ",")
        drpName.DataSource = MyArray
        drpName.DataBind()
        For I As Integer = 0 To UBound(MyArray)
            If Trim(MyArray(I)) = Trim(sSelected) Then
                drpName.SelectedIndex = I
            End If
        Next
    End Sub

    Private Function PopulateDropDownContent(ByVal drpName As String) As String
        Dim sResult As String = ""
        Dim I As Integer
        Dim sSQL As String = ""
        If drpName = "ddnSubmitted" Then
            sSQL = "SELECT DISTINCT [SubmittedBy] FROM [ContentPicker]"
        ElseIf drpName = "ddnOwner" Then
            sSQL = "SELECT DISTINCT [Owner] FROM [ContentPicker]"
        ElseIf drpName = "ddnOwnerType" Then
            sSQL = "SELECT DISTINCT [OwnerType] FROM [ContentPicker]"
        ElseIf drpName = "ddnMedia" Then
            sSQL = "SELECT DISTINCT [MediaType] FROM [ContentPicker]"
        Else
            sSQL = "SELECT DISTINCT [LinkStyle] FROM [ContentPicker]"
        End If
        Dim odt As DataTable = GetData(sSQL)
        For I = 0 To odt.Rows.Count - 1
            sResult = sResult & "," & odt.Rows(I)(0).ToString
        Next
        If sResult <> "" Then
            sResult = Mid(sResult, 2)
        End If

        Return sResult
    End Function

    Private Function FixDBNull(ByVal sName As String) As String
        Dim sReturn As String = ""
        If Not IsDBNull(sName) Then
            sReturn = sName
        End If
        Return sReturn
    End Function

    Protected Sub btnBuild_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBuild.Click
        Call parseContent()
    End Sub

    Protected Sub btnModify_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnModify.Click
        Call ModifyContent()
    End Sub

    Private Sub ModifyContent()
        Dim sDescription As String = txtDescription.Text
        Dim sCaption As String = txtCaption.Text
        Dim sKeywords As String = ddlKeywords.Text
        Dim sMediaURL As String = txtURL.Text
        Dim sWebSiteURL As String = txtWebsite.Text
        Dim sInternalNotes As String = txtNotes.Text
        Dim sMessage As String = ""
        Dim sHTMLEmbedTag As String = txtFB.Value
        Dim sMediaType As String = cboMedia.SelectedValue
        Dim sTitle As String = txtTitle.Text
        Dim sThumbURL As String = txtThumbURL.Text
        Dim sLinkStyle As String = ""
        If rbnLinkThumb.Checked Then
            sLinkStyle = "Thumbnail"
        End If
        If rbnLinkButton.Checked Then
            sLinkStyle = "Button"
        End If
        If rbnLinkText.Checked Then
            sLinkStyle = "Text"
        End If
        Dim sLinkText As String = txtLinkInfo.Text
        Dim sAltText As String = txtTitle.Text
        Dim sOwner As String = cboOwner.SelectedValue
        Dim sCampainID As String = cboCampaign.SelectedValue
        Dim sOwnerType As String = txtOwnerType.Text
        Dim sSubmittedBy As String = cboSubmitted.SelectedValue

        Dim sCategory As String = lstCategory.SelectedValue
        Dim sGroup As String = ddnAssociations.SelectedValue
        Dim sAssociatedPE As String = ddlAssociatedPE.SelectedValue

        Dim blnHasTip As Boolean = chkTip.Checked
        Dim blnHasInfo As Boolean = chkInfo.Checked
        Dim blnCanPrint As Boolean = chkPrint.Checked

        Dim sHasTipText As String = txtTip.Text
        Dim sHasInfoText As String = txtInfoLink.Text
        Dim sCanPrintText As String = txtPrint.Text

        Dim blnTestOnly As Boolean = chkTestOnly.Checked

        Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString
        Try
            Dim myConnection = New SqlConnection(sConn)
            myConnection.Open()
            Dim myCommand = New SqlCommand
            myCommand.Connection = myConnection
            myCommand.CommandType = CommandType.StoredProcedure
            myCommand.CommandText = "sp_ContentPicker_upd"
            'parameters required for the stpred procedure
            myCommand.Parameters.AddWithValue("@AutoID", Request.QueryString("id"))
            myCommand.Parameters.AddWithValue("@Caption", sCaption)
            myCommand.Parameters.AddWithValue("@Description", sDescription)
            myCommand.Parameters.AddWithValue("@Message", sMessage)
            myCommand.Parameters.AddWithValue("@MediaURL", sMediaURL)
            myCommand.Parameters.AddWithValue("@WebSiteURL", sWebSiteURL)
            myCommand.Parameters.AddWithValue("@HTMLEmbedTag", sHTMLEmbedTag)
            myCommand.Parameters.AddWithValue("@KeyWords", sKeywords)
            myCommand.Parameters.AddWithValue("@InternalNotes", sInternalNotes)
            myCommand.Parameters.AddWithValue("@OwnerType", sOwnerType)
            myCommand.Parameters.AddWithValue("@MediaType", sMediaType)
            myCommand.Parameters.AddWithValue("@Title", sTitle)
            myCommand.Parameters.AddWithValue("@ThumbURL", sThumbURL)
            myCommand.Parameters.AddWithValue("@LinkStyle", sLinkStyle)
            myCommand.Parameters.AddWithValue("@LinkText", sLinkText)
            myCommand.Parameters.AddWithValue("@Owner", sOwner)
            myCommand.Parameters.AddWithValue("@CampaignID", sCampainID)
            myCommand.Parameters.AddWithValue("@SubmittedBy", sSubmittedBy)
            myCommand.Parameters.AddWithValue("@AltText", sAltText)

            myCommand.Parameters.AddWithValue("@Category", sCategory)
            myCommand.Parameters.AddWithValue("@Group", sGroup)
            myCommand.Parameters.AddWithValue("@AssociatedPE", sAssociatedPE)
            myCommand.Parameters.AddWithValue("@hastip", blnHasTip)
            myCommand.Parameters.AddWithValue("@hasinfo", blnHasInfo)
            myCommand.Parameters.AddWithValue("@canprint", blnCanPrint)
            myCommand.Parameters.AddWithValue("@hastiptext", sHasTipText)
            myCommand.Parameters.AddWithValue("@hasinfotext", sHasInfoText)
            myCommand.Parameters.AddWithValue("@canprinttext", sCanPrintText)
            myCommand.Parameters.AddWithValue("@TestOnly", blnTestOnly)

            myCommand.ExecuteNonQuery()

            lblStatus.Text = "Content Modified successfully."
            'Panel1.Visible = True
            'Panel2.Visible = False
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub postData()

        If rbnLinkThumb.Checked Then
            sLinkStyle = "Thumbnail"
        End If
        If rbnLinkButton.Checked Then
            sLinkStyle = "Button"
        End If
        If rbnLinkText.Checked Then
            sLinkStyle = "Text"
        End If

        Dim iContentID As Integer
        Dim SubmittedBy As String = cboSubmitted.SelectedValue
        Dim WebSiteURL As String = txtWebsite.Text
        Dim HTMLEmbedTag As String = txtFB.Value
        Dim KeyWords As String = ddlKeywords.Text
        Dim InternalNotes As String = txtNotes.Text
        Dim Message As String = "" 'txtTags.Text
        Dim OwnerType As String = txtOwnerType.Text
        Dim Description As String = txtDescription.Text
        Dim Caption As String = txtCaption.Text
        Dim MediaURL As String = txtURL.Text
        Dim MediaType As String = cboMedia.SelectedValue
        Dim Title As String = txtTitle.Text
        Dim ThumbURL As String = txtThumbURL.Text '[TODO] sort out which of these need be stored - sLinkText actually has all the info
        Dim LinkStyle As String = sLinkStyle
        Dim LinkText As String = txtLinkInfo.Text
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

            lblStatus.Text = "Saved: ID " & iContentID.ToString

        Catch ex As Exception
            lblStatus.Text = ex.Message
        End Try

    End Sub


    Protected Sub btnSaveAs_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveAs.Click
        postData()
    End Sub
End Class