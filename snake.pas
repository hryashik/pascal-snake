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
	x := random(MaxTableX - 2) + 2;
	y := random(MaxTableY - 2) + 2;
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
	FailedMessage: string = 'Game is over, your score: ';

procedure ShowEnd();
var c: integer;
begin	
	clrscr();
	GotoXY(ScreenWidth div 2 - length(FailedMessage) div 2, ScreenHeight div 2);
	TextColor(Red);
	writeln(Failedmessage, score);
	TextColor(White);
	GotoXY(ScreenWidth div 2 - length(FailedMessage) div 2, ScreenHeight div 2 + 4);
	write('Press ESC button to end');
	while true do
	begin;
		GetKey(c);
		if c = 27 then
			break;
	end;
	clrscr();
end;

begin
	clrscr();
	ShowScore(score);
	GenFood(apple);
	InitSnake();
	while true do
	begin
		if not KeyPressed then { moving }
			begin
			MoveSnake(last);
			if StatusSnake = false then { eat yourself }
				break;
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
			-75: SetDirection(left);
			-77: SetDirection(right);
			-72: SetDirection(down);
			-80: SetDirection(up);
			27: break
		end
	end;
	ShowEnd();
end.
