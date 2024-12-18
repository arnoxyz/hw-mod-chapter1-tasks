--What the Program should do:
--Input String -->>> Barcode.vhd -->> output Barcode that reprsesents that string

--TODO: prestart coding: Planning and get knowledge
	--TODO: Study Cod 238 Wiki Article 
	--TODO: Barcode_pkg (study types and usefull stuff, -> code128_table)
	--TODO: barcode.vhd file (pre-defines variables and constants)
	--TODO: extend in barcode.vhd the barcode_maker process (that it draws a 128A and 128B)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.math_pkg.all;
use work.barcode_pkg.all;
use work.vhdldraw_pkg.all;

entity barcode is
end entity;

architecture arch of barcode is

begin
	barcode_maker : process
		constant bar_width : natural := 2;                -- Width of a single bar ("module" in Wikipedia article)
		constant quiet_zone : natural := 15 * bar_width;  -- "quite zone" of the code (a bit more than in the Wikipedia article)
		constant input_str: string := "HW_MOD 2024W";

		variable vhdldraw : vhdldraw_t;

		variable bar_height : natural;           -- Calculate based on window width
		variable width : natural := 400;         -- determine based on input string, 400 ist just a placeholder
		variable y_pos : natural;                -- y position for the barcode bars
		variable x_pos : natural := quiet_zone;  -- x position for drawing

	begin


		--TODO: Create barcode_vector with 0=white,1=black
			--TODO: identify the start code
			--TODO: extract signle ASCII characters from input_str 
				--TODO: study Character Literals and Attributes in VHDL (convert character literals and integer values)
			--TODO: use the code128_table to map chars to codes	
				--TODO:code table contains all patterns from wikipedia article
			--TODO: calc checksum
			--TODO: add stop code
		
		-- Initialize drawing window (having width / 10 as top and bottom margin looks nice,  / 10 works as bar height)
		vhdldraw.init(width, 6 * width / 10); -- This is just a dummy initialization -> adjust for total barcode width

		--TODO: draw barcode with fillRectangle() and the black,white colors from vector
		
		-- Show the resulting barcode image
		vhdldraw.show(input_str & "_barcode.ppm");

		wait;  -- Wait indefinitely
	end process;
end architecture;
