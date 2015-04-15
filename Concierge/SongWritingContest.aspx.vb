Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports DataAccess
Imports System.Web.HttpUtility

Partial Class SongWritingContest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Call PopulateGenre()
        End If
    End Sub

    Private Sub PopulateGenre()
        Dim Genre() As String = {"Select Genre", "Alternate", "Country", "Hip Pop", "Pop", "Rock"}
        ddnGenre.DataSource = Genre
        ddnGenre.DataBind()
    End Sub
    Private Function InsertSongLyrics(ByVal ScreenName As String, ByVal SongTitle As String, ByVal Genre As String, ByVal Lyrics As String) As Integer
        Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString
        Dim LyricsID As Integer
        Try
            Dim myConnection = New SqlConnection(sConn)
            myConnection.Open()
            Dim cmdSongLyrics As New SqlCommand
            cmdSongLyrics.Connection = myConnection
            cmdSongLyrics.CommandType = CommandType.StoredProcedure
            cmdSongLyrics.CommandText = "sp_SongLyrics_ins"
            cmdSongLyrics.Parameters.AddWithValue("@ScreenName", ScreenName)
            cmdSongLyrics.Parameters.AddWithValue("@SongTitle", SongTitle)
            cmdSongLyrics.Parameters.AddWithValue("@Genre", Genre)
            cmdSongLyrics.Parameters.AddWithValue("@Lyrics", Lyrics)
            cmdSongLyrics.Parameters.Add("@LyricsID", SqlDbType.Int)
            cmdSongLyrics.Parameters("@LyricsID").Direction = ParameterDirection.Output
            cmdSongLyrics.ExecuteNonQuery()
            LyricsID = cmdSongLyrics.Parameters("@LyricsID").Value
            cmdSongLyrics.Dispose()
            myConnection.Close()
        Catch ex As Exception
            lblStatus.Text = ex.Message
            lblStatus.Visible = True
        End Try

        Return LyricsID
    End Function

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim sError As String = ""
        Dim sScreenName As String = Trim(txtScreenName.Text)
        Dim sSongTitle As String = Trim(txtSongTitle.Text)
        Dim sGenre As String = ddnGenre.SelectedItem.Text.ToString
        Dim sLyrics As String = Trim(Editor.Content)

        If sError = "" And sScreenName = "" Then
            sError = "Screen Name cannot be empty."
            txtScreenName.BorderColor = Drawing.Color.Red
            txtScreenName.Focus()
        Else
            txtScreenName.BorderColor = Drawing.Color.Black
        End If
        If sError = "" And sSongTitle = "" Then
            sError = "Song Title cannot be empty."
            txtSongTitle.BorderColor = Drawing.Color.Red
            txtSongTitle.Focus()
        Else
            txtSongTitle.BorderColor = Drawing.Color.Black
        End If
        If sError = "" And sGenre = "Select Genre" Then
            sError = "Please select a Genre."
            ddnGenre.BorderColor = Drawing.Color.Red
        Else
            ddnGenre.BorderColor = Drawing.Color.Black
        End If
        If sError = "" And sLyrics = "" Then
            sError = "Lyrics cannot be empty."
            Editor.BorderColor = Drawing.Color.Red
            'txtLyrics.Focus()
        Else
            Editor.BorderColor = Drawing.Color.Black
        End If

        If sError <> "" Then
            lblStatus.Text = sError
            lblStatus.Visible = True
        Else
            Dim LyricsID As Integer
            LyricsID = InsertSongLyrics(sScreenName, sSongTitle, sGenre, sLyrics)
            If LyricsID = 0 Then
                lblStatus.Text = "Song with the same lyrics already exists."
            Else
                lblStatus.Text = "Song Lyrics created successfully. Song Lyric ID: " & LyricsID.ToString
            End If
            lblStatus.Visible = True
        End If
    End Sub
End Class
