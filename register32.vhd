library IEEE;
use IEEE.std_logic_1164.all;

entity register32 is
    generic(
        VAL : std_logic_vector(31 downto 0):= x"00000000"
    );
	port(clr, clk, wr: in std_logic;
			inputD: in std_logic_vector(31 downto 0);
			outputQ : out std_logic_vector(31 downto 0):=VAL
			);
end entity register32;

ARCHITECTURE behaviour OF register32 IS

BEGIN
	
    process(clk)
	 
    begin
        if clr = '1' then
            outputQ <= x"00000000";

        elsif (clk'event and clk ='1') then
            if (wr = '1') then
					 outputQ <= inputD;
            end if;
       end if;
    end process;
end architecture behaviour;

