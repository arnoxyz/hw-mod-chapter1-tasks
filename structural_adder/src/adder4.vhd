library ieee;
use ieee.std_logic_1164.all;
use work.adder4_pkg.all;

entity adder4 is
	port (
		A    : in std_ulogic_vector(3 downto 0);
		B    : in std_ulogic_vector(3 downto 0);
		Cin  : in std_ulogic;

		S    : out std_ulogic_vector(3 downto 0);
		Cout : out std_ulogic
	);
end entity;

-- implement adder4 architecture
architecture beh of adder4 is 
	signal c1, c2, c3 : std_ulogic;
begin 

	fa1 : fulladder
	port map(
		a => a(0),
		b => b(0),
		cin => cin,
		cout => c1,
		sum => s(0)
	);

	fa2 : fulladder 
	port map(
		a => a(1),
		b => b(1),
		cin => c1,
		cout => c2,
		sum => s(1)
	);

	fa3 : fulladder 
	port map(
		a => a(2),
		b => b(2),
		cin => c2,
		cout => c3,
		sum => s(2)
	);

	fa4 : fulladder 
	port map(
		a => a(3),
		b => b(3),
		cin => c3,
		cout => cout,
		sum => s(3)
	);
end architecture;
