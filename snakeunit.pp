unit snakeunit;

interface
uses crt;

type 
	itemptr = ^item;
	item = record
		CurX, CurY, dx, dy: integer;
		next: itemptr;
	end;

procedure DrawStar(var s: itemptr);
procedure HideStar(var s: itemptr);
procedure SetDirection(var s: itemptr; x, y: integer);
procedure MoveSnake(var s: itemptr);

implementation

procedure DrawStar(var s: itemptr);
begin
	GotoXY(s^.CurX, s^.CurY);
	TextColor(Green);
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

procedure SetDirection(var s: itemptr; x, y: integer);
begin
	s^.dx := x;
	s^.dy := y;
end;

procedure MoveSnake(var s: itemptr);
begin
	HideStar(s);
	s^.CurX := s^.CurX + s^.dx;
	if s^.CurX > ScreenWidth then
		s^.CurX := 1
	else
	if s^.CurX < 1 then
		s^.CurX := ScreenWidth;
	s^.CurY := s^.CurY + s^.dy;
	if s^.CurY > ScreenHeight then
		s^.CurY := 1
	else
	if s^.CurY < 1 then
		s^.CurY := ScreenHeight;
	DrawStar(s);	
end;

end.
