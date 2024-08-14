library IEEE;
use IEEE.std_logic_1164.all;

entity MAR is
    generic(
        VAL : std_logic_vector(31 downto 0);
		  ADDRESS : std_logic_vector(8 downto 0):= b"000000000"
    );
	port(clr, clk, wr: in std_logic;
			inputD: in std_logic_vector(31 downto 0);
			outputQ : buffer std_logic_vector(8 downto 0) := ADDRESS
			);
end entity MAR;

ARCHITECTURE behaviour OF MAR IS
signal x: std_logic_vector(8 downto 0);
BEGIN
    process(clk, clr)
    begin
			x <= inputD(8 downto 0);
        if clr = '1' then
            outputQ <= b"000000000";

        elsif rising_edge(clk) then
            if wr = '1' then
                outputQ <= x;
            end if;
        end if;
    end process;
end architecture behaviour;
