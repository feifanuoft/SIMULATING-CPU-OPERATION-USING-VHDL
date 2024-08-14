LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY busMux IS
generic(
        VAL : std_logic_vector(31 downto 0) := x"00000000"
        );
PORT(
	r00_in, r01_in, r02_in, r03_in,
	r04_in, r05_in, r06_in, r07_in, 
	r08_in, r09_in, r10_in, r11_in, 
	r12_in, r13_in, r14_in, r15_in, 
	BMIn_MDR, inhi, inlo ,BMI_z_hi, 
		BMI_z_lo, BMI_inpc, BMI_portin, BMIcSignExtended	:	IN std_logic_vector(31 downto 0);
	s_in		:	IN std_logic_vector(4 downto 0);
	BusMuxOut	:	OUT std_logic_vector(31 downto 0):=VAL
);
END busMux;

ARCHITECTURE behavioural OF busMux IS
BEGIN
	BusMux: PROCESS(s_in, r00_in, r01_in, r02_in, r03_in,
	r04_in, r05_in, r06_in, r07_in, 
	r08_in, r09_in, r10_in, r11_in, 
	r12_in, r13_in, r14_in, r15_in, 
	BMIn_MDR, inhi, inlo ,BMI_z_hi, 
		BMI_z_lo, BMI_inpc, BMI_portin, 
		BMIcSignExtended)
	BEGIN
		CASE s_in IS
			when "00000"	=>	BusMuxOut <= r00_in;
			when "00001"	=>	BusMuxOut <= r01_in;
			when "00010"	=>	BusMuxOut <= r02_in;
			when "00011"	=>	BusMuxOut <= r03_in;
			when "00100"	=>	BusMuxOut <= r04_in;
			when "00101"	=>	BusMuxOut <= r05_in;
			when "00110"	=>	BusMuxOut <= r06_in;
			when "00111"	=>	BusMuxOut <= r07_in;
			when "01000"	=>	BusMuxOut <= r08_in;
			when "01001"	=>	BusMuxOut <= r09_in;
			when "01010"	=>	BusMuxOut <= r10_in;
			when "01011"	=>	BusMuxOut <= r11_in;
			when "01100"	=>	BusMuxOut <= r12_in;
			when "01101"	=>	BusMuxOut <= r13_in;
			when "01110"	=>	BusMuxOut <= r14_in;
			when "01111"	=>	BusMuxOut <= r15_in;
			when "10000"	=>	BusMuxOut <= inhi;
			when "10001"	=>	BusMuxOut <= inlo;
			when "10010"	=>	BusMuxOut <= BMI_z_hi;
			when "10011"	=>	BusMuxOut <= BMI_z_lo;
			when "10100"	=>	BusMuxOut <= BMI_inpc;
			when "10101"   => BusMuxOut <= BMIn_MDR;
			when "10110"	=>	BusMuxOut <= BMI_portin;
			when "10111"	=>	BusMuxOut <= BMIcSignExtended;
			when others		=> BusMuxOut <= (others=>'0');
		END CASE;
	END PROCESS;
END behavioural;



