Imports System.IO
Partial Class ImageUpload
    Inherits System.Web.UI.Page

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        Try
            Dim sFileName As String, sSavePath As String, sSaveDir As String
            sSaveDir = "G:\ftproot\Concierge\thumbs\"

            sFileName = FileUpload1.FileName
            sSavePath = sSaveDir & sFileName

            'save file to server
            FileUpload1.SaveAs(sSavePath)

            lblStatus.Text = "File Uploaded Successfully: Click Link below to verify"
            hypFileLink.Text = "http://concierge.rocket21.com/thumbs/" & sFileName
            hypFileLink.NavigateUrl = "http://concierge.rocket21.com/thumbs/" & sFileName
            hypFileLink.Visible = True
            lblStatus.ForeColor = Drawing.Color.Green
        Catch ex As Exception
            lblStatus.Text = ex.Message
            lblStatus.ForeColor = Drawing.Color.Red
        End Try
    End Sub
End Class
