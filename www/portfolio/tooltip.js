//both from http://www.leidenpromotie.nl
//DHTML.js

bIsNN4 = 0;
bIsNN6 = 0;
bIsIE5 = 0;
bIsUnknown = 0;


if(document.layers)
	bIsNN4 = 1;
else if(document.all)
	bIsIE5 = 1;
else if(document.getElementById)
	bIsNN6 = 1;
else
	bIsUnknown = 1;

function GMM_CreateLayer(LayerID, LayerX, LayerY, LayerW, LayerH, LayerZ)
{	if(bIsNN4)
	{	if(arguments[7])
		{	ParentLayer = GMM_FindLayerNN4(arguments[7]);
			theLayer = new Layer(LayerW, ParentLayer);
			theLayer.visibility = "inherit";
		}
		else
		{	theLayer = new Layer(LayerW);
			theLayer.visibility = "hide";
		}
		theLayer.id = LayerID;
		theLayer.x = LayerX;
		theLayer.y = LayerY;
		theLayer.clip.left = 0;
		if(LayerW != -1)
			theLayer.clip.width = LayerW;
		theLayer.clip.top = 0;
		if(LayerH != -1)
			theLayer.clip.height = LayerH;
		theLayer.zIndex = LayerZ;
		if(arguments[6])
		{	theLayer.document.open();
			theLayer.document.write(arguments[6]);
			theLayer.document.close();
		}
		return theLayer;
	}
	else if(bIsIE5)
	{	DIVStr = "\n<div id='"+LayerID+"' style='position: absolute; left: "+LayerX+"px; top: "+LayerY+"px; ";

		if(LayerW != -1)
			DIVStr += "width: "+LayerW+"px; overflow: hidden;";

		if(LayerH != -1)	
			DIVStr += "height: "+LayerH+"px; ";
		
		DIVStr += "z-index:"+LayerZ+"; visibility:"+(arguments[7]? "inherit" : "hidden")+";'></div>\n";
	
		if(arguments[7])
		{	theParent = document.all[arguments[7]];
			theParent.insertAdjacentHTML("beforeEnd", DIVStr);
		}
		else
		{	document.body.insertAdjacentHTML("beforeEnd", DIVStr);
		}

		if(arguments[6])
		{	document.all[LayerID].innerHTML = arguments[6];
		}
		
		return document.all[LayerID];
	}
	else if(bIsNN6)
	{	theLayer = document.createElement('DIV');
		theLayer.id = LayerID;
		theLayer.style.position = "absolute";
		theLayer.style.left = LayerX + "px";
		theLayer.style.top = LayerY + "px";
		if(LayerW != -1)
			theLayer.style.width = LayerW + "px";
		if(LayerH != -1)
			theLayer.style.height = LayerH + "px";
		theLayer.style.overflow = "hidden";
		if(arguments[6])
			theLayer.innerHTML = arguments[6];
		theLayer.style.zIndex = LayerZ;
		if(arguments[7])
			theLayer.style.visibility = "inherit";
		else
			theLayer.style.visibility = "hidden";

		if(arguments[7])
		{	theParent = document.getElementById(arguments[7]);
			theParent.appendChild(theLayer);
		}
		else
			document.body.appendChild(theLayer);
		
		return theLayer;
	}
}

function GMM_FindLayerNN4(LayerName)
{	if(!arguments[1])
		var doc = document;
	else
		var doc = arguments[1];

	for(var i=0; i < doc.layers.length; i++)
	{	CurrLayer = doc.layers[i];
		if(CurrLayer.id == LayerName)
			return CurrLayer;
		if(CurrLayer.document.layers.length)
		{	if((CurrLayer = GMM_FindLayerNN4(LayerName, CurrLayer.document)) != null)
				return CurrLayer;
		}
	}
	return null;	
}

function GMM_UpdateLayerContent(theLayer, ContentStr)
{	if(bIsNN4)
	{	theLayer.document.open();
		theLayer.document.write(ContentStr);
		theLayer.document.close();
	}
	if(bIsIE5 || bIsNN6)
	{	theLayer.innerHTML = ContentStr;
	}
}

function GMM_GetLayerTop(theLayer)
{	if(bIsNN4)
		return theLayer.top;
	if(bIsIE5 || bIsNN6)
		return parseInt(theLayer.style.top);
	return -1;
}

function GMM_GetLayerLeft(theLayer)
{	if(bIsNN4)
		return theLayer.left;
	if(bIsIE5 || bIsNN6)
		return parseInt(theLayer.style.left);
	return -1;
}

function GMM_GetLayerWidth(theLayer)
{	if(bIsNN4)
	{	if(theLayer.document.width)
			return theLayer.document.width;
		else
			return theLayer.clip.right - theLayer.clip.left;
	}
	if(bIsIE5 || bIsNN6)
		return parseInt(theLayer.offsetWidth);
	return -1;
}

function GMM_GetLayerHeight(theLayer)
{	if(bIsNN4)
	{	if(theLayer.document.height)
			return theLayer.document.height;
		else
			return theLayer.clip.bottom - theLayer.clip.top;
	}
	if(bIsIE5 || bIsNN6)
		return theLayer.offsetHeight;
	return -1;
}

function GMM_SetLayerClip(theLayer, ClLeft, ClTop, ClRight, ClBottom)
{	if(bIsNN4)
	{	theLayer.clip.top = ClTop;
		theLayer.clip.left = ClLeft;
		theLayer.clip.bottom = ClBottom;
		theLayer.clip.right = ClRight;
	}
	if(bIsIE5 || bIsNN6)
	{	theLayer.style.clip = "rect(" + ClTop + "px " + ClRight + "px " + ClBottom + "px " + ClLeft + "px)";
	}
}

function GMM_GetLayerClip(theLayer)
{	if(bIsNN4)
	{	ClipVals =  new Array(theLayer.clip.left, theLayer.clip.top, theLayer.clip.right, theLayer.clip.bottom);
	}
	if(bIsIE5 || bIsNN6)
	{	ClipStr = theLayer.style.clip;
		if(!clipStr)
			ClipVals = new Array(0, 0, parseInt(theLayer.offsetWidth), parseInt(theLayer.offsetHeight));
		else
		{	ClipVals = new Array();
			pos = ClipStr.indexOf("(");
			ClipVals[0] = parseInt(ClipStr.substring(++pos, ClipStr.length));
			pos = ClipStr.indexOf(" ", pos);
			ClipVals[1] = parseInt(ClipStr.substring(++pos, ClipStr.length));
			pos = ClipStr.indexOf(" ", pos);
			ClipVals[2] = parseInt(ClipStr.substring(++pos, ClipStr.length));
			pos = ClipStr.indexOf(" ", pos);
			ClipVals[3] = parseInt(ClipStr.substring(++pos, ClipStr.length));
		}
	}
	return ClipVals;
}

function GMM_SetLayerVisibility(theLayer, VisStr)
{	if(bIsNN4)
	{	switch(VisStr)
		{	case "visible":
				theLayer.visibility = "show";
				break;
			case "hidden":
				theLayer.visibility = "hide";
				break;
			case "inherit":
				theLayer.visibility = "inherit";
				break;
		}
	}
	if(bIsIE5 || bIsNN6)
		theLayer.style.visibility = VisStr;
}

function GMM_GetLayerVisibility(theLayer)
{	if(bIsNN4)
	{	VisStr = "";
		switch(theLayer.visibility)
		{	case "show":
				VisStr = "visible";
				break;
			case "hide":
				VisStr = "hidden";
				break;
			case "inherit":
				VisStr = "inherit";
				break;
		}
		return VisStr;
	}
	if(bIsIE5 || bIsNN6)
		return theLayer.style.visibility;
}

function GMM_SetLayerZIndex(theLayer, LayerZ)
{	if(bIsNN4)
		theLayer.zIndex = LayerZ;
	if(bIsIE5 || bIsNN6)
		theLayer.style.zIndex = LayerZ;
}

function GMM_GetLayerZIndex(theLayer)
{	if(bIsNN4)
		return theLayer.zIndex;
	if(bIsIE5 || bIsNN6)
		return theLayer.style.zIndex;
}

function GMM_SetLayerBgColor(theLayer, Color)
{	if(bIsNN4)
		theLayer.bgColor = Color;
	if(bIsIE5 || bIsNN6)
		theLayer.style.backgroundColor = Color;
}

function GMM_GetLayerBgColor(theLayer)
{	if(bIsNN4)
		return theLayer.bgColor;
	if(bIsIE5 || bIsNN6)
		return theLayer.style.backgroundColor;
}

function GMM_MoveLayerTo(theLayer, LayerX, LayerY)
{	if(bIsNN4)
	{	theLayer.left = LayerX;
		theLayer.top = LayerY;
	}
	if(bIsIE5 || bIsNN6)
	{	theLayer.style.left = LayerX + "px";
		theLayer.style.top = LayerY + "px";
	}
}

function GMM_MoveLayerBy(theLayer, LayerX, LayerY)
{	if(bIsNN4)
	{	theLayer.left += LayerX;
		theLayer.top += LayerY;
	}
	if(bIsIE5 || bIsNN6)
	{	posX = parseInt(theLayer.style.left) + LayerX;
		posY = parseInt(theLayer.style.top) + LayerY;
		theLayer.style.left = posX + "px";
		theLayer.style.top = posY + "px";
	}
}

function GMM_GetImagePageX(theImage)
{	if(!theImage)
		return -1;

	if(bIsNN4)
	{	if(theImage.container != null)
			return theImage.container.pageX + theImage.x;
		else
			return theImage.x;
	}
	if(bIsIE5 || bIsNN6)
	{	posX = theImage.offsetLeft;
		ImParent = theImage.offsetParent;
	  	while(ImParent != null)
		{	posX += ImParent.offsetLeft;
	  		ImParent = ImParent.offsetParent;
  		}
		return posX;
	}
}

function GMM_GetImagePageY(theImage)
{	if(!theImage)
		return -1;

	if(bIsNN4)
	{	if(theImage.container != null)
			return theImage.container.pageY + theImage.y;
		else
			return theImage.y;
	}
	if(bIsIE5 || bIsNN6)
	{	posY = theImage.offsetTop;
		ImParent = theImage.offsetParent;
	  	while(ImParent != null)
		{	posY += ImParent.offsetTop;
	  		ImParent = ImParent.offsetParent;
  		}
		return posY;
	}
}

function GMM_GetWindowInnerWidth()
{	if(bIsNN4 || bIsNN6)
		return self.innerWidth;
	if(bIsIE5)
		return document.body.clientWidth;
	return -1;
}

function GMM_GetWindowInnerHeight()
{	if(bIsNN4 || bIsNN6)
		return self.innerHeight;
	if(bIsIE5)
		return document.body.clientHeight;
	return -1;
}

function GMM_GetDocumentWidth()
{	if(bIsNN4 || bIsNN6)
		return document.width
	if(bIsIE5)
		return document.body.scrollWidth;
	return -1;
}

function GMM_GetDocumentHeight()
{	if(bIsNN4 || bIsNN6)
		return document.height
	if(bIsIE5)
		return document.body.scrollHeight;
	return -1;
}

function GMM_GetDocumentScrollX()
{	if(bIsNN4 || bIsNN6)
		return self.pageXOffset;
	if(bIsIE5)
		return document.body.scrollLeft;
}

function GMM_GetDocumentScrollY()
{	if(bIsNN4 || bIsNN6)
		return self.pageYOffset;
	if(bIsIE5)
		return document.body.scrollTop;
}

//TOOLTIP.JS

MouseDocX = -1;
MouseDocY = -1;
MouseScrX = -1;
MouseScrY = -1;
TooltipObjs = new Array();
TrackTooltips = new Array();
TooltipIntervalID = null;
TooltipInterval = 40;

if(bIsNN4)
document.captureEvents(Event.MOUSEMOVE);
document.onmousemove = SaveMousePos;

if(bIsNN4)
{	iOrigScrWidth = parent.innerWidth;
	iOrigScrHeight = parent.innerHeight;
}
self.onresize = TooltipDocumentReload;

function TooltipDocumentReload()
{	if(bIsNN4)
	{	if(top.innerWidth != iOrigScrWidth || top.innerHeight != iOrigScrHeight)
			window.location.reload();
	}
	else
		self.location.reload();
}

function SaveMousePos(e)
{	if(bIsIE5)
	{	MouseDocX = event.clientX + document.body.scrollLeft;
		MouseDocY = event.clientY + document.body.scrollTop;

		MouseScrX = event.clientX;
		MouseScrY = event.clientY;
	}
	else
	{	MouseDocX = e.pageX;
		MouseDocY = e.pageY;

		MouseScrX = MouseDocX - GMM_GetDocumentScrollX();
		MouseScrY = MouseDocY - GMM_GetDocumentScrollY();
	}
}

function UpdateTooltips()
{	PosX = 0;
	PosY = 0;

	for(i=0;i<TrackTooltips.length;i++)
	{	if(TrackTooltips[i].dMx < 0 && MouseScrX < TrackTooltips[i].FlipXMargin && MouseScrX < TrackTooltips[i].UnFlipXMargin)
			PosX = MouseDocX - TrackTooltips[i].dMx - TrackTooltips[i].width;
		else if(TrackTooltips[i].dMx > 0 && MouseScrX > TrackTooltips[i].FlipXMargin && MouseScrX > TrackTooltips[i].UnFlipXMargin)
			PosX = MouseDocX - TrackTooltips[i].dMx - TrackTooltips[i].width;
		else
			PosX = MouseDocX + TrackTooltips[i].dMx;

		if(TrackTooltips[i].dMy < 0 && MouseScrY < TrackTooltips[i].FlipYMargin && MouseScrY < TrackTooltips[i].UnFlipYMargin)
			PosY = MouseDocY - TrackTooltips[i].dMy - TrackTooltips[i].height;
		else if(TrackTooltips[i].dMy > 0 && MouseScrY > TrackTooltips[i].FlipYMargin && MouseScrY > TrackTooltips[i].UnFlipYMargin)
			PosY = MouseDocY - TrackTooltips[i].dMy - TrackTooltips[i].height;
		else
			PosY = MouseDocY + TrackTooltips[i].dMy;

		GMM_MoveLayerTo(TrackTooltips[i].BaseLayer, PosX, PosY);
	}
}

// Tooltip constructor
function Tooltip(Content, TrackMouse, X, Y)
{	this.TrackMouse = TrackMouse;
	if(TrackMouse)
	{	
		this.BaseLayer = GMM_CreateLayer("Tooltip"+TooltipObjs.length+"Base", 0, 0, -1, -1, 1);
	}
	else
	{	
		this.BaseLayer = GMM_CreateLayer("Tooltip"+TooltipObjs.length+"Base", X, Y, -1, -1, 1);
	}


	TooltipHTML = "<table";
	if(arguments[4])
		TooltipHTML += " width='"+arguments[4]+"'";
	if(arguments[5])
		TooltipHTML += " height='"+arguments[5]+"'";
	TooltipHTML += " cellpadding='";
	TooltipHTML += self.TooltipPadding? TooltipPadding : "0";
	TooltipHTML += "' border='0' cellspacing='";
	TooltipHTML += self.TooltipBorder? TooltipBorder : "0";
	TooltipHTML += "'>\n<tr>\n<td";
	TooltipHTML += self.TooltipBgcolor? " bgcolor='"+TooltipBgcolor+"'>" : ">";
	TooltipHTML += Content;
	TooltipHTML += "</td>\n</tr>\n</table>\n";


	TooltipObjs[TooltipObjs.length] = this;

	GMM_UpdateLayerContent(this.BaseLayer, TooltipHTML);

	if(self.TooltipBordercolor)
		GMM_SetLayerBgColor(this.BaseLayer, TooltipBordercolor);

	if(TrackMouse)
	{	this.isTracked = -1;
		this.width = GMM_GetLayerWidth(this.BaseLayer);
		this.height = GMM_GetLayerHeight(this.BaseLayer);

		if(X < 0)
		{	this.dMx = X - this.width;
			this.FlipXMargin = -this.dMx;
			this.UnFlipXMargin = GMM_GetWindowInnerWidth() + this.dMx;
		}
		else
		{	this.dMx = X;
			this.UnFlipXMargin = this.dMx + this.width;
			this.FlipXMargin = GMM_GetWindowInnerWidth() - this.UnFlipXMargin;
		}

		if(Y < 0)
		{	this.dMy = Y - this.height;	
			this.FlipYMargin = -this.dMy;
			this.UnFlipYMargin = GMM_GetWindowInnerHeight() + this.dMy;
		}
		else
		{	this.dMy = Y;
			this.UnFlipYMargin = this.dMy + this.height;
			this.FlipYMargin = GMM_GetWindowInnerHeight() - this.UnFlipYMargin;	
		}

		this.RightMargin = GMM_GetWindowInnerWidth() - this.dMx - this.width;
		this.BottomMargin = GMM_GetWindowInnerHeight() - this.dMy - this.height;
	}

	this.show = ToolTipShow;
	this.hide = ToolTipHide;
}

function ToolTipShow()
{	if(!this.TrackMouse)
	{
		GMM_SetLayerVisibility(this.BaseLayer, "visible");
	}
	else
	{
		if(this.isTracked != -1)
			return;

		if(self.TooltipFPS)
		{	TooltipInterval = parseInt(1000 / TooltipFPS);
		}


		this.isTracked = TrackTooltips.length;
		TrackTooltips[TrackTooltips.length] = this;
		UpdateTooltips();
		GMM_SetLayerVisibility(this.BaseLayer, "visible");

		if(TooltipIntervalID == null)
			TooltipIntervalID = self.setInterval("UpdateTooltips();", TooltipInterval);
	}
}

function ToolTipHide()
{
	if(this.isTracked == -1)
	{	GMM_SetLayerVisibility(this.BaseLayer, "hidden");
	}
	else
	{
		GMM_SetLayerVisibility(this.BaseLayer, "hidden");

		this.isTracked = -1;
		if(TrackTooltips.length == 0)
		{	self.clearInterval(TooltipIntervalID);
			TooltipIntervalID = null;
		}
	}
}

