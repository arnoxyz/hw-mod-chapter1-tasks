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
	signal op : alu_op_t;
	signal a : std_ulogic_vector(DATA_WIDTH-1 downto 0);
	signal b : std_ulogic_vector(DATA_WIDTH-1 downto 0);
	signal r : std_ulogic_vector(DATA_WIDTH-1 downto 0);
	signal z : std_ulogic;
begin
	-- Instantiate your ALU here
	uut : alu
	port map(
		a => a, 
		b => b, 
		r => r, 
		z => z,
		op => op
	);

	stimuli : process 
	begin
		report "start simulation";
		-- apply your stimulus here
		op <= ALU_NOP;
		wait for 1 ns;
		op <= ALU_SLT;
		wait for 1 ns;
		op <= ALU_SLTU;
		wait for 1 ns;
		op <= ALU_SLL;
		wait for 1 ns;
		op <= ALU_SRL;
		wait for 1 ns;
		op <= ALU_SRA;
		wait for 1 ns;
		op <= ALU_ADD;
		wait for 1 ns;
		op <= ALU_SUB;
		wait for 1 ns;
		op <= ALU_AND;
		wait for 1 ns;
		op <= ALU_OR;
		wait for 1 ns;
		op <= ALU_XOR;
		wait for 1 ns;

		report "simulation done";
		wait;
	end process;
end architecture;

