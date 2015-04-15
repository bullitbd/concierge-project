Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports DataAccess
Imports System.Web.HttpUtility
Imports System.Net
Imports System.IO
Partial Class Template_Create
    Inherits System.Web.UI.Page

    Protected Sub btnCreateTemplate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateTemplate.Click
        Dim sError As String = ""
        Dim TemplateName As String = "", IconURL As String = "", WrapperText As String = "", Title As String = "", Body As String = ""
        TemplateName = Trim(txtTemplateName.Text)
        IconURL = Trim(cboIconURL.SelectedValue)
        WrapperText = Trim(txtWrapper.Text)
        Title = Trim(txtTitle.Text)
        Body = Trim(Editor.Content)

        If TemplateName = "" And sError = "" Then
            sError = "Template Name cannot be blank."
            txtTemplateName.BorderColor = Drawing.Color.Red
        Else
            txtTemplateName.BorderColor = Drawing.Color.Black
        End If

        If IconURL = "0" And sError = "" Then
            sError = "Please select an Icon URL."
            cboIconURL.BorderColor = Drawing.Color.Red
        Else
            cboIconURL.BorderColor = Drawing.Color.Black
        End If

        If WrapperText = "" And sError = "" Then
            sError = "Wrapper Text cannot be blank."
            txtWrapper.BorderColor = Drawing.Color.Red
        Else
            txtWrapper.BorderColor = Drawing.Color.Black
        End If

        If Title = "" And sError = "" Then
            sError = "Title cannot be blank."
            txtTitle.BorderColor = Drawing.Color.Red
        Else
            txtTitle.BorderColor = Drawing.Color.Black
        End If

        If Body = "" And sError = "" Then
            sError = "Body cannot be blank."
            Editor.BorderColor = Drawing.Color.Red
        Else
            Editor.BorderColor = Drawing.Color.Black
        End If
        If sError <> "" Then
            lblStatus.Text = sError
            lblStatus.Visible = True
        Else
            Dim TID As Integer, HiTID As Integer
            HiTID = HidID.Value
            TID = InsertTemplate(TemplateName, IconURL, WrapperText, Title, Body, HiTID)
            If TID = 0 Then
                lblStatus.Text = "Template with the same name already exists."
            ElseIf TID = HiTID Then
                lblStatus.Text = "Template modified successfully."
            Else
                HidID.Value = TID.ToString
                lblStatus.Text = "Template created successfully. Template ID: " & TID.ToString
            End If
            lblStatus.Visible = True
        End If

    End Sub

    Private Function InsertTemplate(ByVal TemplateName As String, ByVal IconURL As String, ByVal WrapperText As String, ByVal Title As String, ByVal Body As String, ByVal HiddenID As String) As Integer
        Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString
        Dim TemplateID As Integer
        Try
            Dim myConnection = New SqlConnection(sConn)
            myConnection.Open()
            Dim cmdTemplate As New SqlCommand
            cmdTemplate.Connection = myConnection
            cmdTemplate.CommandType = CommandType.StoredProcedure
            cmdTemplate.CommandText = "sp_ConciergeTemplate_ins"
            cmdTemplate.Parameters.AddWithValue("@created_by", "Admin")
            cmdTemplate.Parameters.AddWithValue("@TemplateName", TemplateName)
            cmdTemplate.Parameters.AddWithValue("@icon_url", IconURL)
            cmdTemplate.Parameters.AddWithValue("@wrapper_text", WrapperText)
            cmdTemplate.Parameters.AddWithValue("@title", Title)
            cmdTemplate.Parameters.AddWithValue("@body", Body)
            cmdTemplate.Parameters.AddWithValue("@hiddenid", HiddenID)
            cmdTemplate.Parameters.Add("@TemplateID", SqlDbType.Int)
            cmdTemplate.Parameters("@TemplateID").Direction = ParameterDirection.Output
            cmdTemplate.ExecuteNonQuery()
            TemplateID = cmdTemplate.Parameters("@TemplateID").Value
            cmdTemplate.Dispose()
            myConnection.Close()
        Catch ex As Exception
            lblStatus.Text = ex.Message
            lblStatus.Visible = True
        End Try

        Return TemplateID
    End Function

    Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
        If Not IsPostBack Then
            If Request.QueryString.Count > 0 Then
                If Not (Request.QueryString("id") Is Nothing) Then
                    Dim sSQL As String = "SELECT * FROM ConciergeTemplate WHERE TemplateID = " & Request.QueryString("id")
                    Dim sData As DataTable = GetData(sSQL)
                    If sData.Rows.Count > 0 Then
                        cboIconURL.SelectedValue = sData.Rows(0)("icon_url").ToString
                        txtWrapper.Text = sData.Rows(0)("wrapper_text").ToString
                        HidID.Value = sData.Rows(0)("TemplateID").ToString
                        txtTitle.Text = sData.Rows(0)("title").ToString
                        Editor.Content = sData.Rows(0)("body").ToString
                        txtTemplateName.Text = sData.Rows(0)("TemplateName").ToString
                    End If
                End If
            Else
                cboIconURL.SelectedIndex = 0
                ddnTemplate.SelectedIndex = 0
                txtWrapper.Text = "R21 RECOMMENDS"
                HidID.Value = 0
                imgDelete.Attributes.Add("onclick", "return DeleteTemplate()")

                'Dim MyIcons = New Hashtable
                'MyIcons.Add("http://s3.amazonaws.com/r21concierge/images/concierge.png", "http://s3.amazonaws.com/r21concierge/images/concierge.png")
                'MyIcons.Add("http://s3.amazonaws.com/r21concierge/images/concierge_01.png", "http://s3.amazonaws.com/r21concierge/images/concierge_01.png")
                'MyIcons.Add("http://s3.amazonaws.com/r21concierge/images/concierge_02.png", "http://s3.amazonaws.com/r21concierge/images/concierge_02.png")

                'Dim sSQL As String = "select TemplateID, TemplateName  from dbo.ConciergeTemplate"
                'Dim sData As DataTable = GetData(sSQL)
                'cboIconURL.DataSource = sData
                'cboIconURL.DataTextField = "TemplateName"
                'cboIconURL.DataValueField = "TemplateName"
                'cboIconURL.DataBind()
                'cboIconURL.ShowSelectedImage = True
                'cboIconURL.DataSource = MyIcons
                'cboIconURL.DataTextField = "key"
                'cboIconURL.DataValueField = "value"
                'cboIconURL.DataBind()

            End If
        End If
    End Sub

    Protected Sub btnPreview_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPreview.Click
        Try
            'Exit Sub
            Dim postData As String
            Dim APIKey As String = "123"
            Dim APIURL As String = ""
            Dim SenderName As String = "Concierge"
            Dim IconURL As String = cboIconURL.SelectedValue
            Dim WrapperText As String = ""
            Dim Subject As String = ""
            Dim Msg As String = ""
            Dim Media As String = ""
            Dim RecID As String = "18"
            Subject = txtTitle.Text
            Msg = Regex.Replace(Editor.Content, "<br\s?\/>\s*(<br\s?\/>){1,2}", "</p><p>")
            WrapperText = txtWrapper.Text
            Media = ""
            APIURL = "http://2ndstage.rocket21.com/admin/concierge_messages"


            'Response.Write(SenderName & "<br>")
            'Response.Write(IconURL & "<br>")
            'Response.Write(WrapperText & "<br>")
            'Response.Write(Title & "<br>")
            'Response.Write(Msg & "<br>")
            'Response.Write(Media & "<br>")
            'Response.End()

            'build postData string
            postData = "api_key=" & APIKey
            postData += "&sender_name=" & SenderName
            postData += "&icon_url=" & IconURL
            postData += "&wrapper_text=" & HttpUtility.UrlEncode(WrapperText)
            postData += "&title=" & HttpUtility.UrlEncode(Subject)
            postData += "&body=" & HttpUtility.UrlEncode(Msg)
            'postData += "&media_text=" & Media
            postData += "&media_text=" & HttpUtility.UrlEncode(Media)
            postData += "&recipient_ids=" & RecID
            'postData += "&public=" & IsPublic

            Dim encoding As New ASCIIEncoding
            Dim data() As Byte = encoding.GetBytes(postData)

            'prepare web request
            Dim myReqeust As WebRequest = WebRequest.Create(APIURL)
            myReqeust.Method = "POST"
            myReqeust.ContentType = "application/x-www-form-urlencoded"
            myReqeust.ContentLength = data.Length

            Dim newSteam As Stream = myReqeust.GetRequestStream
            'send the data
            newSteam.Write(data, 0, data.Length)
            'close stream
            newSteam.Close()

            Dim iSeed As Integer = Today.Year + Today.Month + Today.Day + Today.Hour + Today.Minute + Today.Second
            Dim strRandom As String = New Random(iSeed).Next.ToString
            Dim strURL As String = """http://2ndstage.rocket21.com/workspaces/child#child=tab1&rnd=" & strRandom & """"

            Dim sb As New StringBuilder
            sb.Append("<script>")
            sb.Append("var sURL = " & strURL & ";")
            sb.Append("var width = 800;")
            sb.Append("var height = 600;")
            sb.Append("var left = screen.availWidth;")
            sb.Append("var top = 0;")
            sb.Append("var windowFeatures = ""width="" + width + "",height="" + height + "",status,resizable=yes,scrollbars=yes,left="" + left + "",top="" + top + ""screenX="" + left + "",screenY="" + top;")
            sb.Append("new_window = window.open(sURL, 'preview', windowFeatures);")
            sb.Append("new_window.focus();")

            'sb.Append("var left = parseInt((screen.availWidth / 2) - (width / 2));")
            'sb.Append("var top = parseInt((screen.availHeight / 2) - (height / 2));")
            'sb.Append("var sURL = ""http://2ndstage.rocket21.com/workspaces/child#child=tab1"";")
            'sb.Append("var sURL = " & strURL & ";")
            'sb.Append("var windowFeatures = ""dialogWidth:"" + width + ""px;dialogHeight:"" + height + ""px;dialogLeft:"" + left + ""px;dialogTop:"" + top + ""px;"";")
            'sb.Append("var windowFeatures = ""dialogWidth:1024px;dialogHeight:640px;dialogLeft:10px;dialogTop:10px;"";")
            'sb.Append("var windowFeatures = ""dialogWidth:"" + 1024 + ""px;"" + ""dialogHeight:"" + 640 + ""px;"" + ""dialogLeft:"" + 10 + ""px;"" + ""dialogTop:"" + 10 + ""px;"" + ""status:yes;resizable:yes;scroll:no;"";")

            'sb.Append("window.showModalDialog(sURL, ""subWind"", windowFeatures);")
            'sb.Append("myWindow = window.open(""http://2ndstage.rocket21.com/workspaces/child#child=tab1"", ""subWind"", windowFeatures);")

            'sb.Append("myWindow.focus();")
            'sb.Append("return true;")
            'sb.Append("window.open('http://2ndstage.rocket21.com/workspaces/child#child=tab1', '', '');")
            sb.Append("</scri")
            sb.Append("pt>")

            Page.ClientScript.RegisterStartupScript(Me.GetType(), "JSScript", sb.ToString())

        Catch ex As Exception
            Response.Write("<b>" & ex.Message & "</b>")
        End Try

    End Sub

    Protected Sub btnNewTemplate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewTemplate.Click
        cboIconURL.SelectedValue = "0"
        ddnTemplate.SelectedValue = "111111"
        HidID.Value = 0
        txtTemplateName.Text = ""
        txtTitle.Text = ""
        Editor.Content = ""
        lblStatus.Text = ""
        lblStatus.Visible = False
    End Sub

    'Protected Sub cboIconURL_ItemDataBound(ByVal sender As Object, ByVal e As Obout.ComboBox.ComboBoxItemEventArgs) Handles cboIconURL.ItemDataBound
    '    'If Not IsPostBack Then
    '    '    e.Item.ImageUrl = e.Item.DataItem("IconURL")
    '    'End If
    'End Sub


    'Protected Sub ComboBox2_ItemDataBound(ByVal sender As Object, ByVal e As Obout.ComboBox.ComboBoxItemEventArgs) Handles ComboBox2.ItemDataBound
    '    e.Item.ImageUrl = DataBinder.Eval(e.Item.DataItem, "IconURL").ToString()
    'End Sub

    'Protected Sub cboTemplate_SelectedIndexChanged(ByVal sender As Object, ByVal e As Obout.ComboBox.ComboBoxItemEventArgs) Handles cboTemplate.SelectedIndexChanged
    '    Dim sSQL As String = "SELECT * FROM ConciergeTemplate WHERE TemplateID = " & e.Item.Value
    '    If e.Item.Value = "111111" Then
    '        cboIconURL.SelectedValue = ""
    '        txtWrapper.Text = ""
    '        HidID.Value = 0
    '        txtTitle.Text = ""
    '        Editor.Content = ""
    '        txtTemplateName.Text = ""
    '        lblStatus.Text = ""
    '        lblStatus.Visible = False
    '        Exit Sub
    '    Else
    '        Dim sData As DataTable = GetData(sSQL)
    '        If sData.Rows.Count > 0 Then
    '            cboIconURL.SelectedValue = sData.Rows(0)("icon_url").ToString
    '            txtWrapper.Text = sData.Rows(0)("wrapper_text").ToString
    '            HidID.Value = sData.Rows(0)("TemplateID").ToString
    '            txtTitle.Text = sData.Rows(0)("title").ToString
    '            Editor.Content = sData.Rows(0)("body").ToString
    '            txtTemplateName.Text = sData.Rows(0)("TemplateName").ToString
    '            lblStatus.Text = ""
    '            lblStatus.Visible = False

    '        End If
    '    End If
    'End Sub

    Protected Sub btnSaveAs_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveAs.Click
        Dim sError As String = ""
        Dim TemplateName As String = "", IconURL As String = "", WrapperText As String = "", Title As String = "", Body As String = ""
        TemplateName = Trim(txtTemplateName.Text)
        IconURL = Trim(cboIconURL.SelectedValue)
        WrapperText = Trim(txtWrapper.Text)
        Title = Trim(txtTitle.Text)
        Body = Trim(Editor.Content)

        If TemplateName = "" And sError = "" Then
            sError = "Template Name cannot be blank."
            txtTemplateName.BorderColor = Drawing.Color.Red
        Else
            txtTemplateName.BorderColor = Drawing.Color.Black
        End If

        If IconURL = "" And sError = "" Then
            sError = "Please select an Icon URL."
            cboIconURL.BorderColor = Drawing.Color.Red
        Else
            cboIconURL.BorderColor = Drawing.Color.Black
        End If

        If WrapperText = "" And sError = "" Then
            sError = "Wrapper Text cannot be blank."
            txtWrapper.BorderColor = Drawing.Color.Red
        Else
            txtWrapper.BorderColor = Drawing.Color.Black
        End If

        If Title = "" And sError = "" Then
            sError = "Title cannot be blank."
            txtTitle.BorderColor = Drawing.Color.Red
        Else
            txtTitle.BorderColor = Drawing.Color.Black
        End If

        If Body = "" And sError = "" Then
            sError = "Body cannot be blank."
            Editor.BorderColor = Drawing.Color.Red
        Else
            Editor.BorderColor = Drawing.Color.Black
        End If
        If sError <> "" Then
            lblStatus.Text = sError
            lblStatus.Visible = True
        Else
            Dim TID As Integer, HiTID As Integer
            HiTID = 0
            If Not CheckTemplate(TemplateName) Then
                TID = InsertTemplate(TemplateName, IconURL, WrapperText, Title, Body, HiTID)
                HidID.Value = TID.ToString
                lblStatus.Text = "Template created successfully. Template ID: " & TID.ToString
            Else
                lblStatus.Text = "Template with the same name exists."
            End If
            
            lblStatus.Visible = True
        End If
    End Sub

    Private Function CheckTemplate(ByVal sTemplateName As String) As Boolean
        Dim blnOut As Boolean = False
        Dim sSQL As String = "SELECT COUNT(*) FROM ConciergeTemplate WHERE TemplateName = '" & sTemplateName.Replace("'", "''") & "'"
        Dim sData As DataTable = GetData(sSQL)
        If sData.Rows.Count > 0 Then
            If sData.Rows(0)(0) = 0 Then
                blnOut = False
            Else
                blnOut = True
            End If
        End If
        sData.Dispose()
        Return blnOut
    End Function

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Try
            Dim AutoID As String = GridView1.SelectedRow.Cells(1).Text
            Dim sType As String = GridView1.SelectedRow.Cells(5).Text
            Dim sSQL As String = ""
            If sType <> "Group" Then
                sSQL = "SELECT HTMLEmbedTag FROM Rocket21.dbo.ContentPicker WHERE AutoID = " + AutoID
            Else '
                sSQL = "SELECT FlotBoxText AS HTMLEmbedTag FROM Rocket21.dbo.MediaGroups WHERE GroupID = " + AutoID
            End If
            Dim sData As DataTable = GetData(sSQL)
            Dim strTag As String = sData.Rows(0)("HTMLEmbedTag").ToString
            'Dim strTag As String = GridView1.SelectedRow.Cells(2).Text
            sData.Dispose()
            'Editor.Content += "<BR>" & HtmlDecode(strTag)
            Editor.Content = HtmlDecode(strTag)
            'litPreview.Text = strTag
            'litPreview.Visible = True
            'txtMsg.Value = HtmlDecode(strTag)
            'CPID.Value = AutoID
            'MediaType.Value = sType
        Catch ex As Exception
            lblStatus.Text = ex.Message
            lblStatus.ForeColor = Drawing.Color.Red
        End Try
    End Sub

    Protected Sub imgDelete_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgDelete.Click
        Try
            Dim sSQL As String = "DELETE FROM ConciergeTemplate WHERE TemplateID = " & ddnTemplate.SelectedValue
            Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString
            Dim oConn = New SqlConnection(sConn)
            Dim oCmd As New SqlCommand
            oConn.Open()
            oCmd.Connection = oConn
            oCmd.CommandType = CommandType.Text
            oCmd.CommandText = sSQL
            oCmd.ExecuteNonQuery()
            lblStatus.Text = "Template ID: " & ddnTemplate.SelectedValue.ToString & " deleted successfully."
            ddnTemplate.Items.RemoveAt(ddnTemplate.SelectedIndex)
            cboIconURL.SelectedValue = "0"
            ddnTemplate.SelectedValue = "111111"
            txtWrapper.Text = ""
            HidID.Value = 0
            txtTitle.Text = ""
            Editor.Content = ""
            txtTemplateName.Text = ""
            lblStatus.Visible = True
            oCmd.Dispose()
            oConn.Close()
        Catch ex As Exception
            lblStatus.Text = ex.Message
            lblStatus.Visible = True
        End Try
        
    End Sub
    

    Protected Sub ddnTemplate_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddnTemplate.SelectedIndexChanged
        Dim sSQL As String = "SELECT * FROM ConciergeTemplate WHERE TemplateID = " & ddnTemplate.SelectedValue
        Dim sData As DataTable = GetData(sSQL)
        If sData.Rows.Count > 0 Then
            cboIconURL.SelectedValue = sData.Rows(0)("icon_url").ToString
            txtWrapper.Text = sData.Rows(0)("wrapper_text").ToString
            HidID.Value = sData.Rows(0)("TemplateID").ToString
            txtTitle.Text = sData.Rows(0)("title").ToString
            Editor.Content = sData.Rows(0)("body").ToString
            txtTemplateName.Text = sData.Rows(0)("TemplateName").ToString
            lblStatus.Text = ""
            lblStatus.Visible = False
        Else
            cboIconURL.SelectedValue = ""
            txtWrapper.Text = ""
            HidID.Value = 0
            txtTitle.Text = ""
            Editor.Content = ""
            txtTemplateName.Text = ""
            lblStatus.Text = ""
            lblStatus.Visible = False
        End If

    End Sub
End Class
