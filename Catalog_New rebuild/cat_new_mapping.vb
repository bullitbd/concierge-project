  Protected Sub postData()
        'Try
        '    If Page.IsValid Then
        Dim iContentID As Integer
        Dim SubmittedBy As String = ddnSubmitted.SelectedValue
        Dim WebSiteURL As String = txtWebsite.Text
        Dim HTMLEmbedTag As String = txtFB.Text
        Dim KeyWords As String = ddlKeyWords.SelectedValue
        Dim InternalNotes As String = txtFbMore.Text
        Dim Message As String = txtTags.Text
        Dim OwnerType As String = ddnOwnerType.SelectedValue
        Dim Description As String = txtDescription.Text
        Dim Caption As String = txtCaption.Text
        Dim MediaURL As String = txtURL.Text
        Dim MediaType As String = ddnMedia.SelectedValue
        Dim Title As String = txtTitle.Text
        Dim ThumbURL As String = txtThumbURL.Text
        Dim LinkStyle As String = ddnLinkStyle.SelectedValue
        Dim LinkText As String = txtLinkText.Text
        Dim Owner As String = ddnOwner.SelectedValue
        Dim AlternateText As String = txtAlt.Text
        Dim HasTip As Boolean = 0
        If chkTip.Checked Then HasTip = 1
        Dim HasInfo As Boolean = 0
        If chkInfo.Checked Then HasInfo = 1
        Dim CanPrint As Boolean = 0
        If chkPrint.Checked Then CanPrint = 1
        ''Dim GroupName As String = ddnGroup.SelectedValue
        ''If GroupName = "New" Then
        ''    GroupName = txtGroupName.Text
        ''End If
        ''Dim MemberIDs As String = ""
        ''Dim I As Integer
        ''For I = 0 To gvwMembers.Rows.Count - 1
        ''    Dim row As GridViewRow = gvwMembers.Rows(I)
        ''    Dim isChecked As Boolean = DirectCast(row.FindControl("chkSelect"), CheckBox).Checked
        ''    If isChecked Then
        ''        MemberIDs = MemberIDs & "," & gvwMembers.Rows(I).Cells(1).Text
        ''    End If
        ''Next
        ''MemberIDs = Mid(MemberIDs, 1)

        Dim sCategory As String = ""
        Dim iCategory As Integer = lstCategory.SelectedIndex
        If iCategory > -1 Then
            Dim lstCatItem As New ListItem
            For Each lstCatItem In lstCategory.Items
                If lstCatItem.Selected Then
                    sCategory = sCategory & lstCatItem.Value & ","
                End If
            Next
        End If
        Dim sGroup As String = ""
        Dim iGroup As Integer = lstGroup.SelectedIndex
        If iGroup > -1 Then
            Dim lstGrpItem As New ListItem
            For Each lstGrpItem In lstGroup.Items
                If lstGrpItem.Selected Then
                    sGroup = sGroup & lstGrpItem.Value & ","
                End If
            Next
        End If
        Dim sAssociatedPE As String = ""
        Dim iPE As Integer = ddlAssociatedPE.SelectedIndex
        If iPE > -1 Then
            Dim lstPEItem As New ListItem
            For Each lstPEItem In ddlAssociatedPE.Items
                If lstPEItem.Selected Then
                    sAssociatedPE = sAssociatedPE & lstPEItem.Value & ","
                End If
            Next
        End If

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
            myCommand.Parameters.AddWithValue("@HasTip", HasTip)
            myCommand.Parameters.AddWithValue("@HasInfo", HasInfo)
            myCommand.Parameters.AddWithValue("@CanPrint", CanPrint)
            myCommand.Parameters.AddWithValue("@Tags", Message)
            myCommand.Parameters.AddWithValue("@Height", 1) '[TODO]
            myCommand.Parameters.AddWithValue("@Width", 1)
            myCommand.Parameters.AddWithValue("@AltText", AlternateText)
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

            btnSubmit.Enabled = False

            lblStatus.Text = "Record saved successfully | ContentID: " & iContentID.ToString

        Catch ex As Exception
            lblStatus.Text = ex.Message
        End Try

        lblStatus.Text = "Record saved successfully | ContentID: " & iContentID.ToString

        '    End If
        'Catch ex As Exception
        '    lblStatus.Text = ex.Message
        '    lblStatus.ForeColor = Drawing.Color.Red
        'End Try

    End Sub