use work.vhdldraw_pkg.all;

entity checkerboard is
end entity;

architecture arch of checkerboard is
begin
	process is
		constant size : natural := 40;
		constant cols : natural := 10;
		constant rows : natural := 11;

		variable vhdldraw : vhdldraw_t;
		variable color : color_t := GREEN;

		variable i,j : natural;
		variable k,l : natural := 0;
		-- you might want to add some auxiliary subprograms or constants / variables in here
	begin
		vhdldraw.init(cols * size, rows * size);

		-- draw the illusion here

		--fill with squares
		--TODO toggle color between green and red
		vhdldraw.setColor(BLACK);
		j:=0;
		k:=0;
		l:=0;
		while j < 550 loop
			i:=0;
			k:=l;
			while i < 550 loop
				if (k mod 2) = 1 then 
					vhdldraw.setColor(GREEN);
				else 
					vhdldraw.setColor(BLUE);
				end if;
				vhdldraw.fillSquare(i,j, size);
				i:=i+size;
				k:=k+1;
			end loop;
		j:=j+size;
		l:=l+1;
		end loop;

		vhdldraw.show("checkerboard.ppm");
		wait;
	end process;

end architecture;
