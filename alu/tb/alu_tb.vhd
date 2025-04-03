library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.math_pkg.all;
use work.alu_pkg.all;

entity alu_tb is
end entity;

architecture tb of alu_tb is
	constant DATA_WIDTH : positive := 32;
	constant x : natural := log2c(DATA_WIDTH);
	signal op : alu_op_t;
	signal a : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (0=>'1', 2=>'1', others=>'0');
	signal b : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (0=>'1', 3=>'1', others=>'0');
	signal r : std_ulogic_vector(DATA_WIDTH-1 downto 0);
	signal z : std_ulogic;

begin
	-- Instantiate your ALU here
	uut : entity work.alu(arch2)
	port map(
		a => a, 
		b => b, 
		r => r, 
		z => z,
		op => op
	);

	stimuli : process 
	begin
		report "DataWidth=" & to_string(DATA_WIDTH) & ", log2(" & to_string(DATA_WIDTH) & ")=" & to_string(x); 

		report "start simulation";
		-- apply your stimulus here
		op <= ALU_NOP;
		wait for 1 ns;
		assert r = b report "ALU_NOP error" severity error;

--arithmetic operations
		op <= ALU_ADD;
		wait for 1 ns;
		assert r = std_ulogic_vector(signed(a) + signed(b)) report "ALU_ADD error" severity error;

		op <= ALU_SUB;
		wait for 1 ns;
		assert r = std_ulogic_vector(signed(a) - signed(b)) report "ALU_ADD error" severity error;

--logic operations
		op <= ALU_AND;
		wait for 1 ns;
		assert r = (a and b) report "ALU_AND error" severity error;

		op <= ALU_OR;
		wait for 1 ns;
		assert r = (a or b) report "ALU_AND error" severity error;

		op <= ALU_XOR;
		wait for 1 ns;
		assert r = (a xor b) report "ALU_AND error" severity error;

		op <= ALU_SLT;
		wait for 1 ns;
		if unsigned(a) < unsigned(b) then 
			assert r(0) = '1' report "ALU_SLTU error" severity error;
		else 
			assert r(0) = '0' report "ALU_SLTU error" severity error;
		end if;

		op <= ALU_SLTU;
		wait for 1 ns;
		if signed(a) < signed(b) then 
			assert r(0) = '1' report "ALU_SLT error" severity error;
		else 
			assert r(0) = '0' report "ALU_SLT error" severity error;
		end if;

--shift operations
		op <= ALU_SLL;
		wait for 1 ns;
		assert r = std_ulogic_vector(shift_left(unsigned(A), to_integer(unsigned(B(x downto 0))))) report "ALU_SLL error" severity error;

		A <= (DATA_WIDTH-1 => '1', DATA_WIDTH-2 => '1', others=>'0');
		wait for 1 ns;

		op <= ALU_SRL;
		wait for 1 ns;
		assert r = std_ulogic_vector(shift_right(unsigned(A), to_integer(unsigned(B(x downto 0))))) report "ALU_SRL error" severity error;

		op <= ALU_SRA;
		wait for 1 ns;
		assert r = std_ulogic_vector(shift_right(signed(A), to_integer(signed(B(x downto 0))))) report "ALU_SRA error" severity error;

		report "simulation done";
		wait;
	end process;
end architecture;

