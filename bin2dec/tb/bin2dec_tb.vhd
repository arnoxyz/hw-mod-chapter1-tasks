library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.math_pkg.all;
use work.bin2dec_pkg.all;

entity bin2dec_tb is
end entity;

architecture tb of bin2dec_tb is
	constant width : integer := 4;
	signal bin_in : std_ulogic_vector(width-1 downto 0);
	signal dec_out : integer;
	constant BCD_UPPER_BOUND : integer := (log10c(2**bin_in'length-1)*4)-1;
	signal bcd_out : std_ulogic_vector(BCD_UPPER_BOUND downto 0);
begin
	uut : bin2dec
	port map(
		bin_in => bin_in, 
		dec_out => dec_out,
		bcd_out => bcd_out
	);

	stimuli : process
		function to_bcd(a : integer) return std_ulogic_vector is 
		begin 
			case a is
				when 1 => return "0001";
				when 2 => return "0010";
				when 3 => return "0011";
				when 4 => return "0100";
				when 5 => return "0101";
				when 6 => return "0110";
				when 7 => return "0111";
				when 8 => return "1000";
				when 9 => return "1001";
				when others => return "0000";
			end case;

			return "1111";
		end function;

		function to_bcd_All(decRange : integer) return std_ulogic_vector is 
			variable local_bcd : std_ulogic_vector(BCD_UPPER_BOUND downto 0) := (others => '0'); 
		begin 
			for i in 0 to log10c(decRange) loop
				if i = log10c(decRange) then 
					local_bcd(3 downto 0) := to_bcd(decRange mod 10);
				else 
					local_bcd((BCD_UPPER_BOUND)-(4*i) downto ((BCD_UPPER_BOUND-3)-(4*i))) := to_bcd(decRange/(10**(i+1)));
				end if;
			end loop;

			return local_bcd;
		end function;


		procedure test1 is 
		begin 
			for i in 2**width-1 downto 0 loop
				bin_in <= std_ulogic_vector(to_unsigned(i, width));
				wait for 1 ns;
				assert dec_out = to_integer(unsigned(bin_in)) report to_string(dec_out) & " " & to_string(to_integer(unsigned(bin_in)));
			end loop;
		end procedure;

		procedure test2 is 
		begin 
			for i in 2**width-1 downto 0 loop
				bin_in <= std_ulogic_vector(to_unsigned(i, width));
				wait for 1 ns;
				assert dec_out = to_integer(unsigned(bin_in)) report to_string(dec_out) & " " & to_string(to_integer(unsigned(bin_in)));
				assert bcd_out = to_bcd_all(to_integer(unsigned(bin_in))) report to_string(bcd_out) & " " & to_string(to_bcd_all(to_integer(unsigned(bin_in))));
			end loop;
		end procedure;

	begin
		--test0 - mini test with fixed values
		--bin_in <= "0001";
		--wait for 1 ns;
		--bin_in <= "0111";
		--wait for 1 ns;
		--report to_string(dec_out) & " " & to_string(bcd_out);

		-- apply your stimulus here
		--only tests the binary to decimal conversion	
		test1;

		--tests also bcd conversion
		test2;

		wait;
	end process;
end architecture;

