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

		procedure fillWithSquares(color1 : color_t; color2 : color_t) is 
			variable i,j,k,l : natural := 0;
		begin 
			while j < 550 loop
			i:=0;
			k:=l;
				while i < 550 loop
					if (k mod 2) = 1 then 
						vhdldraw.setColor(color1);
					else 
						vhdldraw.setColor(color2);
					end if;
					vhdldraw.fillSquare(i,j, size);
					i:=i+size;
					k:=k+1;
				end loop;
			j:=j+size;
			l:=l+1;
			end loop;
		end procedure;

		procedure drawRectangleColor(x,y,width,height : natural; color : color_t) is 
		begin 
			vhdldraw.setColor(color);
			vhdldraw.fillRectangle(x, y, width, height);
		end procedure;

		procedure fillWithRectangles(color1 : color_t; color2 : color_t) is 
			variable i,j,k,l : natural := 0;
		begin 
			while j < 400 loop
			i:=0;
			k:=0;
				while i < 350 loop
					if (l mod 2) = 0 then 
						if (k mod 2) = 0 then 
							drawRectangleColor(30+i,38+j,20,4,color1);
							drawRectangleColor(38+i,30+j,4,20,color2);
						else 
							drawRectangleColor(38+i,30+j,4,20,color1);
							drawRectangleColor(30+i,38+j,20,4,color2);
						end if;
					else 
						if (k mod 2) = 0 then 
							drawRectangleColor(38+i,30+j,4,20,color1);
							drawRectangleColor(30+i,38+j,20,4,color2);
						else 
							drawRectangleColor(30+i,38+j,20,4,color1);
							drawRectangleColor(38+i,30+j,4,20,color2);
						end if;
					end if;
				i:=i+size;
				k:=k+1;
				end loop;
			j:=j+40;
			l:=l+1;
			end loop;
		end procedure;

		procedure drawCheckerboard(squareColor1 : color_t; squareColor2 : color_t; rectangleColor1 : color_t; rectangleColor2 : color_t) is 
		begin 
			vhdldraw.init(cols * size, rows * size);
			--fill with squares - Background
			fillWithSquares(squareColor1,squareColor2);
			--fill with rectangles
			fillWithRectangles(rectangleColor1,rectangleColor2);
		end procedure;

	begin
		report "~~~~~~ drawing checkerboard.ppm now ~~~~~~";
		drawCheckerboard(GREEN,BLUE,WHITE,BLACK);
		vhdldraw.show("checkerboard.ppm");

		--different coloring v1
		--drawCheckerboard(GREEN,BLUE,BLUE,BLUE);
		--drawCheckerboard(GREEN,BLUE,BLUE,GREEN);
		wait;
	end process;

end architecture;
