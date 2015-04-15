Imports System.IO

Public Class VideoPage
    Dim siteRef, sInput As String
    Dim vHeight, vWidth, askText As String
    Dim newHeight, newWidth As Integer
    Dim multiply As Single

    Dim rWidth As Regex = New Regex("(?<=width[:="" ]+)\d{2,4}", RegexOptions.IgnoreCase)
    Dim rHeight As Regex = New Regex("(?<=height[:="" ]+)\d{2,4}", RegexOptions.IgnoreCase)
    Dim findHeight As New Regex("height[:""= ]{1,2}([1-9][0-9]{1,3})")
    Dim findWidth As New Regex("width[:""= ]{1,2}([1-9][0-9]{1,3})")
    Dim rWebsite As New Regex("https?://[^/]*(?=\/)")
    Dim rWebsite2 As New Regex("(?<=http://)([A-z0-9.]+?(.com|.org|.net))")
    Dim rInvalidFileChars As New Regex("[^\w-]")
    Dim sNewEmbed As String
    Dim m As Match
    Dim iMult As Integer
    Dim testEmbed As String = "<script src=""http://videos.explore.org/player.js?embedCode=R4NmpiMjoLKTSdOyKiDbfsfaTmx0Il_z&hide=info&deepLinkEmbedCode=R4NmpiMjoLKTSdOyKiDbfsfaTmx0Il_z&width=640&autoplay=0&height=360""></script>"


    Public Function makeMovie(ByVal sInput As String, ByVal sTitle As String, ByVal stamp As String, ByVal pct As Integer) As String 'stamp is fileDate in parseEmbed DateTime.Now.ToString("yyyymmddhhmmss")

        Dim docText As String
        Dim docDtd As String = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"" ""http://www.w3.org/TR/html4/loose.dtd"">"
        'create interim variable to change size on each pass...
        Dim sEmbed As String
        iMult = pct
        sEmbed = rHeight.Replace(sInput, GetHeight(sInput))
        sEmbed = rWidth.Replace(sEmbed, GetWidth(sEmbed))



        'Assemble file
        docText = docDtd
        docText = docText & "<html><head><title></title></head><body style=""margin: 0;"">" & sEmbed & "</body></html>"

        'Dim rootPath As String = HttpContext.Current.Server.MapPath("~/") + "videos\"
        Dim rootPath As String = "G:\ftproot\Concierge\videos\"



        Dim fileName As String
        Dim webRef As String = rWebsite2.Match(sInput).Value
        Dim sw As StreamWriter
        'fileName = webRef.Replace(".", "-") & "_" & sTitle.Replace(" ", "_") & "_" & stamp & ".html"
        fileName = webRef.Replace(".", "-") & "_" & rInvalidFileChars.Replace(sTitle, "_") & "_" & stamp & ".html"

        Try
            sw = File.CreateText(rootPath & fileName)
            sw.Write(docText)
            sw.Close()
            sNewEmbed = "src=""http://concierge.rocket21.com/videos/" & fileName _
            & """_width=" & GetWidth(sInput) & "_height=" & GetHeight(sInput)
        Catch ex As Exception
            sNewEmbed = "Creation failed. Call Bob. (" & ex.Message & ")"
        End Try
        Return sNewEmbed

    End Function
    Protected Function GetHeight(ByVal param As String) As String  'Parses Height attribute (if exixts...)
        m = rHeight.Match(param)
        If Not m.Success Then
            Return "Unable to Parse Height Attribute"
        Else
            Return (Integer.Parse(m.Value) * iMult / 100).ToString
        End If
    End Function
    '
    Protected Function GetWidth(ByVal param As String) As String   'Parses Width attribute (if exixts...)
        m = rWidth.Match(param)
        If Not m.Success Then
            Return "Unable to Parse Width Attribute"
        Else
            Return (Integer.Parse(m.Value) * iMult / 100).ToString
        End If
    End Function
    'Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
    '    'nextDiv.Attributes.Item("style") = "display:none"
    '    'bottomDiv.Attributes.Item("style") = "visibility:visible"
    '    Dim docText As String
    '    Dim docDtd As String = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"" ""http://www.w3.org/TR/html4/loose.dtd"">"
    '    Dim sEmbed As String
    '    sInput = hidFinal.Value

    '    'Assemble file
    '    docText = docDtd
    '    docText = docText & "<html><head><title></title></head><body>" & sInput & "</body></html>"

    '    Dim rootPath As String = HttpContext.Current.Server.MapPath("~/") + "videos\"
    '    'Dim rootPath As String = "D:\Users\Bob Day\Documents\Visual Studio 2008\Websites\Concierge\videos\"

    '    Dim fileName As String
    '    Dim webRef As String = rWebsite2.Match(sInput).Value
    '    Dim sw As StreamWriter
    '    fileName = webRef.Replace(".", "-") & "_" & txtNameRef.Text.Replace(" ", "_") & "_" & DateTime.Now.ToString("yyyymmddhhmmss") & "_" & GetWidth(sInput) & "_" & GetHeight(sInput) & ".html"

    '    Try
    '        sw = File.CreateText(rootPath & fileName)
    '        sw.Write(docText)
    '        litFileName1.Text = "<p>Video has been saved as:" _
    '        & "<a href=""http://concierge.rocket21.com/videos/" & fileName & """>" & fileName _
    '        & "</a></p><p><i><b><u>The new embed code for this video is:</u></b></i></p>"
    '        txtNewEmbed.Text = "src=""http://concierge.rocket21.com/videos/" & fileName _
    '        & """_width=" & GetWidth(sInput) & "_height=" & GetHeight(sInput)
    '        litFileName2.Text = "<p>Copy and enter it as an <b>""R21Video""</b> Media Type.</p>"
    '        sw.Close()
    '    Catch ex As Exception
    '        txtNewEmbed.Text = "Creation failed. Call Bob. (" & ex.Message & ")"
    '    End Try


    'End Sub

End Class
