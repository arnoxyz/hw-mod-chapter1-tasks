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


	--TODO:
	--convert dec to bcd
	--conversion2 : process(bin_in)
	-- begin 
	-- 	for i in dec_out'range loop
	-- 		bcd_out <= bin_in;
	-- 	end loop;
	-- end process;

end architecture;