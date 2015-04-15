Imports System.Data
Imports DataAccess


Partial Class OboutEditorTest
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtInput.Text = "<p>This is the first line</p><p>this is the second line</p><p>this is the third line</p><p>this is the last line</p>"
        Else
            'Dim sSQL As String = "EXEC sp_GetDraftDetails " & "112"
            'Dim sData As DataTable = GetData(sSQL)
            'editor.EditPanel.Content = sData.Rows(0)("body").ToString
            editor.EditPanel.Content = txtInput.Text
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

    End Sub

    Protected Sub ODSIcon_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ODSIcon.Selecting

    End Sub

    Protected Sub ComboBox1_ItemDataBound(ByVal sender As Object, ByVal e As Obout.ComboBox.ComboBoxItemEventArgs) Handles ComboBox1.ItemDataBound
        Try
            e.Item.ImageUrl = e.Item.DataItem("IconURL")
        Catch ex As Exception
            Console.WriteLine(ex.Message)

        End Try
    End Sub
End Class
