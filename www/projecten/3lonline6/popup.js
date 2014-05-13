var imgHeight, imgWidth;
var loadDocument = false;

window.defaultStatus = '3L-Online  =  LuckyLukies Webspace';

function Plaatje(Plaatje)
{
	NewWindow=window.open("","Nieuw","HEIGHT=500,WIDTH=500,scrollbars=yes,resizable=yes,top=0,left=0");
	NewWindow.document.write ("<HTML><HEAD><TITLE>3L Online - Foto!</TITLE>");
	NewWindow.document.write ("</HEAD>");
	NewWindow.document.write ("<BODY BGCOLOR='#000000' leftmargin=0 topmargin=0 marginwidth=0 marginheight=0 onLoad=self.focus()>");	
	NewWindow.document.write ("<CENTER>");
	NewWindow.document.write ("<IMG ID='foto' SRC='");
	NewWindow.document.write (Plaatje);
	NewWindow.document.write ("' >");
	while (!loadDocument)
	{
		getResolution();
	}
	loadDocument=false; 
	NewWindow.resizeTo(imgWidth,imgHeight);
	NewWindow.document.close();
}

function getResolution()
{
if (NewWindow.document.images[0].height > 40) {
	imgHeight = NewWindow.document.images[0].height + 32; 
	imgWidth = NewWindow.document.images[0].width + 30; 
	if (imgHeight > screen.height){
		imgHeight = screen.height - 30;}
	if (imgWidth > screen.width){
			imgWidth = screen.width;}
	loadDocument=true; }
}