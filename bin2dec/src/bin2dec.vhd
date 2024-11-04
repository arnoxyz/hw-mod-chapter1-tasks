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
begin 
	--convert bin_in to dec_out
	conversion : process(all)  
		variable local_dec : integer := 0;

		variable size : integer := 0;
		variable local_bcd : std_ulogic_vector((log10c(2**bin_in'length-1)*4)-1 downto 0);
		variable decRange : integer := 0;
		variable loopSize : integer := 0;
		variable number : integer := 0;

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

	begin 
		local_dec := 0;
		for i in bin_in'range loop
			if bin_in(i) = '1' then 
				local_dec := local_dec + (2**i);
			end if;
		end loop;

		dec_out <= local_dec;
		decRange := local_dec;

		size := (log10c(2**bin_in'length-1)*4)-1;
		loopSize := log10c(2**bin_in'length-1)-1;
		number := 0;

		for i in 0 to loopSize-1 loop 
			number := 10**(loopSize-i);
			local_bcd((size)-(4*i) downto ((size-3)-(4*i))) := to_bcd(decRange/number mod 10);
		end loop;

		local_bcd(3 downto 0) := to_bcd(decRange mod 10);

		bcd_out <= local_bcd;
	end process;
end architecture;