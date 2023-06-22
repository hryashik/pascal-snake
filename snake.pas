program snakegame;
uses crt, snakeunit, getkeyunit;

type food = record
	CurX, CurY: integer;
	end;

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

procedure ShowScore(score: integer);

begin
	GotoXY(ScreenWidth div 2 - 5, 1);
	write('Score: ', score);
	GotoXY(1, 1);
end;

procedure GenFood(var f: food);
var
	x, y, MaxTableX, MaxTableY: integer;
begin
	randomize;
	MaxTableX := ScreenWidth;
	MaxTableY := ScreenHeight;
	x := random(MaxTableX - 1) + 2;
	y := random(MaxTableY - 1) + 2;
	f.CurX := x;
	f.CurY := y;
	GotoXY(x, y);
	TextColor(Yellow);
	write('@');
	TextColor(White);
	GoToXY(1, 1);	
end;

var
	key, score: integer;
	first, last: itemptr;
	f: food;
begin
	clrscr();
	score := 0;
	ShowScore(score);
	GenFood(f);
	initFirst(first, last);
	DrawStar(first);
	while true do
	begin
		if not KeyPressed then
		begin
			MoveSnake(first);
			if (first^.CurX = f.CurX) and (first^.CurY = f.CurY) then {snake will eat food}
			begin
				score := score + 1;
				ShowScore(score);
				GenFood(f);
			end;	
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
