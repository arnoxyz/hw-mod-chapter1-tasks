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
		constant SIZE_BCD : integer := (log10c(2**bin_in'length-1)*4)-1;
		constant SIZE_LOOP : integer := log10c(2**bin_in'length-1)-1;

		variable localBcd : std_ulogic_vector(SIZE_BCD downto 0);
		variable localDec : integer := 0;
		variable decRange : integer := 0; 
		variable decimalPower : integer := 0;

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
		--convert bin_in to dec
		localDec := 0;
		for i in bin_in'range loop
			if bin_in(i) = '1' then 
				localDec := localDec + (2**i);
			end if;
		end loop;
		dec_out <= localDec;

		--convert dec to bcd
		for i in 0 to SIZE_LOOP-1 loop 
			decimalPower := 10**(SIZE_LOOP-i);
			localBcd((SIZE_BCD)-(4*i) downto (SIZE_BCD-3)-(4*i)) := to_bcd((localDec/decimalPower) mod 10);
		end loop;
		localBcd(3 downto 0) := to_bcd(localDec mod 10);

		bcd_out <= localBcd;
	end process;
end architecture;