use work.vhdldraw_pkg.all;

entity squarecircle is
end entity;

architecture arch of squarecircle is
begin
	process is
		constant size : natural := 600;
		variable vhdldraw : vhdldraw_t;

		constant spaceSquares : natural := 10; 
		constant squareSize : natural := 50; 
		constant squareLineWidth : natural := 3;

		-- you might want to add some auxiliary subprograms or constants / variables in here
		variable i : natural;
		variable j : natural;

		
	begin
		vhdldraw.init(size);

		report "fuck this shit";
		-- draw the illusion here
		vhdldraw.setColor(WHITE);
		vhdldraw.fillRectangle(0,0, size, size);		

		--fill with squares
		vhdldraw.setColor(BLACK);
		vhdldraw.setLineWidth(squareLineWidth);
		j:=0;
		while j < 550 loop
			i:=0;
			while i < 550 loop
				vhdldraw.drawSquare(5+i,5+j, squareSize);
				i:=i+50+spaceSquares;
			end loop;
		j:=j+50+spaceSquares;
		end loop;




		vhdldraw.show("squarecircle.ppm");
		wait;
	end process;

end architecture;
