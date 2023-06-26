program snakegame;
uses crt, snakeunit, getkeyunit;

type food = record
	CurX, CurY: integer;
	end;


procedure ShowScore(score: integer);

begin
	GotoXY(ScreenWidth div 2 - 2, 1);
	write('Score: ', score);
	GotoXY(1, 1);
end;

procedure GenFood(var apple: food);
var
	x, y, MaxTableX, MaxTableY: integer;
begin
	randomize;
	MaxTableX := ScreenWidth;
	MaxTableY := ScreenHeight;
	x := random(MaxTableX - 1) + 2;
	y := random(MaxTableY - 1) + 2;
	apple.CurX := x;
	apple.CurY := y;
	GotoXY(x, y);
	TextColor(Yellow);
	write('@');
	TextColor(White);
	GoToXY(1, 1);	
end;

var
	key: integer;
	score: integer = 0;
	apple: food;
begin
	clrscr();
	ShowScore(score);
	GenFood(apple);
	InitSnake();
	while true do
	begin
		if not KeyPressed then
			begin
			MoveSnake(last);
			if (first^.CurX = apple.CurX) and (first^.CurY = apple.CurY) then
			begin
				AddItem();
				score := score + 1;
				ShowScore(score);
				GenFood(apple);
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
	clrscr();
end.
