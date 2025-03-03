--Goal: write testbench for the SRAM on the FPGA

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sram_pkg.all;

entity sram_tb is
end entity;

architecture tb of sram_tb is
	signal A : addr_t;
	signal IO : word_t;
	signal CE_N, OE_N, WE_N, LB_N, UB_N : std_ulogic := '1';


	function max(x, y : time) return time is
	begin
		if x < y then
			return y;
		end if;
		return x;
	end function;
begin


	stimulus : process is
		constant testdata : std_ulogic_vector := x"AAAA_BBBB_CCCC_DDDD";
		variable read_data : std_ulogic_vector(testdata'range);

		--Implementation of read cycle 2
		procedure read(addr : integer; variable data : out word_t; byteen : byteena_t := "11") is begin
			A <= std_ulogic_vector(to_unsigned(addr, A'length));
			CE_N <= '0';
			OE_N <= '0';
			LB_N <= not byteen(0);
			UB_N <= not byteen(1);
			wait for TAA;
			-- Do not sample immediately; as long as the inputs are stable we can wait arbitrarily long here -> TRC is just a minimum read cycle time
			wait for 1 ns;
			data := IO;
			LB_N <= '1';
			UB_N <= '1';
			OE_N <= '1';
			CE_N <= '1';
			wait for max(THZOE, THZCE); -- TRC is just a minimal time. With TAA=TRC we already waited for this time. However, the read cycle can take arbitrarily long with only a minimum cycle time given. Hence we wait here for the control signals to take effect.
		end procedure;

		--Implementation of write cycle 1
		procedure write(addr : integer; data : word_t; byteen : byteena_t := "11") is begin
			-- write cycle 1
			A <= std_ulogic_vector(to_unsigned(addr, A'length));
			wait for TSA;
			CE_N <= '0';
			WE_N <= '0';
			LB_N <= not byteen(0);
			UB_N <= not byteen(1);
			wait for THZWE;
			IO <= data;
			if OE_N = '1' then
				wait for max(TSCE, TPWE1) - THZWE;
			else
				wait for max(TSCE, TPWE2) - THZWE;
			end if;
			CE_N <= '1';
			WE_N <= '1';
			LB_N <= '1';
			UB_N <= '1';
			wait for THD;
			IO <= (others => 'Z');
			wait for max(max(TLZWE, THZB), THZCE); -- wait for control signals to take effect
		end procedure;

	begin
		-- Initialization
		A <= (others => '0');
		CE_N <= '1';
		WE_N <= '1';
		OE_N <= '1';
		IO <= (others => 'Z');
		-- This enables reading and writing of both bytes -> you can always keep this low
		LB_N <= '0';
		UB_N <= '0';
		wait for 20 ns;

		-- write to and read from memory
		OE_N <= '0';
		CE_N <= '1';
		wait for max(TLZWE, 4 ns);

		-- write 1 for OE_N=0 then read via read cycle 2
		OE_N <= '0';
		CE_N <= '1';
		wait for max(TLZWE, 4 ns); -- the datasheet state for write1 that it was tested with OE_N being set to high at least 4 ns before WE_N is changed -> let's also wait for this time for the OE_N=0 case to be on the safe side, although it might be too high
		-- write to the SRAM using write cycle 1
		for i in 0 to testdata'high/16 loop
			write(i, testdata(16*i to 16*(i+1)-1));
			report(to_string(i) & " data: " & to_hstring(testdata(16*i to 16*(i+1)-1)));
		end loop;
		-- read cycle 2 expect OE_N=CE_N=1 at its beginning
		OE_N <= '1';
		CE_N <= '1';
		wait for max(THZOE, THZCE); -- wait for control signals to take effect
		-- Run read cycle 2
		for i in 0 to testdata'high/16 loop
			read(i, read_data(16*i to 16*(i+1)-1));
		end loop;
		report to_hstring(read_data);
		wait for 20 ns;

		wait;
	end process;

	dut : entity work.sram
	port map(
		A => A,
		IO => IO,
		CE_N => CE_N,
		OE_N => OE_N,
		WE_N => WE_N,
		LB_N => LB_N,
		UB_N => UB_N
	);
end architecture;
