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


-- using generate statements
architecture beh2 of adder4 is
    signal c : std_ulogic_vector(3 downto 0);  -- Carry signals for full adders
begin

	fa : fulladder
	port map(
		a => a(0),
		b => b(0),
		cin => cin,
		cout => c(0),     -- Carry out from each full adder
		sum => s(0)
	);

    -- Generate block to instantiate full adders
    gen_fas : for i in 1 to 3 generate
        -- Assign cin_temp based on the loop index
        fa : fulladder
        port map(
            a => a(i),
            b => b(i),
			cin => (c(i-1)),
            cout => c(i),   
            sum => s(i)
        );
    end generate gen_fas;

    -- Final carry out
    cout <= c(3);  -- The last carry out is the overall carry out

end architecture;