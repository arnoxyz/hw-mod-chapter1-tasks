library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.vhdldraw_pkg.all;


entity creative is
end entity;

architecture arch of creative is
	type valid_forms_t is (SQUARE, RECT, CIRCLE);
	type valid_colors_t is ('R', 'B', 'Y', 'W');

	signal form : valid_forms_t;
	signal color : valid_colors_t;
begin
	main : process is
		variable draw : vhdldraw_t;
		variable ran : std_ulogic_vector(15 downto 0) := x"010f";

		--generate random number
		impure function gen_randomInt return integer is
		begin
			ran := ran(15 downto 8) & ran(6 downto 0) & (ran(7) xor ran(6) xor ran(2) xor ran(1) xor ran(8));
			return to_integer(unsigned(ran));
		end function;

		--generates valid color
		impure function gen_color return valid_colors_t is 
			variable number : integer;
		begin 
			number := gen_randomInt;
			number := number mod 4;
			case number is 
				when 0 => return 'R';
				when 1 => return 'B';
				when 2 => return 'Y';
				when 3 => return 'W';
				when others => return 'W';
			end case;
					
			return 'W';
		end function;

		--generates valid form
		impure function gen_form return valid_forms_t is 
			variable number : integer;
		begin 
			number := gen_randomInt;
			number := number mod 3;
			case number is 
				when 0 => return RECT;
				when 1 => return CIRCLE;
				when 2 => return SQUARE;
				when others => return SQUARE;
			end case;
					
			return SQUARE;
		end function;

		--draws one random structure
		procedure draw_form(number: integer) is
			variable form : valid_forms_t;
			variable color : valid_colors_t;
			variable x, y : integer;
		begin

			x:= gen_randomInt mod 400;
			y:= gen_randomInt mod 400;

			form := gen_form;

			while (to_unsigned(x, 16) or to_unsigned(y, 16)) < 400 loop 
				color := gen_color;

				case color is 
					when 'R' => 
						draw.setColor(RED);
					when 'B' => 
						draw.setColor(BLUE);
					when 'Y' => 
						draw.setColor(YELLOW);
					when 'W' => 
						draw.setColor(BLACK);
				end case;
					case form is 
						when RECT =>
							draw.drawRectangle(x,y,1,75);
							draw.drawRectangle(x,y,75,5);
							draw.drawRectangle(x,y,8,5);
							draw.drawRectangle(x,y,3,8);
						when CIRCLE =>
							draw.drawCircle(x,y,50);
							draw.drawCircle(x,y,5);
							draw.drawCircle(x,y,2);
							draw.drawCircle(x,y,1);
						when SQUARE =>
							draw.drawSquare(x,y,200);
							draw.drawSquare(x,y,21);
							draw.drawSquare(x,y,2);
							draw.drawSquare(x,y,1);
					end case;

					case form is 
						when RECT =>
							draw.drawRectangle(y,x,150,1);
							draw.drawCircle(y,x,125);
							draw.drawSquare(x,y,50);
						when CIRCLE =>
							draw.drawRectangle(y,x,50,100);
							draw.drawSquare(x,y,50);
							draw.drawCircle(y,x,35);
						when SQUARE =>
							draw.drawSquare(x,y,250);
							draw.drawCircle(y,x,115);
							draw.drawRectangle(y,x,50,1);
					end case;

					x:=x+1;
					y:=y+1;
			end loop;

			--report "drawing " & to_string(form) & " with color " & to_string(color) & " pos (" & to_string(x) & "," & to_string(y) & ")";
		end procedure;


	begin
		draw.init(400, 400);

		--draw_form(number: integer; x: integer; y: integer) is
		for i in 0 downto -777 loop
			draw_form(i);
		end loop;

		draw.show("creative.ppm");
		wait;
	end process;
end architecture;
