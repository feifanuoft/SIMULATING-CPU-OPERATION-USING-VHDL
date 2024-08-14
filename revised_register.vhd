LIBRARY ieee;
use ieee.std_logic_1164.all;

entity revised_register is
port(
		BAout : in std_logic;
		registeroutQ: in std_logic_vector(31 downto 0);
		BusMuxIn_R: out std_logic_vector(31 downto 0)
		);
end entity revised_register;

architecture behaviour of revised_register is
begin	
	 process(BAout) is
	 begin
		if BAout = '1' then
			BusMuxIn_R <= x"00000000";
		else
			BusMuxIn_R <= registeroutQ;
			end if;
		end process;
	 
end architecture;

