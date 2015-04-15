Imports System.Data
Imports DataAccess

Partial Class OboutEditorTestSQL
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtId.Text = "112"
        End If
        Dim sSQL As String = "EXEC sp_GetDraftDetails " & txtId.Text
        Dim sData As DataTable = GetData(sSQL)
        Dim sText As String = sData.Rows(0)("body").ToString
        editor.EditPanel.Content = sText
        txtInput.Text = sText


    End Sub
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

    End Sub
End Class
