unit snakeunit;

interface
uses crt;

type 
	itemptr = ^item;
	item = record
		CurX, CurY, dx, dy: integer;
		next: itemptr;
	end;

procedure DrawSnake(var s: itemptr);
procedure HideSnake(var s: itemptr);
procedure SetDirection(var s: itemptr; x, y: integer);
procedure MoveSnake(var s: itemptr);

implementation
var 
	cursor: itemptr;
procedure DrawSnake(var s: itemptr);
begin
	cursor := s;
	while cursor <> nil do
	begin
		GotoXY(cursor^.CurX, cursor^.CurY);
		write('*');
		cursor := cursor^.next;
	end;
	GotoXY(1, 1);
end;

procedure HideSnake(var s: itemptr);
begin
	cursor := s;
	while cursor <> nil do
	begin
		GotoXY(cursor^.CurX, cursor^.CurY);
		write(' ');
		cursor := cursor^.next;
	end;
	GotoXY(1, 1);
end;

procedure SetDirection(var s: itemptr; x, y: integer);
begin
	s^.dx := x;
	s^.dy := y;
end;

procedure MoveSnake(var s: itemptr);
var
	tmp1, tmp2: itemptr;
begin
	HideSnake(s);
	cursor := s;
	new(tmp1);
	new(tmp2);
	tmp1^.CurX := s^.CurX;
	tmp1^.CurY := s^.CurY;
	cursor^.CurX := s^.CurX + s^.dx;
	cursor^.CurY := s^.CurY + s^.dy;
	cursor := cursor^.next;
	while cursor <> nil do
	begin
		tmp2^.CurX := cursor^.CurX;
		tmp2^.CurX := cursor^.CurY;
		cursor^.CurX := tmp1^.CurX;
		cursor^.CurY := tmp1^.CurY;
		tmp1^.CurX := tmp2^.CurX;
		tmp1^.CurY := tmp2^.CurY;
		cursor := cursor^.next;
	end;
	dispose(tmp1);
	dispose(tmp2);
	DrawSnake(s);
end;

end.
