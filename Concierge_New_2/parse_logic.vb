
'Objectives: change sizes of items; makeHTML docs;

pct passed to embed;
getHeight() etc have if pct <> 100 then
	height is pct * height...
	
Use case:
person has embed code from video
opens dialog
fills in stuff, embed code.  Hits more - fills in more stuff.
loop on...Preview_On_click
	calls parseEmbed
	checks for pct as above, changes sinput?
	getheight()
	getwidth()
		if Movie then
			calls makeMovie
			makesMovie
			passes back url to parse embed to parse?
		end if
		makes thumbnail
	returns back url/height/width/thumb etc.
	assembleFB()
	returns fb payload into litPreview
	if click litPreview then
		shows floatbox
	end
	...changes whatever...
Next on_click
'Lock out Submit/Send buttons until Preview counter is at least 1;  Submit only last previewed content.

need to keep same filenames for url and thumb so that file overwrites.
so, let us put the now() function in the calling routine; say, use







		
		

 












Cat_New gets embed, %
if pct <>1



'In parse embed:
Sub New(ByVal input As String, ByVal mtype As Integer)
        sInput = input
        iMedia = mtype
        sPct = pct 'add pct as passed param from _New
        'item comes in at a size, say 640/480.  those numbers are in the embed code
    End Sub
	