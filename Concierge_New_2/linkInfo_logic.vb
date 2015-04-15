'Link stuff:

'Link button defaults to thumbnail for video, image;

if link = thumbnail
	if first pass 
		cboLinkText is disabled;
	else
		cboLinkText is enabled;
		cboLinkText.Text is thumbURL;
		'user can change thumbURL'
		if cboLinkText.changed
			flag for no thumbnail creation
		end if
	end if	

if link = button
	cboLinkText ds is (button name, button icon) from button table with (name, icon, url)
	cboLinkText.SelectionMode = "single"
	
if link = text
	cboLinkText ds is link_text table 'contains commonly used names.  user can select one or type in his own.
	
	
If video/image, it will make thumbnail.
So, on first pass, nothing;
On second pass, allow url entry, disallow making of thumb...


If thumb, box is textbox;
if text entered, passed to parse;
if not, parsed each time

parse routine - if .thumb is empty, do normal parse routine
else, do on entered text.  simple.



need to sort out txtThumb vs cboThumb...
	
	
	
right now; 
fbAssemble gets sThumb for button OR thumbnail.
sThumb comes from parse routine

for Button:
ComboBoxMode = ComboBox
ShowSelectedImage = "true"
AllowEdit = "false"

for Thumb:
AllowCustomText = "true"
ComboBoxMode = TextBox
(comboBox1.disable) disables ddn list

for Text:
AllowCustomText = "true"
ComboBoxMode = TextBox
AllowEdit = "true"

'radiobutton client side
propertychecked 	Gets or sets the checked state of the radio button.

var isChecked = rbtn1.checked();
rbtn1.checked(true);
rbtn1.checked(false);
propertyfocus 	Moves the focus to the radio button.

rbtn1.focus();
propertyblur 	Removes the focus from the radio button.

rbtn1.blur();
propertyenable 	Enables the radio button.

rbtn1.enable();
propertydisable 	Disables the radio button.

rbtn1.disable(); 

'combobox clientside
propertyenable 	Enables the drop down list.

ComboBox1.enable();
propertydisable 	Disables the drop down list.

ComboBox1.disable(); 

so; for 

fbAssemble gets txtlinkinfo or cbolinkinfo as slinktext depending on radio button...
if buildFB.thumb, use thumb routine
select case buildFB.linkType
case thumb, use thumb routine with .linkText (precidence)
	if blank, use .thumb
	else use text
case button, use thumb routine with .linkText
case text, use text routine with .linkText