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

		constant circleSize : natural := 30;
		constant circleLineWidth : natural := 4;

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

		--fill with circles
		vhdldraw.setColor(BLACK);
		vhdldraw.setLineWidth(circleLineWidth);
		i:=0;
		while i < 500 loop
			vhdldraw.drawCircle(60+i,60, circleSize);
			i:=i+60;
		end loop;


		vhdldraw.show("squarecircle.ppm");
		wait;
	end process;

end architecture;
