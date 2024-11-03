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

	signal bcd_out : std_ulogic_vector(3 downto 0);
begin
	uut : bin2dec
	port map(
		bin_in => bin_in, 
		dec_out => dec_out,
		bcd_out => bcd_out
	);

	stimuli : process
	begin
		-- apply your stimulus here
		-- This is just a template - adjust to your needs!
		-- report to_string(bin_in) & " is decimal:" & to_string(dec_out) & " is BCD " & to_string(bcd_out);
		for i in 2**width-1 downto 0 loop
			bin_in <= std_ulogic_vector(to_unsigned(i, width));
			wait for 1 ns;
			assert dec_out = to_integer(unsigned(bin_in));
		end loop;
		--report to_string(dec_out) & " " & to_string(bcd_out);
		wait;
	end process;
end architecture;

