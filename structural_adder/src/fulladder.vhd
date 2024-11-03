library ieee;
use ieee.std_logic_1164.all;
use work.adder4_pkg.all;

entity fulladder is
	port (
		A    : in std_ulogic;
		B    : in std_ulogic;
		Cin  : in std_ulogic;

		Sum  : out std_ulogic;
		Cout : out std_ulogic
	);
end entity;

-- implement fulladder architecture
architecture beh of fulladder is 
	signal cout1, cout2 : std_ulogic;
	signal sum1 : std_ulogic;
begin 
	ha1 : halfadder
	port map(
		a => a, 
		b => b,
		sum => sum1,
		cout => cout1
	);


	ha2 : halfadder
	port map(
		a => sum1, 
		b => Cin,
		sum => sum,
		cout => cout2
	);

	--or the two cout
	cout <= cout1 or cout2;
end architecture;
