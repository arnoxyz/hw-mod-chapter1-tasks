library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.adder4_pkg.all;

entity adder4_tb is
end entity;

architecture tb of adder4_tb is
	-- You might want to add some signals
	signal a,b : std_ulogic := '0';
	signal z1,z2 : std_ulogic;
	signal sum_ha, cout_ha : std_ulogic;
	signal sum_fa, cout_fa, cin_fa : std_ulogic;
begin

	--TASK 1: implement xor_gate, and_gate
	xor_gate1 : xor_gate 
	port map(
		a => a,
		b => b,
		z => z1
	);

	and_gate1 : and_gate
	port map(
		a => a,
		b => b,
		z => z2
	);

	--TASK 2: implement half adder with xor_gate, and_gate
	halfadder1 : halfadder 
	port map(
		a => a, 
		b => b, 
		cout => cout_ha,
		sum => sum_ha
	);

	--TASK 3: implement full adder with half adders
	fulladder1 : fulladder	
	port map(
		a => a, 
		b => b,
		cin => cin_fa,
		sum => sum_fa,
		cout => cout_fa
	);

	testGates : process 
	begin 
		report "sim xor_gate, and_gate, halfadder, fulladder";
		a <= '0';
		b <= '1';
		cin_fa <= '0';
		wait for 1 ns;
		assert z1 = (a xor b) report "xor_gate not working";
		assert z2 = (a and b) report "and_gate not working";
		assert cout_ha = (a and b) report "cout_ha not working";
		assert sum_ha = (a xor b) report "sum_ha not working";
		assert cout_fa = ((a and b) or (cin_fa and (a and b))) report "cout_fa not working";
		assert sum_fa = ((a xor b) xor cin_fa) report "sum_fa not working";

		a <= '1';
		b <= '1';
		cin_fa <= '0';
		wait for 1 ns;
		assert z1 = (a xor b) report "xor_gate not working";
		assert z2 = (a and b) report "and_gate not working";
		assert cout_ha = (a and b) report "cout_ha not working";
		assert sum_ha = (a xor b) report "sum_ha not working";
		assert cout_fa = ((a and b) or (cin_fa and (a and b))) report "cout_fa not working";
		assert sum_fa = ((a xor b) xor cin_fa) report "sum_fa not working";
		report "sim done";

		wait;
	end process;

	-- Instantiate the unit under test (adder4)

	-- Stimulus process
	stimulus: process
		-- implement this procedure!
		procedure test_values(value_a, value_b, value_cin : integer) is
		begin
			-- assert that Sum is correct
			-- assert Cout is correct
		end procedure;
	begin
		report "simulation start";
		
		-- Apply test stimuli
		test_values(0,0,0);

		report "simulation end";
		-- End simulation
		wait;
	end process;
end architecture;

