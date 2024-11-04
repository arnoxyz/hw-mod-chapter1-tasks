library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.adder4_pkg.all;

entity adder4_tb is
end entity;

architecture tb of adder4_tb is
	-- You might want to add some signals
	signal a,b : std_ulogic := '0';
	signal z1,z2,z3 : std_ulogic;
	signal sum_ha, cout_ha : std_ulogic;
	signal sum_fa, cout_fa, cin_fa : std_ulogic;

	--signals for uut (adder4)
	signal a_adder4, b_adder4, s_adder4 : std_ulogic_vector(3 downto 0);
	signal cin_adder4, cout_adder4 : std_ulogic;
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

	or_gate1 : or_gate
	port map(
		a => a,
		b => b,
		z => z3
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
		procedure simulation(a1 : std_ulogic; b1 : std_ulogic; c1 : std_ulogic) is 
		begin 
			report "testing with (a,b,c_in)=(" & to_string(a1) & "," & to_string(b1) & "," & to_string(c1) & ")";
			a <= a1;
			b <= b1;
			cin_fa <= c1;
			wait for 1 ns;
			assert z1 = (a xor b) report "xor_gate not working";
			assert z2 = (a and b) report "and_gate not working";
			assert z3 = (a or b) report "or_gate not working";
			assert cout_ha = (a and b) report "cout_ha not working";
			assert sum_ha = (a xor b) report "sum_ha not working";
			assert cout_fa = ((a and b) or (cin_fa and a) or (cin_fa and b)) report "cout_fa not working";
			assert sum_fa = ((a xor b) xor cin_fa) report "sum_fa not working";
		end procedure;
	begin 
		report "sim xor_gate, and_gate, or_gate, halfadder, fulladder";
		simulation('1','1','1');
		simulation('1','1','0');
		simulation('1','0','1');
		simulation('1','0','0');
		simulation('0','1','1');
		simulation('0','1','0');
		simulation('0','0','1');
		simulation('0','0','0');
		report "sim done";

		wait;
	end process;

	-- Instantiate the unit under test (adder4)
	uut : adder4 
	port map(
		a => a_adder4,
		b => b_adder4,
		cin => cin_adder4,
		s => s_adder4,
		cout => cout_adder4
	);

	-- Stimulus process
	stimulus: process
		-- implement this procedure!
		procedure test_values(value_a, value_b, value_cin : integer) is
			variable local_sum : std_ulogic_vector(3 downto 0) := "0000";
		begin
			a_adder4 <= std_ulogic_vector(to_unsigned(value_a, 4));
			b_adder4 <= std_ulogic_vector(to_unsigned(value_b, 4));
			cin_adder4 <= std_logic(to_unsigned(value_cin, 1)(0));

			wait for 1 ns;
			local_sum := std_ulogic_vector(to_unsigned(value_a, 4)+to_unsigned(value_b, 4)+to_unsigned(value_cin, 1)(0));

			assert s_adder4 = local_sum  report "sum for (" & to_string(value_a)  & " " & to_string(value_b) & " "  & to_string(value_cin) & ") is false " & "local sum is = " & to_string(local_sum);
			assert cout_adder4 = to_unsigned(value_a+value_b+value_cin, 5)(4)  report "cout for (" & to_string(value_a)  & " " & to_string(value_b) & " "  & to_string(value_cin) & ") is false";
		end procedure;
	begin
		report "simulation start";

		-- Apply test stimuli
		for i in 0 to 2**4-1 loop
			for j in 0 to 2**4-1 loop
				for k in 0 to 1 loop
					test_values(i,j,k);
				end loop;
			end loop;
		end loop;

		report "simulation end";
		-- End simulation
		wait;
	end process;
end architecture;

