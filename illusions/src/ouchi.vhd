use work.vhdldraw_pkg.all;

entity ouchi is
end entity;

architecture arch of ouchi is
begin
	process is
		constant window_size : natural := 800;
		constant width : natural := 32;
		constant height : natural := 8;
		variable vhdldraw : vhdldraw_t;

		constant innterRectWidth: natural := 200;
		constant innerRectHeight : natural := 224;

		constant verticalRectWidth : natural := 8;
		constant verticalRectHeight: natural := 32;

		variable i : natural := 0;
		variable j : natural := 0;

		-- procedure draw line and color
		procedure draw_line (draw_width : natural) is 
		begin 
			i:=0;
			while i < 800 loop
				vhdldraw.fillRectangle(i, draw_width, width, height);		
				i:=i+2*width;
			end loop;
		end procedure;

	begin
		report "~~~~~~ drawing ouchi.ppm now ~~~~~~";
		vhdldraw.init(window_size);
		vhdldraw.setColor(WHITE);
		vhdldraw.fillRectangle(0,0, 800, 800);		
		draw_line(0);

		vhdldraw.show("ouchi.ppm");
		wait;
	end process;

end architecture;
