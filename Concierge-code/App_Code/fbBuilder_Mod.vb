
 line 170, Concierge/App_Code/fbBuilder.vb
 
        '[20120322BD] Add Google Analytics tracking for fb anchor:
        Dim sGaOps As String
        Dim sGaTitle As String = "untitled" 'default ga label
        If sTitle <> "" Then  'if there's a title, there's a floatbox - use the fb Title (top caption) for the ga label
            sGaOps = sTitle
        End If
        sGaOps = "onItemStart:`gaRecordClick('concierge', 'view', '" + sGaTitle + "');`"
        'end Add Google Analytics tracking for fb anchor**********************

        Dim sFbOps As String = "data-fb-options=""" + sDispFormat + sCaptionText + sDialogText + sGroupOps + sGaOps + """" '[20120322BD] added "+ sGaOps"
