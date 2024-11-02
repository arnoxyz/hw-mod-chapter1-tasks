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

		--fill with squares
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


		--fill with rectangles
		j:=0;
		l:=0;
		while j < 400 loop
			i:=0;
			k:=0;
			while i < 350 loop
				if (l mod 2) = 0 then 
					if (k mod 2) = 0 then 
						vhdldraw.setColor(WHITE);
						vhdldraw.fillRectangle(30+i, 38+j, 20, 4);
						vhdldraw.setColor(BLACK);
						vhdldraw.fillRectangle(38+i, 30+j, 4, 20);
					else 
						vhdldraw.setColor(WHITE);
						vhdldraw.fillRectangle(38+i, 30+j, 4, 20);
						vhdldraw.setColor(BLACK);
						vhdldraw.fillRectangle(30+i, 38+j, 20, 4);
					end if;
				else 
					if (k mod 2) = 0 then 
						vhdldraw.setColor(WHITE);
						vhdldraw.fillRectangle(38+i, 30+j, 4, 20);
						vhdldraw.setColor(BLACK);
						vhdldraw.fillRectangle(30+i, 38+j, 20, 4);
					else 
						vhdldraw.setColor(WHITE);
						vhdldraw.fillRectangle(30+i, 38+j, 20, 4);
						vhdldraw.setColor(BLACK);
						vhdldraw.fillRectangle(38+i, 30+j, 4, 20);
					end if;
				end if;
				i:=i+size;
				k:=k+1;
			end loop;
			j:=j+40;
			l:=l+1;
		end loop;


		vhdldraw.show("checkerboard.ppm");
		wait;
	end process;

end architecture;
