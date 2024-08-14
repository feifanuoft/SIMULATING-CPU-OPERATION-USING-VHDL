library ieee;
use ieee.std_logic_1164.all;
use work.components_all.all;
use work.ram_initialization.all;

entity control_tb is
end;

architecture logic of control_tb is
signal  clock_tb: std_logic;
signal reset_tb: std_logic;
signal stop_tb	: std_logic;
signal run_tb: std_logic;




COMPONENT combination
Port(
    clock                   : in std_logic;
    reset                   :in std_LOGIC;
    run                     : out std_logic;
    stop                    : in std_logic
    ); 
END COMPONENT combination;

begin
datapathTest : datapath port map ( clock=>clock_tb, reset=>reset_tb, stop=>stop_tb, run=>run_tb);

 clock_process: process
begin
	 clock_tb <= '1', '0' after 10 ns;
	wait for 20 ns;
end process  clock_process;

main: process
begin
	stop_tb <= '0';
	reset_tb <= '1';
	wait for 15 ns;
	reset_tb <= '0';
	wait for 6000 ns;
end process;
end architecture;	
