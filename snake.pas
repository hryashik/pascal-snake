program snakegame;
uses crt, snakeunit, getkeyunit;

procedure initFirst(var f: itemptr; var l: itemptr);
begin
	new(f);
	f^.CurX := ScreenWidth div 2;
	f^.CurY := screenHeight div 2;
	f^.dx := -1;
	f^.dy := 0;
	f^.next := nil;
	l := f;
end;

procedure addItem(var f: itemptr;var l: itemptr; var tmp: itemptr);
begin
	new(tmp);
	tmp^.CurX := l^.CurX - f^.dx;
	tmp^.CurY := l^.Cury - f^.dy;
	tmp^.next := nil;
	l^.next := tmp;
	l := tmp;
end;

var
	key, score: integer;
	first, last, tmp: itemptr;
begin
	clrscr();
	initFirst(first, last);
	addItem(first, last, tmp);
	addItem(first, last, tmp);
	addItem(first, last, tmp);
	DrawSnake(first);
	while true do
	begin
		if not KeyPressed then
		begin
			MoveSnake(first);
			delay(100);
			continue;
		end;
		GetKey(key);
		case key of
			-75: SetDirection(first, -1, 0);
			-77: SetDirection(first, 1, 0);
			-72: SetDirection(first, 0, -1);
			-80: SetDirection(first, 0, 1);
			27: break
		end
	end;
end.
