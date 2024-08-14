library IEEE;

use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_1164.all;
entity PC is
    generic(
        VAL : std_logic_vector(31 downto 0):= x"00000000"
    );
	port(clr, clk, wr, IncPC: in std_logic;
			inputD: in std_logic_vector(31 downto 0);
			outputQ : buffer std_logic_vector(31 downto 0):=VAL
			);
end entity PC;

ARCHITECTURE behaviour OF PC IS

BEGIN
	
    process(clk)
	 
    begin
        if clr = '1' then
            outputQ <= x"00000000";

        elsif (clk'event and clk ='1') then
            if (wr = '1') then
					 outputQ <= inputD;
				end if;
				if(incPC = '1') then
					  outputQ <= outputQ+1;
            end if;
       end if;
    end process;
end architecture behaviour;