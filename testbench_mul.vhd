LIBRARY ieee;USE ieee.std_logic_1164.all;

ENTITY testbench_and IS 
END ENTITY testbench_and;

ARCHITECTURE datapath_tb_arch OF testbench_and IS

	SIGNAL 	R0in_tb,R1in_tb,R2in_tb,R3in_tb,R4in_tb,
			R5in_tb,R6in_tb,R7in_tb,R8in_tb,R9in_tb,
			R10in_tb,R11in_tb,R12in_tb,R13in_tb,
			R14in_tb,R15in_tb: std_logic;

	SIGNAL 	r00_out_tb,r01_out_tb,r02_out_tb,r03_out_tb,
			r04_out_tb,r05_out_tb,r06_out_tb,r07_out_tb,
			r08_out_tb,r09_out_tb,r10_out_tb,r11_out_tb,
			r12_out_tb,r13_out_tb,r14_out_tb,r15_out_tb	: std_logic;
	
	SIGNAL PC_out_tb, z_lo_out_tb, z_hi_out_tb, MDR_out_tb,z_lo_in_tb, z_hi_in_tb:std_logic;
	SIGNAL  MAR_in_tb, PCin_tb, MDR_in_tb, IRin_tb, Yin_tb,zin_tb:std_logic;
	SIGNAL IncPC_tb, Read_tb, Hiin_tb, Loin_tb:std_logic;
	SIGNAL control_signals: std_logic_vector(12 downto 0);
	SIGNAL clock_tb, clear_tb,hi_out_tb, lo_out_tb,  port_out_tb, c_out_tb,c_sign_extended_tb:std_logic;
	SIGNAL MData_in_tb:std_logic_vector (31 downto 0);

	TYPE State IS (default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, 
					Reg_load3b, T0, T1, T2, T3, T4, T5, T6);

	SIGNAL Present_state:State:= default;



	COMPONENT combination PORT (	clock, read_mux ,clear,R0in,R1in,R2in,R3in,R4in,
									R5in,R6in,R7in,R8in,R9in,R10in,R11in,R12in,R13in,R14in,
									R15in,Yin,Hiin,Loin,Pcin,IRin,hi_out,lo_out,z_hi_out,
									z_lo_out,r00_out,r01_out,r02_out,r03_out,r04_out,r05_out,
									r06_out,r07_out,r08_out,r09_out,r10_out,r11_out,r12_out,r13_out,
									r14_out,r15_out,PC_out,MDR_out,port_out,z_lo_in, z_hi_in: in std_logic;
									
									c_out,MDR_in,c_sign_extendedin: in std_logic;

									control_signals	: in std_logic_vector(12 downto 0);

									MData_in: in std_logic_vector(31 downto 0));
	END COMPONENT combination;

BEGIN 
DUT  : combination 
PORT MAP (
	--MAR_in		=>		MAR_in_tb,
	--IncPC 		=>		IncPC_tb,
	IRin		=>		IRin_tb,
	R0in		=>		R0in_tb,		
	R1in		=>		R1in_tb,
	R2in		=>		R2in_tb	,	
	R3in		=>      R3in_tb,
	R4in		=> 		R4in_tb,
	R5in		=> 		R5in_tb,
	R6in		=> 		R6in_tb,
	R7in		=> 		R7in_tb,
	R8in		=>		R8in_tb,
	R9in		=>		R9in_tb,
	R10in		=> 		R10in_tb,
	R11in		=> 		R11in_tb,
	R12in		=> 		R12in_tb,
	R13in		=> 		R13in_tb,
	R14in		=> 		R14in_tb,
	R15in		=> 		R15in_tb,
	z_lo_in=>z_lo_in_tb, 
	z_hi_in=>z_hi_in_tb,
	
	c_out			=>    c_out_tb,
	r00_out		=>		r00_out_tb,
	r01_out		=>		r01_out_tb,
	r02_out		=>		r02_out_tb,
	r03_out		=>		r03_out_tb,
	r04_out		=>		r04_out_tb,
	r05_out		=>		r05_out_tb,
	r06_out		=>		r06_out_tb,
	r07_out		=>		r07_out_tb,
	r08_out		=>		r08_out_tb,
	r09_out		=>		r09_out_tb,
	r10_out		=>		r10_out_tb,
	r11_out		=>		r11_out_tb,
	r12_out		=>		r12_out_tb,
	r13_out		=>		r13_out_tb,
	r14_out		=>		r14_out_tb,
	r15_out		=>		r15_out_tb,

	hi_out		=>		hi_out_tb,
	lo_out		=>		lo_out_tb,
	port_out	=>		port_out_tb,
	c_sign_extendedin		=>		c_sign_extended_tb,
									

	clear		=> 		clear_tb,
	PC_out		=>		PC_out_tb,
	z_lo_out	=>		z_lo_out_tb, 
	z_hi_out 	=> 		z_hi_out_tb,
	MDR_out		=>		MDR_out_tb,
	MDR_in		=>		MDR_in_tb,
	PCin		=>		PCin_tb,
	Yin			=>		Yin_tb,
	read_mux	=>		Read_tb,
	
	Hiin		=> 		Hiin_tb,
	Loin		=> 		Loin_tb,
	
	control_signals => control_signals,


	clock		=>		clock_tb,
	MData_in	=>		MData_in_tb);
	

Clock_process: PROCESS IS
	BEGIN
		Clock_tb <= '1', '0' after 10 ns;
		Wait for 20 ns;
	END PROCESS Clock_process;
	

PROCESS (clock_tb)  IS
begin
	IF (rising_edge (clock_tb)) THEN   
		CASE Present_state IS 
			WHEN Default=>
					Present_state <= Reg_load1a;
			WHEN Reg_load1a=>
					Present_state <= Reg_load1b;
			WHEN Reg_load1b=>
					Present_state <= Reg_load2a;
			WHEN Reg_load2a=>
					Present_state <= Reg_load2b;
			WHEN Reg_load2b=>
					Present_state <= Reg_load3a;
			WHEN Reg_load3a=>
					Present_state <= Reg_load3b;
			WHEN Reg_load3b=>
					Present_state <= T0;
			WHEN T0 =>
					Present_state <= T1;
			WHEN T1 =>
					Present_state <= T2;
			WHEN T2=>
					Present_state <= T3;
			WHEN T3=>
					Present_state <= T4;
			WHEN T4 =>
					Present_state <= T5;
			WHEN T5 =>
					Present_state <= T6;
			WHEN OTHERS =>END CASE;
	END IF;
END PROCESS;

-- "ADD r5, r2, r4"
PROCESS (Present_state)IS
BEGIN
	CASE Present_state IS       
		WHEN Default=>
			PC_out_tb <= '0';
			z_lo_out_tb <= '0';   
			r00_out_tb <= '0'; 
			r01_out_tb <= '0'; 
			r02_out_tb <= '0'; 
			r03_out_tb <= '0'; 
			r04_out_tb <= '0'; 
			r05_out_tb <= '0'; 
			r06_out_tb <= '0'; 
			r07_out_tb <= '0'; 
			r08_out_tb <= '0'; 
			r09_out_tb <= '0'; 
			r10_out_tb <= '0'; 
			r11_out_tb <= '0'; 
			r12_out_tb <= '0'; 
			r13_out_tb <= '0'; 
			r14_out_tb <= '0'; 
			r15_out_tb <= '0';

			hi_out_tb	<= '0';
			lo_out_tb	<= '0';
			z_lo_out_tb	<= '0';
			z_hi_out_tb	<= '0';
			PC_out_tb	<= '0';
			c_out_tb	<= '0';
			port_out_tb	<= '0';	 
			MDR_out_tb <= '0';  

			MDR_in_tb <= '0';   
			--Zin_tb <= '0';  
			PCin_tb <='0';   
			MDR_in_tb <= '0';   
			--IRin_tb  <= '0';   
			Yin_tb <= '0';  
			--IncPC_tb <= '0';  
			Read_tb <= '0';  
			control_signals <= "0000000000000";
			R2in_tb <= '0';
			R4in_tb <= '0';  
			R5in_tb <= '0';
			MData_in_tb <= x"00000000"; 

		WHEN Reg_load1a=> 
			MData_in_tb <= x"00000022";
			Read_tb <= '0', '1'after 10 ns, 
			'0' after 25 ns; 					--the first zero is there for completeness
			MDR_in_tb <= '0', 
			'1'after 10 ns, 
			'0' after 25 ns;

		WHEN Reg_load1b=> 
			MDR_out_tb <= '1'after 10 ns, 
			'0' after 25 ns; 
			R2in_tb <= '1' after 10 ns, 
			'0' after 25 ns;					--initialize R2 with the value $22

		WHEN Reg_load2a=> 
			MData_in_tb <= x"00000024";
			Read_tb <= '1'after 10 ns, 
			'0' after 25 ns; 
			MDR_in_tb <= '1' after 10 ns, 
			'0' after 25 ns;

		WHEN Reg_load2b=> 
			MDR_out_tb <= '1'after 10 ns, 
			'0' after 25 ns; 
			R4in_tb <= '1' after 10 ns, 
			'0' after 25 ns;				--initialize R4 with the value $24 

		WHEN Reg_load3a=> 
			MData_in_tb <= x"00000026";
			Read_tb <= '1'after 10 ns, 
			'0' after 25 ns; 
			MDR_in_tb <= '1' after 10 ns, 
			'0' after 25 ns;

		WHEN Reg_load3b=> 
			MDR_out_tb <= '1'after 10 ns, 
			'0' after 25 ns; 
			R5in_tb <= '1' after 10 ns, 
			'0' after 25 ns;					--initialize R5 with the value $26 

		WHEN T0 =>							--see if you need to de-assertthese 
			PC_out_tb<= '1';
			z_lo_in_tb<='1';
			z_hi_in_tb<='1';
			--MDR_in_tb<= '1';
			--IncPC_tb<= '1';
			--Zin_tb <= '1';
		WHEN T1=>
			PC_out_tb<= '0';   --check
			
			MDR_in_tb<= '1';
			z_lo_out_tb <= '1';   
			PCin_tb <= '1';   
			Read_tb <= '1';   
			MDR_in_tb <='1';
			MData_in_tb<= x"1A920000";   		--opcode for "mul R5, R2, R4"

		WHEN T2=>
            z_lo_out_tb <= '0'; --check 

            MDR_out_tb <= '1';   
            --IRin_tb <= '1';
		WHEN T3=>
            MDR_out_tb <= '0'; --check 

			r02_out_tb<= '1'; 
			Yin_tb <= '1';
		WHEN T4=>
			Yin_tb <='0';  --check
			r02_out_tb<= '0'; --check 

			r04_out_tb<= '1'; 
			control_signals <= "0000000010000";
			--Zin_tb <= '1';
			z_lo_in_tb<='1';
			z_hi_in_tb<='1';
		WHEN T5 =>
            r04_out_tb<= '0'; --check 

			z_lo_out_tb <= '1';   
			z_lo_in_tb<='0';
            Loin_tb <= '1';
			-- R5in_tb <= '1';   
        WHEN T6 =>
            z_lo_out_tb <= '0';     --check

            z_hi_out_tb <= '1';
            Hiin_tb <= '1';


		WHEN OTHERS =>
	END CASE;
END PROCESS;


END ARCHITECTURE datapath_tb_arch;