unit snakeunit;

interface
uses crt;

type 	
	directionsType = (left, right, up, down);
	itemptr = ^item;
	item = record
		head: boolean; 
		CurX, CurY, dx, dy: integer;
		CurDir: directionsType;
		next: itemptr;
		prev: itemptr;
	end;

var
	first, last, tmp, cursor: itemptr;
	StatusSnake: boolean = true;

procedure InitSnake();
procedure AddItem();
procedure DrawStar(var s: itemptr);
procedure HideStar(var s: itemptr);
procedure SetDirection(direction: directionsType);
procedure MoveSnake(var l: itemptr);
function CheckMove(x, y: integer): boolean;

implementation

procedure InitSnake();
begin
	new(first);
	first^.CurX := ScreenWidth div 2;
	first^.CurY := ScreenHeight div 2;
	first^.dx := -1;
	first^.dy := 0;
	first^.CurDir := left;
	first^.prev := nil;
	first^.next := nil;
	first^.head := true;
	last := first;
end;

procedure AddItem();
begin
	new(tmp);
	tmp^.CurX := last^.CurX - last^.dx;
	tmp^.CurY := last^.CurY - last^.dy;
	tmp^.head := false;
	tmp^.next := nil;
	tmp^.prev := last;
	last^.next := tmp;
	last := tmp;
end;

procedure DrawStar(var s: itemptr);
begin
	GotoXY(s^.CurX, s^.CurY);
	TextColor(Green);
	if s^.head = true then
		TextColor(Red);
	write('*');
	TextColor(White);
	GotoXY(1, 1);
end;

procedure HideStar(var s: itemptr);
begin
	GotoXY(s^.CurX, s^.CurY);
	write(' ');
	GotoXY(1, 1);
end;

procedure SetDirection(direction: directionsType);
begin
	if direction = left then
	begin
		if first^.CurDir = right then
			exit;
		first^.dx := -1;
		first^.dy := 0;
		first^.CurDir := left;
	end;
	if direction = right then
	begin
		if first^.CurDir = left then
			exit;
		first^.dx := 1;
		first^.dy := 0;
		first^.CurDir := right
	end;
	if direction = up then
	begin
		if first^.CurDir = down then
			exit;
		first^.dx := 0;
		first^.dy := 1;
		first^.CurDir := up;
	end;
	if direction = down then
	begin
		if first^.CurDir = up then
			exit;
		first^.dx := 0;
		first^.dy := -1;
		first^.CurDir := down;
	end;
end;

procedure MoveSnake(var l: itemptr);
begin
	tmp := l;
	while tmp <> nil do
	begin
		HideStar(tmp);
		tmp := tmp^.prev;
	end;
	tmp := l;
	while tmp <> nil do
	begin
		if tmp^.head = false then
		begin
			tmp^.CurX := tmp^.prev^.CurX;
			tmp^.CurY := tmp^.prev^.CurY;
			DrawStar(tmp);
			tmp := tmp^.prev;
		end;
		if tmp^.head = true then
		begin
			tmp^.CurX := tmp^.CurX + tmp^.dx;
			if tmp^.CurX > ScreenWidth then
				tmp^.CurX := 1;
			if tmp^.CurX < 1 then
				tmp^.CurX := ScreenWidth;
			tmp^.CurY := tmp^.CurY + tmp^.dy;
			if tmp^.CurY > ScreenHeight then
				tmp^.CurY := 1;
			if tmp^.CurY < 1 then
				tmp^.CurY := ScreenHeight;
			if CheckMove(tmp^.CurX, tmp^.CurY) = true then
			begin
				DrawStar(tmp);
				tmp := tmp^.prev;
			end
			else
			begin	
				StatusSnake := false;
				DrawStar(tmp);
				tmp := tmp^.prev;
			end;
		end;
	end;	
end;

function CheckMove(x, y: integer): boolean;
var result: boolean;
begin
	result := true;
	cursor := last;
	while cursor^.head = false do
	begin
		if (cursor^.CurX = x) and (cursor^.CurY = y) then
		begin
			result := false;
			break;
		end;
		cursor := cursor^.prev;
	end;
	CheckMove := result;
end;
end.

