unit getkeyunit;

interface
uses crt;
procedure GetKey(var code: integer);

implementation

procedure GetKey(var code: integer);
var
	c: char;

begin
	c := ReadKey;
	if c = #0 then
	begin
		c := ReadKey;
		code := -ord(c);
	end
	else
	begin
		code := ord(c);
	end;
end;
end.
