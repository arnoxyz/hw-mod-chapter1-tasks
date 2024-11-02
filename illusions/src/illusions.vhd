use work.vhdldraw_pkg.all;

entity illusions is
end entity;


architecture arch of illusions is
begin
	squarecircle : entity work.squarecircle;
	checkerboard : entity work.checkerboard;

	--ouchi : entity work.ouchi;
	--concentric : entity work.concentric;
end architecture;
