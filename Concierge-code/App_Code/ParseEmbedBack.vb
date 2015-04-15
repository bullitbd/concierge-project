Imports System.IO
Imports System.Drawing.Imaging
Imports System.Drawing
Imports System.Net
Imports System.Text.RegularExpressions
Imports System.Web


Public Class ParseEmbed_Back
    Dim dict As Dictionary(Of String, String)
    Private sInput As String
    Private iMedia As Integer
    Private fileDate As String
    ReadOnly sThumbVideo As String = "http://r21concierge.s3.amazonaws.com/images/video_thumb.png"
    ReadOnly sThumbImage As String = ""
    Private sThumbURL As String = ""
    Private sImgHeight As String
    Private simgWidth As String
    Private sHeight As String
    Private bmHeight As String = ""
    Private bmWidth As String = ""
    Private sWidth As String
    Private iPct As Integer
    Private fPercent As Single
    Private sTitle As String
    'regex strings

    Dim rZero As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rVid As Regex = New Regex("(?<=src[="":]+)http[s]?://[^"" ]+", RegexOptions.IgnoreCase)
    Dim r21Vid As Regex = New Regex("(?<=src[="":]+)http[s]?://[^"" ]+", RegexOptions.IgnoreCase)
    Dim rImg As Regex = New Regex("https?[:%0-9a-z_./-]+\.[a-z]{2,4}([%0-9a-z_./~-])*[%0-9a-z _.~-](.bmp|.gif|.jpe?g|.png)(?:\?\w+\=+\w+($|(?=[ "";>])))?", RegexOptions.IgnoreCase) '(?<=(?:img|src)+[='"" ]+)?https?[^'""> ]+\.(?:jpg|jpeg|gif|png)(?:\?\w+\=\w+($|(?=[ "";>])))?
    Dim rGroup As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rDoc As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rSite As Regex = New Regex("http://[\w./]+[.][\w]{2,3}", RegexOptions.IgnoreCase)
    Dim rPage As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rHTML As Regex = New Regex("", RegexOptions.IgnoreCase)

    Dim rZeroThm As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rVidThm As Regex = New Regex(sThumbVideo, RegexOptions.IgnoreCase)
    Dim r21VidThm As Regex = New Regex("(?<=https?://).+(?=(?:.bmp|.gif|.jpe?g|.png))", RegexOptions.IgnoreCase)
    Dim rImgThm As Regex = New Regex("(?<=https?://).+(?=(?:.bmp|.gif|.jpe?g|.png))", RegexOptions.IgnoreCase)
    Dim rGroupThm As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rDocThm As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rSiteThm As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rPageThm As Regex = New Regex("", RegexOptions.IgnoreCase)
    Dim rHTMLThm As Regex = New Regex("", RegexOptions.IgnoreCase)



    Dim rWidth As Regex = New Regex("(?<=width[:="" ]+)\d{2,4}%?", RegexOptions.IgnoreCase)
    Dim rHeight As Regex = New Regex("(?<=height[:="" ]+)\d{2,4}%?", RegexOptions.IgnoreCase)
    Dim rWebsite As Regex = New Regex("https?://[^/]*(?=\/)")
    Dim regMObjs() As Regex = {rZero, rVid, r21Vid, rImg, rGroup, rDoc, rSite, rPage, rHTML}
    Dim regTObjs() As Regex = {rZeroThm, rVidThm, r21VidThm, rImgThm, rGroupThm, rDocThm, rSiteThm, rPageThm, rHTMLThm}

    Dim regURI As Regex
    Dim m As Match
    Dim mThumb As Match

    'Sub New(ByVal input As String, ByVal mtype As Integer, ByVal pct As Integer)
    '    sInput = input 'from txtEmbed.Text
    '    iMedia = mtype 'from MediaType.index'
    '    iPct = pct 'from CInt(txtPct.Text)
    'End Sub
    Public WriteOnly Property input() As String
        Set(ByVal value As String)
            m = regMObjs(iMedia).Match(value)
            Select Case iMedia
                Case 3
                    If m.Success Then
                        Call GetImageDims(value)
                        sInput = m.Value + " width:" + bmWidth + " height:" + bmHeight
                    End If
                Case 1, 2
                    Dim oVidPage As New VideoPage
                    sInput = oVidPage.makeMovie(value, sTitle, fileDate, iPct)

                Case Else
                    If m.Success Then
                        sInput = value
                    End If
            End Select
        End Set
    End Property
    Public WriteOnly Property mtype() As Integer
        Set(ByVal value As Integer)
            iMedia = value
        End Set
    End Property
    Public WriteOnly Property pct() As Integer
        Set(ByVal value As Integer)
            iPct = value
        End Set
    End Property
    Public WriteOnly Property sdate() As String
        Set(ByVal value As String)
            fileDate = value
        End Set
    End Property
    Public WriteOnly Property title() As String
        Set(ByVal value As String)
            sTitle = value
        End Set
    End Property
    Public WriteOnly Property thumb() As String  '[BOB][TODO]
        Set(ByVal value As String)
            m = rImg.Match(value)

            If m.Success Then
                sThumbURL = value
            End If
        End Set
    End Property
    'this populates a Dictionary collection with calls to the appropriate functions.
    'In Catalog_New, Get ClassInstanceName.results pulls in dictionary & assigns it to locals there. 
    Public ReadOnly Property results() As Dictionary(Of String, String)
        Get
            'Return GetMedia(iMedia)
            dict = New Dictionary(Of String, String)
            dict.Add("url", GetMedia(iMedia))  'media url
            dict.Add("thumb", GetThumb(iMedia))  'thumb url
            dict.Add("web", GetWeb())  'website url
            dict.Add("height", GetHeight())  'height of media; for images, calculated in MakeThumb() and assigned to class var sImgHeight
            dict.Add("width", GetWidth())  'width of media; for images, calculated in MakeThumb() and assigned to class var sImgWidth
            'dict.Add("ratio", GetRatio(sWidth, sHeight))  'media ratio or w/h

            Return dict
            dict = Nothing
        End Get
    End Property
    'Array of Media regex expressions regMObjs(n) - n is passed Media Type index in order of array members 
    Private Function GetMedia(ByVal n As Integer) As String
        m = regMObjs(n).Match(sInput)
        If Not m.Success Then
            Return "Unable to Parse Valid Media URL (Function GetMedia)"
        Else
            Return m.Value
        End If
    End Function
    'Array of Thumb regex expressions regMObjs(n) - n is passed Media Type index in order of array members
    'returned thumb is either:
    'GetThumb(iMedia) (normal route parsing sInput for an image url - typically images...) or
    'ParseThumb(sThumbURL) if there is a valid URL passed to thumb() property (entered by user in txtLinkInfo
    Private Function GetThumb(ByVal n As Integer) As String
        mThumb = rImg.Match(sThumbURL)
        If mThumb.Success Then
            Dim iMediaTemp As Integer = iMedia
            Dim sTempReturn As String
            iMedia = 3 'THIS IS A TEMPORARY FIX for the case problem in MakeThumb
            sTempReturn = MakeThumb(mThumb.Value)
            iMedia = iMediaTemp
            Return sTempReturn

        Else
            m = regMObjs(n).Match(sInput)
            Return MakeThumb(m.Value)
        End If

    End Function
    '
    Private Function GetWeb() As String   'Parses website url
        m = rWebsite.Match(sInput)
        If Not m.Success Then
            Return "Unable to Parse Web Address (Fn GetWeb())"
        Else
            Return m.Value
        End If
    End Function
    '
    Protected Function GetHeight() As String  'Parses Height attribute (if exixts...)
        m = rHeight.Match(sInput)
        If Not m.Success Then
            sHeight = ""
        Else
            Select Case iMedia
                Case 1, 2
                    sHeight = m.Value
                Case Else
                    sHeight = (Integer.Parse(m.Value) * iPct / 100).ToString
            End Select
        End If
        Return sHeight
    End Function
    '
    Protected Function GetWidth() As String   'Parses Height attribute (if exixts...)
        m = rWidth.Match(sInput)
        If Not m.Success Then
            sWidth = ""
        Else
            Select Case iMedia
                Case 1, 2
                    sWidth = m.Value
                Case Else
                    sWidth = (Integer.Parse(m.Value) * iPct / 100).ToString
            End Select
        End If
        Return sWidth
    End Function
    '
    Protected Function GetRatio(ByVal width As String, ByVal height As String) As String
        Dim w = Single.Parse(width)
        Dim h = Single.Parse(height)
        If (h <= 0 Or w <= 0) Then
            Return "0"
        Else
            Dim r = (w / h)
            Return String.Format("{0:n3}", r)
        End If
    End Function

    Protected Sub GetImageDims(ByVal sfilename As String)
        'Create a new Bitmap Image loading from location of origional file
        'create the web request
        Dim wr As WebRequest = WebRequest.Create(sfilename)
        wr.Timeout = 3000
        'get the response into a stream
        Dim st As Stream = wr.GetResponse.GetResponseStream

        'create the image
        Dim bm As Image = Image.FromStream(st)
        st.Close()

        bmWidth = bm.Width.ToString
        bmHeight = bm.Height.ToString

    End Sub
    Protected Function MakeThumb(ByVal sfilename As String) As String
        'draws & stores image; returns image url & exposes original height/weight
        '[TODO] This needs to be same url for any number of passes.  For now, using 
        Select Case iMedia
            Case 3

                'Create a new Bitmap Image loading from location of origional file
                'create the web request
                Dim wr As WebRequest = WebRequest.Create(sfilename)
                wr.Timeout = 3000
                'get the response into a stream
                Dim st As Stream = wr.GetResponse.GetResponseStream

                'create the image
                Dim bm As Image = Image.FromStream(st)
                st.Close()

                Dim bmWidth As String = bm.Width.ToString
                Dim bmHeight As String = bm.Height.ToString

                'Dim bm As Bitmap = Image.FromStream(st)
                Dim maxHeight% = 80
                Dim maxWidth% = 80
                Dim newHeight%, newWidth%
                Dim ratio As Single = (bm.Width / bm.Height)

                'Set Thumbnails Height and Width
                If ratio < 1 Then
                    newHeight = maxHeight
                Else
                    newHeight = (maxWidth / ratio)
                End If
                newWidth = (newHeight * ratio)

                'Create the new image as a blank bitmap & new graphic obj 
                Dim thumbnail As Bitmap = New Bitmap(newWidth, newHeight)
                Dim g As Graphics = Graphics.FromImage(thumbnail)

                'resize graphics object to fit onto the resized image
                g.DrawImage(bm, New Rectangle(0, 0, thumbnail.Width, thumbnail.Height), 0, 0, bm.Width, bm.Height, GraphicsUnit.Pixel)

                'dispose of Graphic obj.
                g.Dispose()

                'Create new path and filename for the resized image
                Dim sThumb As String
                Dim sThumbInner As String

                '//For Server (Concierge site)
                'Dim sRootPath As String = HttpContext.Current.Server.MapPath("~/") + "thumbs\"

                '//For Server (dev-Concierge site)
                Dim sRootPath As String = "G:\ftproot\concierge\thumbs\"

                '//For Bob Local
                'Dim sThumbPath As String = "D:\Users\Bob Day\Documents\Visual Studio 2008\Websites\ConciergeDev\thumbs\"

                Dim sthumbRelPath As String = "thumbs/"
                sThumb = regTObjs(iMedia).Match(sfilename).Value
                If sThumb <> "" Then
                    sThumbInner = Replace(sThumb, ".", "_")
                    sThumbInner = Replace(sThumbInner, "/", "_") + DateTime.Now.ToString("yyMMddhhmmssff") + ".png"
                    'sThumb = sthumbRelPath + sThumbInner
                    '[TODO] fix the below reference (remove dev-)
                    sThumb = "http://concierge.rocket21.com/thumbs/" + sThumbInner
                    'thumbnail.Save(sThumbPath + sThumbInner, ImageFormat.Png)
                    thumbnail.Save(sRootPath + sThumbInner, ImageFormat.Png)

                    '[DEPLOY] On server, this should be "thumbnail.Save(sRootPath + sThumbInner, ImageFormat.Png)"
                Else
                    sThumb = "Unable to Create Thumbnail (MakeThumb)"
                End If

                '//Make image dimensions available to class (CANT DO, BECAUSE an image's thumbnail will resize image...)
                'sWidth = bmWidth
                'sHeight = bmHeight
                Return sThumb

                '[TODO] Case statement will be replaced by individual functions.
                ' These use the regTObjs array for parsing.
            Case 1 'Video
                Return sThumbVideo
            Case 2 'R21 Video
                Return sThumbVideo
            Case 4 'Group
                Return ""
            Case 5 'Document
                Return ""
            Case 6 'Site
                Return ""
            Case 7 'Page
                Return ""
            Case 8 'HTML
                Return ""
            Case Else
                Return ""
        End Select

    End Function
End Class
