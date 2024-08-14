library IEEE;
use IEEE.std_logic_1164.all;

entity register64 is
	port(clr, clk,wr: in std_logic;
			inputD: in std_logic_vector(63 downto 0);
			outputHi : out std_logic_vector(31 downto 0);
			outputLo : out std_logic_vector(31 downto 0)
			);
end entity register64;

ARCHITECTURE behaviour OF register64 IS
BEGIN
    process(clk, clr)
    begin
        if clr = '1' then
            outputHi <= x"00000000";
				outputLo <= x"00000000";
        elsif rising_edge(clk) then
            if wr = '1' then
                outputHi <= inputD(63 downto 32) ;
					 outputLo <= inputD(31 downto 0) ;
            end if;
        end if;
    end process;
end architecture behaviour;