/* Floatbox v4.18 */
fb.extend(fb.proto,{JW:function(){var d=fb[fb.SW];if(!d[fb.RK]){return}if(arguments.length===1){d.D("stretch");d.V("stretch",d.JW,100)}else{delete d.KB.stretch;if(!d.fbBox){return}var e=d.fbBox[fb.TK]+d.fbBox[fb.TM],b=d.fbBox[fb.TL]+d.fbBox[fb.TJ],f=d[fb.RY](),a=d[fb.SH](),c=d[fb.RK].style;c.width=c.height="0";if(d.rtl){c.right=-a.left+"px"}c.width=d.O(e,d.AQ.scrollWidth,d.AQ[fb.PV],d.CG[fb.PV],f.width+a.left)+"px";c.height=d.O(b,d.AQ.scrollHeight,d.AQ[fb.PU],d.CG[fb.PU],f.height+a.top)+"px"}},IU:function(){var h=this,c="ie6_"+h.KN+"_css";if(!fb[c]){if(!fb.EJ){var f="#fbBox a.fb{zoom:1}",a=null,e,d=h.F.styleSheets.length;while(d--){var k=h.F.styleSheets[d];for(var b=0;b<k.rules.length;b++){if(k.rules[b].selectorText[fb.SP]("DIV#fbBox")>-1){a=k;d=0;break}}}if(!a){return}fb.EJ={black:f,white:f,blue:f,yellow:f,red:f,custom:f};for(var d=0;d<a.rules.length;d++){var g=a.rules[d];if((e=/\.fb_(black|white|blue|yellow|red|custom)/.exec(g.selectorText))){fb.EJ[e[1]]+=g.selectorText+"{"+g.style.cssText+"}"}}}fb[c]=h.F.createStyleSheet();fb[c].cssText=fb.EJ[h.KN][fb.UK](/url\(graphics\//gi,"url("+h.DQ)[fb.UK](/\.png/g,".gif")}},ie6Loaded:true});(function(){if(fb.showIE6EndOfLife&&self===fb.Z&&!fb[fb.PJ]){if(!/fbIE6Shown=.+/.test(document.cookie)){var d=fb.language;var c=/bg|cs|da|de|el|es|et|fi|fr|hr|hu|it|nl|pl|pt|ro|sk|sl|sv/.test(d)?d:"en",b="http://www.browserchoice.eu/BrowserChoice/browserchoice_"+c+".htm",a=/bg|de|el/.test(d)?446:410;fb.start('<div style="padding:10px 20px 0 20px; color:black;"><span style="font-size:20px; font-weight:bold;">Internet Explorer 6 - End of Life<br /></span><span>We notice that you are using Internet Explorer version 6.0. Please be advised that this site and many others will have reduced functionality under this very old browser. There are also security risks involved in continuing to use IE6. To make your browsing experience safer and better, and to help web site developers everywhere, please replace your browser with one of the choices available below. </span></div><iframe src="'+b+'" width="816" height="'+a+'" frameborder="0" scrolling="no"></iframe>',{width:816,enableDragResize:false,controlsPos:"tr",backgroundColor:"#DAF3FD",caption:'<input type="checkbox" id="fbIE6check" /><span id="fbIE6noshow">Do not show this again (requires a permanent cookie)</span>',afterItemStart:function(){if(d!=="en"){fb.translate(null,d)}document.cookie="fbIE6Shown=true; path=/"},beforeItemEnd:function(){if(fb$("fbIE6check").checked){var e=new Date;e.setTime(e.getTime()+75*24*60*60*1000);document.cookie="fbIE6Shown=true; expires="+e.toGMTString()+"; path=/"}}})}}})();