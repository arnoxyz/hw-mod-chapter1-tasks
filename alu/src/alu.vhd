library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.alu_pkg.all;

entity alu is
	generic (
		DATA_WIDTH : positive := 32
	);
	port (
		op   : in  alu_op_t;
		a, b : in  std_ulogic_vector(DATA_WIDTH-1 downto 0);
		r    : out std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
		z    : out std_ulogic := '0'
	);
end entity;


architecture arch of alu is 
begin 
	alu_process : process(all) is 
		--derive log2 of DATA_WIDTH (log_2(32) = 4)
		constant x : natural := log2c(DATA_WIDTH);
	begin 
		report to_string(x);

		case op is  
			when ALU_NOP => 
				R <= B;
				Z <= '-';
			when ALU_SLT => 
				if(signed(A) < signed(B)) then 
					R <= (others=>'1');
				else 
					R <= (others=>'0');
				end if;

				Z <= not R(0);
			when ALU_SLTU => 
				if(unsigned(A) < unsigned(B)) then 
					R <= (others=>'1');
				else 
					R <= (others=>'0');
				end if;

				Z <= not R(0);
			when ALU_ADD => 
				R <= std_ulogic_vector(signed(A) + signed(B));
				Z <= '-';
			when ALU_SUB => 
				R <= std_ulogic_vector(signed(A) - signed(B));
				if((signed(A)-signed(B)) = 0) then
					Z <= '1';
				else 
					Z <= '0';
				end if;
			when ALU_AND => 
				R <= A and B;
				Z <= '-';
			when ALU_OR => 
				R <= A or B;
				Z <= '-';
			when ALU_XOR => 
				R <= A xor B;
				Z <= '-';
			when ALU_SLL => 
				R <= std_ulogic_vector(shift_left(unsigned(A), to_integer(unsigned(B(x downto 0)))));
				Z <= '-';
			when ALU_SRL => 
				R <= std_ulogic_vector(shift_right(unsigned(A), to_integer(unsigned(B(x downto 0)))));
				Z <= '-';
			when ALU_SRA => 
				R <= std_ulogic_vector(shift_right(signed(A), to_integer(unsigned(B(x downto 0)))));
				Z <= '-';
		end case;
	end process;
end architecture;


--for learning repeat the exercise
architecture arch2 of alu is 
begin 
	alu_process : process(all) is 
		constant x : integer := log2c(DATA_WIDTH);
	begin 
		case op is 
			when ALU_NOP =>
				R <= B;
				Z <= '-';
			when ALU_SLT =>
				R <= (others => '1') when signed(A) < signed(B) else (others => '0');
				Z <= R(0);
			when ALU_SLTU =>
				R <= (others => '1') when unsigned(A) < unsigned(B) else (others => '0');
				Z <= R(0);
			when ALU_SLL =>
				R <= std_ulogic_vector(shift_left(unsigned(A), to_integer(unsigned(B(x downto 0)))));
				Z <= '-';
			when ALU_SRL =>
				R <= std_ulogic_vector(shift_right(unsigned(A), to_integer(unsigned(B(x downto 0)))));
				Z <= '-';
			when ALU_SRA =>
				R <= std_ulogic_vector(shift_right(signed(A), to_integer(unsigned(B(x downto 0)))));
				Z <= '-';
			when ALU_ADD =>
				R <= std_ulogic_vector(signed(A) + signed(B));
				Z <= '-';
			when ALU_SUB =>
				R <= std_ulogic_vector(signed(A) - signed(B));
				Z <= '1' when ((signed(A)- signed(B))=0) else '0';
			when ALU_AND=>
				R <= A and B; 
				Z <= '-';
			when ALU_OR =>
				R <= A or B; 
				Z <= '-';
			when ALU_XOR =>
				R <= A xor B; 
				Z <= '-';
		end case;

	end process;
end architecture;