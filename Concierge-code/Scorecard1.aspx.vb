Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports DataAccess
Imports System.Web.HttpUtility
Partial Class Scorecard1
    Inherits System.Web.UI.Page

    Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
        Dim UserID As String = Request.QueryString("id")
        Dim sSQL As String = "EXEC sp_Pro_DashBoard_get " & UserID
        Dim sData As DataTable = GetData(sSQL)
        If sData.Rows.Count > 0 Then
            Dim dtLastLogin As DateTime = sData.Rows(0)("last_login_at")
            lblUserName.Text = sData.Rows(0)("Name").ToString & " - " & sData.Rows(0)("Title")
            lblLastLogin.Text = String.Format("{0:MM/dd/yyyy}", dtLastLogin)
            lblMsgs.Text = sData.Rows(0)("Msgs").ToString
            lblNots.Text = sData.Rows(0)("Nots").ToString
            lblComments.Text = sData.Rows(0)("BlCmts").ToString
            lblLinked.Text = sData.Rows(0)("Lkids").ToString
        End If

    End Sub
End Class
