library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.bin2dec_pkg.all;

entity bin2dec is
	port (
		bin_in   : in  std_ulogic_vector;
		dec_out  : out integer;
		bcd_out  : out std_ulogic_vector
	);
end entity;

-- put your architecture here
architecture beh of bin2dec is 
	signal decRange : integer := 0;
begin 
	--convert bin_in to dec_out
	conversion : process(bin_in)  
		variable local_dec : integer := 0;
	begin 
		local_dec := 0;
		for i in bin_in'range loop
			if bin_in(i) = '1' then 
				local_dec := local_dec + (2**i);
			end if;
		end loop;
		dec_out <= local_dec;
		decRange <= local_dec;
	end process;

	--convert dec to bcd
	conversion2 : process(decRange)
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
				when others => return "1111";
			end case;

			return "1111";
		end function;

		variable size : integer := (log10c(decRange)*4)-1;
		--variable local_bcd : std_ulogic_vector((log10c(decRange)*4)-1 downto 0);
		variable local_bcd : std_ulogic_vector(7 downto 0);
	begin 
		for i in 0 to log10c(decRange) loop
			if i = log10c(decRange) then 
				local_bcd(3 downto 0) := to_bcd(decRange mod 10);
			else 
				local_bcd(7 downto 4) := to_bcd(decRange/(10**i));
			end if;
		end loop;
		bcd_out <= local_bcd;
	end process;
end architecture;