"User.click..." = user action
">> Application >validates..." = application action

GENERAL USE  "http://dev-concierge.rocket21.com/catalog_jgbd.aspx"
//First Pass:
>> Application.on_load;
	>btnSave.disable;
	>btnMesg.disable;
	>pnlOptions.display = none;
	

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
				>validates required fields;
				>posts back all fields;
				>runs parse, assemble and makeMovie / makeThumb routines as appropriate;
				>returns page with floatbox string in LitPreview;
//Subsequent to first pass:
	.Chooses;
		.click litPreview; // launches fbpopup 
			>> Application.shows_floatbox;
				>shows floatboxed content in fbpopup;
				>enables btnSave and btnMsg
		//views and closes fb display
				>//hook the abov with afterBoxEnd:somefunction() in fbPageOptions and
				//somefunction() {btnSave.enable; btnMsg.enable;
				 //allows save/Message AFTER preview closes - easier script
		.to change information in any field; //including OPTIONS fields as above
								
		.click SAVE button
			>> Application btnSave_on_click routine;  //runs BUILD routines and saves to catalog;
				>call Procedure btnBuild_on_click;
				>call Procedure save_to_catalog;
				>return message 'saved...ID ...'
		.click MESSAGE button
			>> Application btnSave_on_click routine; //runs BUILD routines and saves to catalog and opens/populates home.aspx in target="_blank";
				>call Procedure btnBuild_on_click;
				>call Procedure save_to_catalog;
				>call Procedure send_message; 
				>return message 'saved...ID ...'
		.click MENU button
			//save as above
		.click OPTIONS button
			//save s above
					
 