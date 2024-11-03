library ieee;
use ieee.std_logic_1164.all;
use work.adder4_pkg.all;

entity halfadder is
	port (
		A : in std_ulogic;
		B : in std_ulogic;

		Sum  : out std_ulogic;
		Cout : out std_ulogic
	);
end entity;

-- implement the halfadder architecture
architecture beh of halfadder is 
begin 
	xor_gate1 : xor_gate 
	port map(
		a => a,
		b => b, 
		z => Sum
	);

	and_gate1 : and_gate 
	port map (
		a => a, 
		b => b,
		z => Cout
	);
end architecture;