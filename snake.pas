program snakeGame;
uses getkeyunit, crt;

type
	itemptr = ^snakeItem;
	snakeItem = record
		CurX, CurY, dx, dy: integer;
		next: itemptr;
	end;
	food = record
		CurX, CurY: integer;
	end;
const
	DelayDuration = 100;

procedure ShowScore(score: integer);
begin
	GotoXY(ScreenWidth div 2 - 4, 1);
	write('Score: ', score);
	GotoXY(1, 1);
end;

procedure DrawFood(var f: food);
begin
	GotoXY(f.CurX, f.CurY);
	write('#');
	GoToXY(1, 1);
end;

procedure DrawSnake(var s: snakeItem);
begin
	GotoXY(s.CurX, s.CurY);
	write('*');
	GotoXY(1, 1);
end;

procedure HideSnake(var s: snakeItem);
begin
	GotoXY(s.Curx, s.CurY);
	write(' ');
	GotoXY(1, 1);
end;

procedure MoveSnake(var s: snakeItem);
begin
	HideSnake(s);
	s.CurX := s.CurX + s.dx;
	if s.Curx > ScreenWidth then
		s.Curx := 1
	else
	if s.CurX < 1 then
		s.Curx := ScreenWidth;
	s.CurY := s.CurY + s.dy;
	if s.CurY > ScreenHeight then
		s.CurY := 1
	else
	if s.CurY < 1 then
		s.CurY := ScreenHeight;
	DrawSnake(s) 
end;

procedure SetDirection(var s: snakeItem; dx, dy: integer);
begin
	s.dx := dx;
	s.dy := dy;
end;

var
	s: snakeItem;
	f: food;
	key: integer;
	score: integer = 0;
begin
	clrscr();
	s.CurX := ScreenWidth div 2;
	s.CurY := ScreenHeight div 2;
	f.CurX := 30;
	f.CurY := 20;
	s.dx := 0;
	s.dy := 0;
	DrawSnake(s);
	DrawFood(f);
	ShowScore(score);
	while true do
	begin
		if not KeyPressed then
		begin
			MoveSnake(s);

			if (f.CurX = s.CurX) and (f.CurY = s.CurY) then {if snake eat}
			begin
				f.CurX := f.CurX + 1;
				f.CurY := f.CurY + 1;
				score := score + 1;
				DrawFood(f);
				ShowScore(score);
			end;

			delay(DelayDuration);
			continue;
		end;
		GetKey(key);
		case key of
			-75: SetDirection(s, -1, 0);
			-77: SetDirection(s, 1, 0);
			-72: SetDirection(s, 0, -1);
			-80: SetDirection(s, 0, 1);
			32: SetDirection(s, 0, 0);
			27: break
		end
	end;
	clrscr
end.
