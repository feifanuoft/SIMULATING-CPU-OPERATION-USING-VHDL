library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is
port( A,B: in std_logic_vector(31 downto 0);
		ALUcontrol_signals: in std_logic_vector(12 downto 0);--ADD, SUB,MUL,DIV,SHIFT,ROTATE, SHL,SHR, AND_control, OR_control: in std_logic;
		C_hi: out std_logic_vector(31 downto 0); --
		C_lo: out std_logic_vector(31 downto 0);
		clk: in std_logic
		
);
end ALU;


architecture behaviour of ALU is
	
COMPONENT booth
	pORT(
			Ain :   IN STD_LOGIC_VECTOR(31 downto 0);
			Bin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			output :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
		);
END COMPONENT;


COMPONENT alu_div
	PORT(denom : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 numer : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 quotient : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 remain : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	booth_out : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	div_quo,div_rem:  STD_LOGIC_VECTOR(31 DOWNTO 0);



begin 
	booth_mul: booth			
	PORT MAP(
			Ain => A,
			Bin => B,
			output => booth_out
		);

	--divider : alu_div
		--PORT MAP(
			--denom => B,
			--numer => A,
			--quotient =>div_quo,
			--remain=>div_rem
		--);
		
	process(clk) is

	begin
	if rising_edge(clk) then
		case ALUcontrol_signals is 

			when "1000000000000" => c_hi <=  x"0000_0000" ;  --add
										
									c_lo <= std_logic_vector(unsigned(A) + unsigned(B));

			when "0100000000000" => c_hi <=   x"0000_0000";  -- sub
									c_lo <=  std_logic_vector(unsigned(A) - unsigned(B));

			when "0010000000000" => c_hi <=   x"0000_0000"; --srl
									c_lo <=  std_logic_vector(unsigned(A) srl to_integer (unsigned(B))); 

			when "0001000000000" => c_hi <=   x"0000_0000";  --sll
									c_lo <=  std_logic_vector(unsigned(A) sll to_integer (unsigned(B)));
			
			when "0000100000000" => c_hi <=   x"0000_0000";  --ror
									c_lo <=  std_logic_vector(unsigned(A) ror to_integer (unsigned(B)));  

			when "0000010000000" => c_hi <=   x"0000_0000";   --rol
									c_lo <=  std_logic_vector(unsigned(A) rol to_integer (unsigned(B)));
									
			when "0000001000000" => c_hi <=  x"0000_0000";          -- neg  
									c_lo <= std_logic_vector((Not( unsigned(B)))+1);

			when "0000000100000" => c_hi <=   x"0000_0000";   --equal
									c_lo <=  (std_logic_vector(unsigned(B)));

			when "0000000010000" => c_hi <= booth_out(63 downto 32); --Booth algorithm 
									c_lo <= booth_out(31 downto 0);

			when "0000000001000" => c_hi <= x"0000_0000"; --and
									c_lo <= (A and B);

			when "0000000000100" => c_hi <= x"0000_0000"; --or
									c_lo <= (A OR B);

			when "0000000000010" => c_hi <=  x"0000_0000";          -- not 
									c_lo <= std_logic_vector((Not( unsigned(B))));
			
			
			when "0000000000001" => c_hi <= std_logic_vector(unsigned(A) mod unsigned(B));  -- divide
									c_lo <= std_lOGIC_VECTOR((unsigned(A) / unsigned(B)));

			when "0000000000011" => c_hi <=  x"0000_0000" ;  --addi
									c_lo <= std_logic_vector(unsigned(A) + unsigned(B));

			when "0000000000111" => c_hi <= x"0000_0000"; --andi
									c_lo <= (A and B);
			when "0111111111111" => c_hi <= x"0000_0000";     --increment pc value
									c_lo <= (B+1);


			when others => NULL;
		end case; 
		end if;
	end process;
end behaviour;


	