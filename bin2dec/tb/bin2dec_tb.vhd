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
	signal bcd_out : std_ulogic_vector((log10c(2**bin_in'length-1)*4)-1 downto 0);
begin
	uut : bin2dec
	port map(
		bin_in => bin_in, 
		dec_out => dec_out,
		bcd_out => bcd_out
	);

	stimuli : process
		procedure test1 is 
		begin 
			for i in 2**width-1 downto 0 loop
				bin_in <= std_ulogic_vector(to_unsigned(i, width));
				wait for 1 ns;
				assert dec_out = to_integer(unsigned(bin_in));
			end loop;
		end procedure;

	begin
		-- apply your stimulus here
		test1;

		-- bin_in <= "0001";
		wait for 1 ns;

		--bin_in <= "0111";
		--wait for 1 ns;
		--report to_string(dec_out) & " " & to_string(bcd_out);
		wait;
	end process;
end architecture;

