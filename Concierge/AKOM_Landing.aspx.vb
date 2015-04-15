Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports DataAccess
Partial Class AKOM_Landing
    Inherits System.Web.UI.Page

    Protected Sub btnWebinarSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnWebinarSubmit.Click
        Dim sError As String = ""
        Dim sFName As String = "", sLName As String = "", sEmail As String = ""
        sFName = Trim(txtFirstName.Text)
        sLName = Trim(txtLastName.Text)
        sEmail = Trim(txtEmail.Text)
        If CheckBox1.Checked = False And CheckBox2.Checked = False And CheckBox3.Checked = False Then
            sError = "Please select atleast one Webinar"
        End If
        If sFName = "" And sError = "" Then
            sError = "First Name cannot be blank."
            txtFirstName.BorderColor = Drawing.Color.Red
        Else
            txtFirstName.BorderColor = Drawing.Color.Black
        End If
        If sLName = "" And sError = "" Then
            sError = "Last Name cannot be blank."
            txtLastName.BorderColor = Drawing.Color.Red
        Else
            txtLastName.BorderColor = Drawing.Color.Black
        End If

        If sEmail = "" And sError = "" Then
            sError = "Email Address cannot be blank."
            txtEmail.BorderColor = Drawing.Color.Red
        Else
            If Not EmailAddressCheck(sEmail) And sEmail <> "" Then
                sError = "Email Address entered is not in a valid format."
                txtEmail.BorderColor = Drawing.Color.Red
            Else
                txtEmail.BorderColor = Drawing.Color.Black
            End If
        End If

        If sError <> "" Then
            lblWeb.Text = sError
            lblWeb.Visible = True
        Else
            If CheckBox1.Checked = True Then
                Call InsertWebinar(4, sFName, sLName, sEmail)
            End If
            If CheckBox2.Checked = True Then
                Call InsertWebinar(5, sFName, sLName, sEmail)
            End If
            If CheckBox3.Checked = True Then
                Call InsertWebinar(6, sFName, sLName, sEmail)
            End If
            lblWeb.Text = "You are successfully registered for the selected Webinars."
            lblWeb.Visible = True
        End If
    End Sub

    Function EmailAddressCheck(ByVal emailAddress As String) As Boolean
        Dim pattern As String = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
        Dim emailAddressMatch As Match = Regex.Match(emailAddress, pattern)
        If emailAddressMatch.Success Then
            EmailAddressCheck = True
        Else
            EmailAddressCheck = False
        End If
    End Function

    Private Sub InsertWebinar(ByVal WebinarID As Integer, ByVal FirstName As String, ByVal LastName As String, ByVal EmailAddress As String)
        Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString
        Try

            Dim myConnection = New SqlConnection(sConn)
            myConnection.Open()
            Dim cmdWebinar As New SqlCommand
            cmdWebinar.Connection = myConnection
            cmdWebinar.CommandType = CommandType.Text
            cmdWebinar.CommandText = "EXEC sp_WebinarParticipant_ins " & WebinarID & ",'" & FirstName & "','" & LastName & "','" & EmailAddress & "'"
            cmdWebinar.ExecuteNonQuery()
            cmdWebinar.Dispose()
            myConnection.Close()
        Catch ex As Exception
            lblWeb.Text = ex.Message
            lblWeb.Visible = True
        End Try
    End Sub
    Private Sub InsertWebinarAlert(ByVal FirstName As String, ByVal LastName As String, ByVal EmailAddress As String)
        Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString
        Try

            Dim myConnection = New SqlConnection(sConn)
            myConnection.Open()
            Dim cmdWebinar As New SqlCommand
            cmdWebinar.Connection = myConnection
            cmdWebinar.CommandType = CommandType.Text
            cmdWebinar.CommandText = "EXEC sp_WebinarAlert_ins '" & FirstName & "','" & LastName & "','" & EmailAddress & "'"
            cmdWebinar.ExecuteNonQuery()
            cmdWebinar.Dispose()
            myConnection.Close()
        Catch ex As Exception
            lblEmail.Text = ex.Message
            lblEmail.Visible = True
        End Try
    End Sub

    Protected Sub CheckBox4_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBox4.CheckedChanged
        If CheckBox4.Checked Then
            If txtEFname.Text = "" Then txtEFname.Text = txtFirstName.Text
            If txtELname.Text = "" Then txtELname.Text = txtLastName.Text
            If txtEEmail.Text = "" Then txtEEmail.Text = txtEmail.Text
        Else
            'txtEFname.Text = ""
            'txtELname.Text = ""
            'txtEEmail.Text = ""
            'lblEmail.Visible = False
        End If
    End Sub

   
    Protected Sub btnEmailSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEmailSubmit.Click
        Dim sError As String = ""
        Dim sFName As String = "", sLName As String = "", sEmail As String = ""
        sFName = Trim(txtEFname.Text)
        sLName = Trim(txtELname.Text)
        sEmail = Trim(txtEEmail.Text)
        If CheckBox4.Checked = False Then
            sError = "Please accept for the email alerts."
        End If
        If sFName = "" And sError = "" Then
            sError = "First Name cannot be blank."
            txtEFname.BorderColor = Drawing.Color.Red
        Else
            txtEFname.BorderColor = Drawing.Color.Black
        End If
        If sLName = "" And sError = "" Then
            sError = "Last Name cannot be blank."
            txtELname.BorderColor = Drawing.Color.Red
        Else
            txtELname.BorderColor = Drawing.Color.Black
        End If

        If sEmail = "" And sError = "" Then
            sError = "Email Address cannot be blank."
            txtEEmail.BorderColor = Drawing.Color.Red
        Else
            If Not EmailAddressCheck(sEmail) And sEmail <> "" Then
                sError = "Email Address entered is not in a valid format."
                txtEEmail.BorderColor = Drawing.Color.Red
            Else
                txtEEmail.BorderColor = Drawing.Color.Black
            End If
        End If

        If sError <> "" Then
            lblEmail.Text = sError
            lblEmail.Visible = True
        Else
            If CheckBox4.Checked = True Then
                Call InsertWebinarAlert(sFName, sLName, sEmail)
            End If
            lblEmail.Text = "You are successfully signed up for the Rocket21 information alerts."
            lblEmail.Visible = True
        End If
    End Sub

    Protected Sub btnSubmitComment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmitComment.Click
        Try
            If txtComment.Text <> "" Then
                'Dim sConn As String = ConfigurationManager.ConnectionStrings("R21Conn").ConnectionString

                'Dim myConnection = New SqlConnection(sConn)
                'myConnection.Open()
                'Dim cmdWebinar As New SqlCommand
                'cmdWebinar.Connection = myConnection
                'cmdWebinar.CommandType = CommandType.Text
                'cmdWebinar.CommandText = "EXEC sp_WebinarComment_ins '" & txtComment.Text & "'"
                'cmdWebinar.ExecuteNonQuery()
                'cmdWebinar.Dispose()
                'myConnection.Close()

                SDS.Insert()

                lblComment.Text = "Your response has been saved successfully. We will get back shortly."
            Else
                lblComment.Text = "Comment is blank!"
            End If
            lblComment.Visible = True
        Catch ex As Exception
            lblComment.Text = ex.Message
            lblComment.Visible = True
        End Try
    End Sub
End Class
