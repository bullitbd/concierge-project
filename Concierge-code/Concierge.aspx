<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Concierge.aspx.vb" Inherits="Concierge" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Concierge: Catalog Search Utility</title>
    <style type="text/css">
    html, body {
	    height: 100%;
	    overflow: auto;
    }
    body {
	    padding: 0;
	    margin: 0;
    }
    #silverlightControlHost {
	    height: 100%;
	    text-align:center;
    }
    </style>
    <script type="text/javascript" src="Javascript\Silverlight.js"></script>
    <script type="text/javascript">
        function onSilverlightError(sender, args) {
            var appSource = "";
            if (sender != null && sender != 0) {
                appSource = sender.getHost().Source;
            }

            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;

            if (errorType == "ImageError" || errorType == "MediaError") {
                return;
            }

            var errMsg = "Unhandled Error in Silverlight Application " + appSource + "\n";

            errMsg += "Code: " + iErrorCode + "    \n";
            errMsg += "Category: " + errorType + "       \n";
            errMsg += "Message: " + args.ErrorMessage + "     \n";

            if (errorType == "ParserError") {
                errMsg += "File: " + args.xamlFile + "     \n";
                errMsg += "Line: " + args.lineNumber + "     \n";
                errMsg += "Position: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError") {
                if (args.lineNumber != 0) {
                    errMsg += "Line: " + args.lineNumber + "     \n";
                    errMsg += "Position: " + args.charPosition + "     \n";
                }
                errMsg += "MethodName: " + args.methodName + "     \n";
            }

            throw new Error(errMsg);
        }
        function slHello(stext) {
            alert(stext);
        }
        function PicketContent(iContentPicketID, sHtmlEmbedTag) {
            //alert(iContentPicketID);
            //alert(sHtmlEmbedTag);

            window.opener.document.getElementById("CPID").value = iContentPicketID;
            window.opener.document.getElementById("txtMedia").value = sHtmlEmbedTag;            
            window.opener.document.getElementById("txtMsg").value = sHtmlEmbedTag;

            //window.opener.document.getElementById("litPreview").value = sHtmlEmbedTag;
            //window.opener.document.getElementById("litPreview").Visible = true;
            
            
            //window.opener.document.getElementById("litPreview").value = sHtmlEmbedTag;
            //window.opener.document.getElementById("litPreview").Visible = true;

            alert("Embed-code has been copied over to the main concierge page.\nPlease close the silverlight poupup window to see the code.");
        }

    </script>
</head>
<body>
    <form id="form1" runat="server" style="height:100%">
    <div id="silverlightControlHost">
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="100%">
		  <param name="source" value="ClientBin/SL_Navigation_App.xap"/>
		  <param name="onError" value="onSilverlightError" />
		  <param name="background" value="white" />
		  <param name="minRuntimeVersion" value="4.0.50826.0" />
		  <param name="autoUpgrade" value="true" />
		  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=4.0.50826.0" style="text-decoration:none">
 			  <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight" style="border-style:none"/>
		  </a>
	    </object>
        <iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe>
     </div>
     <div>
       <asp:hiddenfield runat="server" ID="txtContentPicketID" />
       <asp:HiddenField runat="server" ID="txtHtmlEmbedTag"  />
     </div>
    
    </form>
</body>

</html>
