"User.click..." = user action
">> Application >validates..." = application action

GENERAL USE  "http://dev-concierge.rocket21.com/catalog_jgbd.aspx"

//First Pass:

>> Application.on_load;
	>btnSave.disabled;
	>btnMesg.disabled;
	>pnlShowOptions.display = none;

User
	.finds media on web;
	.copies embed code or link location as appropriate for Media Type;
	.opens Catalog_New from menu;
	.fills in appropriate information;
	.click OPTIONS button (or not); // makes pnlOptions visible 
	.fills in any wanted info in panel made visible by js btnOptions_on_click event;
	.click OK (or not) on popup;
	.Chooses Event // On load, SAVE and MESSAGE buttons hidden, no LitPreview yet ;
		.click OPTIONS button;
			>> unhides custom fields // can fill in, press ok (or not)	
		.click MENU button;
			>> msgbox ("are you sure you want to leave this form?  You will lose all data", YesNo)
				>if yes then Application show default.aspx;
		.click BUILD button;
			>> Application btnBuild_on_click routine; // each time the BUILD button is pressed, a new fb string is created;
				>validates required fields; (these are in the Validator function...)
				>posts back all fields;
				>runs parse, assemble and makeMovie / makeThumb routines as appropriate;
				>returns page with floatbox string in LitPreview;

//Subsequent to first pass:

User	
	.Chooses;
		.click litPreview; // launches fbpopup 
			>> Application.shows_floatbox;
				>shows floatboxed content in fbpopup;
				>enables btnSave and btnMsg
		
		//.views and closes fb display
				//hook the abov with afterBoxEnd:somefunction() in fbPageOptions and
				//somefunction() {btnSave.enable; btnMsg.enable;
				 //allows save/Message AFTER preview closes - easier script
		
		.to change information in any field; //including OPTIONS fields as above
								
		.click SAVE button //enabled AFTER litPreview_on_Click
			>> Application btnSave_on_click routine;  //runs BUILD routines and saves to catalog;
				>call Procedure btnBuild_on_click;
				>call Procedure save_to_catalog;
				>return message 'saved...ID ...'
		.click MESSAGE button //enabled AFTER litPreview_on_Click
			>> Application btnSave_on_click routine; //runs BUILD routines and saves to catalog and opens/populates home.aspx in target="_blank";
				>call Procedure btnBuild_on_click;
				>call Procedure save_to_catalog;
				>call Procedure send_message; 
				>return message 'saved...ID ...'
		.click MENU button
			//same as above
		.click OPTIONS button
			//same as above
					
[TODO] sort out transition from saved to new/blank form
[TODO] 	cboOwner / cboCampaign setup
	see: http://www.obout.com/combobox/aspnet_master_detail.aspx
[TODO] hook up datasources for MediaType, Submitter, Owner / Campaign...  
[TODO] NOTE that MediaType index order is !important; 0 => Video, 1 => R21Video, 2 => Image, 3 => Document, 4 => Page, 5 => HTML for now
[TODO] NOTE any default text necessary in a field can be added via the Watermark property.
[TODO] NOTE Have set tab order.
[TODO] Redirect the base URL in parseEmbed when moved out of dev-concierge.
[TODO] 

					
See [TODO] references all aspx & Vb including classes

[TODO] Logic for LinkType / Info //These are currently defaulted - Bob to finish

cboLinkText behavior:
if btnThumb is checked, cboLinkText is disabled/grayed
if btnButton is checked, cboLinkText is select box with image icon.  Can be populated from ds - see: http://www.obout.com/combobox/aspnet_icons_items.aspx OR template - see: http://www.obout.com/combobox/aspnet_icons_items.aspx
if btnText is checked, cboLinkText is simple text box.

if btnButton, cboLinkText.SelectedIndex gives ID of button URL:  /buttons/button4.png.
list is populated from ds with name, image

if btnText, cboLinkText.SelectedText is simmply the <a>text</a>.

Case MediaType
	Video, btnThumb is checked
	Image, btnThumb is checked
 