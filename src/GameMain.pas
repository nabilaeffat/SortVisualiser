program GameMain;
uses SwinGame, TerminalUserInput, sgTypes, SysUtils;


procedure PopulateArray(var data: array of integer);
var 
i : integer;
begin
	for i:= 0 to High(data) Do
	data[i]:= Rnd( ScreenHeight() );

end;

procedure ShowNumbersInList(var data: array of integer); 
var 
i : integer;
begin
	ListClearItems('NumbersList');
	for i:=0 to High(data) Do
  	ListAddItem( 'NumbersList', IntToStr(data[i]));
end;

procedure PlotBars(var data: array of integer);
var
i, xAxis,yAxis, height,witdth: Integer;
begin
	ClearScreen(ColorWhite);
	witdth :=Round((ScreenWidth()- PanelWidth('NumberPanel'))/Length(data));
	for i:=Low(data) to High(data) Do
	begin
	yAxis := ScreenHeight() - data[i];
	xAxis := witdth*i;

	//FillRectangle(ColorRed, i*witdth,height, witdth,data[i]  );
	FillRectangle(ColorRed, xAxis,yAxis, witdth ,data[i] );
	WriteLn('x ',xAxis,'y ',yAxis,'w ',witdth,'h ',data[i]);
end;

	DrawInterface();
	RefreshScreen();
end;
procedure swap( var v1, v2: Integer );
var
  temp : Integer;
begin
  temp := v1;
  v1 := v2;
  v2 := temp;
end;

procedure Sort(var data: array of integer);
var
i , j : Integer;
begin
For i := High(data) DownTo Low(data) do
	for j := Low(data)  to i do
	if data[j] > data[j+1] then
		begin
		Swap ( data[j], data[j+1]);
		PlotBars (data);
		Delay(100);	
	end;
end;


Procedure InsertionSort(data : Array of Integer);
Var
i, j, index : Integer;

begin
For i := Low(data) To High(data) do
begin
 	index := data[i];
	j := i;
	While ((j > 0) AND (data[j-1] > index)) do
	begin
		Swap(data [j], data[j-1]);
		PlotBars (data);
		Delay(100);
		j:= j-1;
		end;
	end;
end;

procedure DoSort(var data: array of integer);

begin
PopulateArray(data);
ShowNumbersInList(data); 
PlotBars(data);
//Sort(data);
InsertionSort(data);
end;


procedure Main();
var 
data : array [0..19] of Integer;	

begin
OpenGraphicsWindow('Sort Visualiser', 800, 600);
LoadResourceBundle( 'NumberBundle.txt' );
GUISetForegroundColor( ColorBlack );
GUISetBackgroundColor( ColorWhite );
ShowPanel( 'NumberPanel' );
ClearScreen(ColorWhite);

Repeat
ProcessEvents();
UpdateInterface();
DrawInterface();
RefreshScreen();

If ButtonClicked( 'SortButton') then
begin 
DoSort(data);
end;
Until WindowCloseRequested()
end;

begin
Main();
end.