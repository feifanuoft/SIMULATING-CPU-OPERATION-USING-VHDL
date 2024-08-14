LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity select_and_encoder is
    generic(
        VAL : std_logic_vector(15 downto 0):= x"0000"
    );
port (
			IR_in        : in std_logic_vector(31 downto 0);	
			Rin     : in std_logic;
			Rout    : in std_logic;
			BAout   : in std_logic;
			Gra, Grb, Grc : in std_logic;
			R0to15_out     : out std_logic_vector(15 downto 0):=VAL;
			R0to15_in     : out std_logic_vector(15 downto 0):=VAL;
			c_sign_extended : out std_logic_vector(31 downto 0)
						
);

end entity select_and_encoder;

ARCHITECTURE behavioural OF select_and_encoder IS 
	signal interim : std_logic_vector(3 downto 0);
	begin
	c_sign_process : process(IR_in)
		begin
		for i in 31 downto 18 loop
			c_sign_extended(i) <= IR_in(18);
		end loop;
		c_sign_extended(17 downto 0) <= IR_in(17 downto 0);
	end process;
	
	init : process(IR_in, Gra, Grb, Grc)
	begin
		if (Gra ='1') then
			interim <= IR_in(26 downto 23);
		elsif (Grb = '1') then 
			interim <= IR_in(22 downto 19);
		elsif (Grc = '1') then
			interim <= IR_in(18 downto 15);
		else 
			--shouldn't get here!
		end if;
	end process init;
	
	result : process(interim, Rin, Rout, BAout)
		begin
		if Rin = '1' then
			case interim is
				when "0000" => R0to15_in <= b"0000_0000_0000_0001";
				when "0001" => R0to15_in <= b"0000_0000_0000_0010";
				when "0010" => R0to15_in <= b"0000_0000_0000_0100";
				when "0011" => R0to15_in <= b"0000_0000_0000_1000";
				when "0100" => R0to15_in <= b"0000_0000_0001_0000";
				when "0101" => R0to15_in <= b"0000_0000_0010_0000";
				when "0110" => R0to15_in <= b"0000_0000_0100_0000";
				when "0111" => R0to15_in <= b"0000_0000_1000_0000";
				when "1000" => R0to15_in <= b"0000_0001_0000_0000";
				when "1001" => R0to15_in <= b"0000_0010_0000_0000";
				when "1010" => R0to15_in <= b"0000_0100_0000_0000";
				when "1011" => R0to15_in <= b"0000_1000_0000_0000";
				when "1100" => R0to15_in <= b"0001_0000_0000_0000";
				when "1101" => R0to15_in <= b"0010_0000_0000_0000";
				when "1110" => R0to15_in <= b"0100_0000_0000_0000";
				when "1111" => R0to15_in <= b"1000_0000_0000_0000";
				when others => R0to15_in <= b"0000_0000_0000_0000";	
			end case;
		else
			R0to15_in <= b"0000_0000_0000_0000";	
		end if;
		if BAout = '1' then
			if interim = "0000" then
				R0to15_out <= b"0000_0000_0000_0001";
			end if;
		end if;
		if Rout = '1' then 
			case interim is
				when "0000" =>R0to15_out <= b"0000_0000_0000_0001";
				when "0001" => R0to15_out <= b"0000_0000_0000_0010";
				when "0010" => R0to15_out <= b"0000_0000_0000_0100";
				when "0011" => R0to15_out <= b"0000_0000_0000_1000";
				when "0100" => R0to15_out <= b"0000_0000_0001_0000";
				when "0101" => R0to15_out <= b"0000_0000_0010_0000";
				when "0110" => R0to15_out <= b"0000_0000_0100_0000";
				when "0111" => R0to15_out <= b"0000_0000_1000_0000";
				when "1000" => R0to15_out <= b"0000_0001_0000_0000";
				when "1001" => R0to15_out <= b"0000_0010_0000_0000";
				when "1010" => R0to15_out <= b"0000_0100_0000_0000";
				when "1011" => R0to15_out <= b"0000_1000_0000_0000";
				when "1100" => R0to15_out <= b"0001_0000_0000_0000";
				when "1101" => R0to15_out <= b"0010_0000_0000_0000";
				when "1110" => R0to15_out <= b"0100_0000_0000_0000";
				when "1111" => R0to15_out <= b"1000_0000_0000_0000";
				when others => R0to15_out <= b"0000_0000_0000_0000";
			end case;
		else
			--if BAout = '0' then
				R0to15_out <= b"0000_0000_0000_0000";
			--end if;
		end if;	
	end process result;
				
END;
	 
	 