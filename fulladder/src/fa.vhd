library ieee;
use ieee.std_logic_1164.all;

entity fa is
	port(
		a, b, cin  : in std_ulogic;
		sum, cout : out std_ulogic
	);
end entity;

architecture arch of fa is
	signal x,y : std_ulogic;
begin
	process(all) is 
	begin 
		x <= a xor b;
		y <= a and b;
		sum <= cin xor x;
		cout <= (cin and x) or y;
	end process;
end architecture;
