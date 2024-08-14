library ieee;

use ieee.std_logic_1164.all;

entity control_unit is port (
					 clock        : in std_logic;
					 reset                   :in std_LOGIC;
                clear                   : out std_logic;					 
					 run                     : out std_logic;
					 stop                    : in std_logic;
					 MDR_read					 : out std_logic;
					 MDR_write					 : out std_logic;
                Yin                     : out std_logic;
                z_hi_in                 : out std_logic;
                z_lo_in                 : out std_logic;
                Hiin                    : out std_logic;
                Loin                    : out std_logic;
                Pcin                    : out std_logic;
                IRin                    : out std_logic;
                outportin               : out std_logic;
                c_sign_extendedin       : out std_logic;
                strobe                  : out std_logic;
                wren_sig                : out std_LOGIC;
                Rin                     : out std_logic;
                Rout                    : out std_logic;
                Gra                     : out std_logic;
                Grb                     : out std_logic;
                Grc                     : out std_logic;
                BAout                   : out std_logic;
                Con_in                  : out std_logic;
					 c_out						 : out std_logic;
					 incpc						 : out std_LOGIC;
                hi_out                  : out std_logic;
                lo_out                  : out std_logic;
                MAR_in                  : out std_logic;
                z_hi_out                : out std_logic;
                z_lo_out                : out std_logic;
                PC_out                  : out std_logic;
                MDR_out                 : out std_logic;
                port_out                : out std_logic;
                MDR_in                  : out std_logic;
                ALUcontrol_signals         : out std_logic_vector(12 downto 0);
                IRoutput						:in std_logic_vector(31 downto 0);
					 con_out                 :buffer std_LOGIC;
                inport_unit             : out std_logic_vector(31 downto 0);
                outport_unit            : out std_logic_vector(31 downto 0);
					 r14in                   : out std_LOGIC
				
);
end entity control_unit; 

architecture behavior of control_unit is 
--Type state is in the components_all package 


type state is (reset_state0, reset_state1, fetch0, fetch1, fetch2, fetch3,fetch4, add3, add4, add5, add6, sub3, 
sub4, sub5,sub6, mul3, mul4, mul5, mul6, and3, and4, and5, and6, or3, or4, or5, or6, div3, div4, div5, div6, andi3, 
andi4, andi5, ori3, ori4, ori5, branch3, branch4,branch5,branch6, branch7,jr3,jr4, jal3, jal4, in3, mfhi3,
 mflo3, shr3, shr4, shr5, shl3, shl4, shl5, ror3, ror4, ror5, rol3, rol4, rol5, neg3, neg4, not3, 
 not4, ld3, ld4, ld5, ld6, ld7, ldi3, ldi4, ldi5,ldi6, ldr2, ldr3, ldr4, ldr5, ldr6, addi3, addi4, addi5, 
 out3, st3, st4, st5, st6,st7, str3, str4, str5, str6, nop, halt, shr6,shl6,ror6,rol6, ld8);
 
 signal present_state:state;
begin	


process (clock, reset, stop)
begin
	if (reset = '1') then
		present_state <= reset_state0;
	elsif (stop = '1') then 
		present_state <= halt;
	elsif (clock'event and clock = '1') then 
		case present_state is 
			when reset_state0 =>
				present_state <= reset_state1 after 40ns;
			when reset_state1 =>
				present_state <= fetch0 after 40ns;
			when fetch0 =>
				present_state <= fetch1 after 40ns;
			when fetch1 =>
				present_state <= fetch2 after 40ns; 
			when fetch2 =>
				present_state <= fetch3 after 40ns; 
			when fetch3 =>
				present_state <= fetch4 after 40ns;
			when fetch4=>	
				case IRoutput(31 downto 27) is 
					when "00000" => 
						present_state <= ld3;
					when "00001" => 
						present_state <= ldi3;
					when "00010" =>
						present_state <= st3; 
					when "00011" =>
						present_state <= add3;
					when "00100" =>
						present_state <= sub3;
					when "00101" =>
						present_state <= shr3;
					when "00110" =>
						present_state <= shl3;
					when "00111" =>
						present_state <= ror3;
					when "01000" =>
						present_state <= rol3;
					when "01001" =>
						present_state <= and3;
					when "01010" =>
						present_state <= or3;
					when "01011" =>
						present_state <= addi3;
					when "01100" =>
						present_state <= andi3;
					when "01101" => 
						present_state <= ori3;
					when "01110" =>
						present_state <= mul3;
					when "01111" => 
						present_state <= div3;
					when "10000" =>
						present_state <= neg3;
					when "10001" =>
						present_state <= not3;
					when "10010" => 
						present_state <= branch3;
					when "10011" =>
						present_state <= jr3;
					when "10100" =>
						present_state <= jal3;
					when "10101" =>
						present_state <= in3;
					when "10110" =>
						present_state <= out3;
					when "10111" =>
						present_state <= mfhi3;
					when "11000" =>
						present_state <= mflo3;
					when "11001" => -- the nop instruction (do nothing)
						present_state <= fetch0; 
					when "11010" =>
						present_state <= halt; 
					when others=>
				end case;
				
			when add3 => 
				present_state <= add4 after 40ns;
			when add4 =>
				present_state <= add5 after 40ns;
			when add5 => 
				present_state <= add6 after 40ns;
			when add6=>
				present_state <= fetch0 after 40ns;
 			
			when sub3 => 
				present_state <= sub4 after 40ns;
			when sub4 =>  
				present_state <= sub5 after 40ns;
			when sub5 => 
				present_state <= sub6 after 40ns;
			when sub6 => 
				present_state <= fetch0 after 40ns;
 									
			when shr3 => 
				present_state <= shr4 after 40ns;
			when shr4 => 
				present_state <= shr5 after 40ns;
			when shr5 => 
				present_state <= shr6 after 40ns;
			when shr6 =>
				present_state <= fetch0 after 40ns;

 					
			when shl3 => 
				present_state <= shl4 after 40ns;
			when shl4 => 
				present_state <= shl5 after 40ns;
			when shl5 => 
				present_state <= shl6 after 40ns;
			when shl6 =>
				present_state <= fetch0 after 40ns;
 					
			when ror3 => 
				present_state <= ror4 after 40ns;
			when ror4 => 
				present_state <= ror5 after 40ns;
			when ror5 => 
				present_state <= ror6 after 40ns;
			when ror6 => 
				present_state <= fetch0 after 40ns;
 					
			when rol3 => 
				present_state <= rol4 after 40ns;
			when rol4 => 
				present_state <= rol5 after 40ns;
			when rol5 => 
				present_state <= rol6 after 40ns;
			when rol6 => 
				present_state <= fetch0 after 40ns;				
 					
			when and3 => 
				present_state <= and4 after 40ns;
			when and4 => 
				present_state <= and5 after 40ns;
			when and5 => 
				present_state <= and6 after 40ns;
			when and6 => 
				present_state <= fetch0 after 40ns;
 							
			when ld3 =>
				present_state <= ld4 after 40ns;
			when ld4 =>
				present_state <= ld5 after 40ns;
			when ld5 =>
				present_state <= ld6 after 40ns;
			when ld6 =>
				present_state <= ld7 after 40ns;
			when ld7 =>
				present_state <= ld8 after 40ns;
			when ld8 =>
				present_state <= fetch0 after 40ns;			
 						
			when ldi3 =>
				present_state <= ldi4 after 40ns;
			when ldi4 =>
				present_state <= ldi5 after 40ns;
			when ldi5 =>
				present_state <= ldi6 after 40ns;
			when ldi6 =>
				present_state <= fetch0 after 40ns;

 									
			when st3 =>
				present_state <= st4 after 40ns;
			when st4 =>
				present_state <= st5 after 40ns;
			when st5 =>
				present_state <= st6 after 40ns;
			when st6 =>
				present_state <= st7 after 40ns;
			when st7 =>
				present_state <= fetch0 after 40ns;				
 				
			when or3 => 
				present_state <= or4 after 40ns;
			when or4 => 
				present_state <= or5 after 40ns;
			when or5 => 
				present_state <= or6 after 40ns;
			when or6 => 
				present_state <= fetch0 after 40ns;
				
 		
			when addi3 => 
				present_state <= addi4 after 40ns;
			when addi4 => 
				present_state <= addi5 after 40ns;
			when addi5 => 
				present_state <= fetch0 after 40ns;
 								
			when andi3 => 
				present_state <= andi4 after 40ns;
			when andi4 => 
				present_state <= andi5 after 40ns;
			when andi5 => 
				present_state <= fetch0 after 40ns;
 							
			when ori3 => 
				present_state <= ori4 after 40ns;
			when ori4 => 
				present_state <= ori5 after 40ns;
			when ori5 => 
				present_state <= fetch0 after 40ns;
 									
			when mul3 =>
				present_state <= mul4 after 40ns;
			when mul4 =>
				present_state <= mul5 after 40ns;
			when mul5 =>
				present_state <= mul6 after 40ns;
			when mul6 =>
				present_state <= fetch0 after 40ns;
 														
			when div3 =>
				present_state <= div4 after 40ns;
			when div4 =>
				present_state <= div5 after 40ns;
			when div5 =>
				present_state <= div6 after 40ns;
			when div6 =>
				present_state <= fetch0 after 40ns;
 									
			when neg3 =>
				present_state <= neg4 after 40ns;
			when neg4 =>
				present_state <= fetch0 after 40ns;
 										
			when not3 =>
				present_state <= not4 after 40ns;
			when not4 =>
				present_state <= fetch0 after 40ns;				
 						
			when branch3 =>
				present_state <= branch4 after 40ns;
			when branch4 =>
				present_state <= branch5 after 40ns;
			when branch5 =>
				present_state <= branch6 after 40ns;
			when branch6 => 
				present_state <= branch7 after 40ns;
			when branch7=>
				present_state <= fetch0 after 40ns;
 						
			when jr3 =>
				present_state <= jr4 after 40ns;
			when jr4=>
				present_state <= fetch0 after 40ns;
 						
			when jal3 =>
				present_state <= jal4 after 40ns;
			when jal4 =>
				present_state <= fetch0 after 40ns;				
 					
			when in3 =>
				present_state <= fetch0 after 40ns;	
 						
			when out3 =>
				present_state <= fetch0 after 40ns;
 						
			when mfhi3 =>
				present_state <= fetch0 after 40ns;
 						
			when mflo3 =>
				present_state <= fetch0 after 40ns;
 					
			when halt =>
			when others=>
		end case;
end if;
end process;
				
				
process(present_state) 
begin
				
			incPC         <='0';
			run                	<='0';
			Yin                 <='0';
			z_hi_in             <='0';
			z_lo_in             <='0';
			Hiin                <='0';
			Loin                <='0';
			Pcin                <='0';
			IRin                <='0';
			outportin           <='0';
			c_sign_extendedin   <='0';
			strobe              <='0'; 
			wren_sig           <='0';    
			Rin                 <='0';   
			Rout                <='0';   
			Gra                 <='0';   
			Grb                 <='0';   
			Grc                 <='0';   
			BAout               <='0';   
			Con_in              <='0';   
			c_out				<='0';		
			hi_out               <='0';  
			lo_out               <='0';  
			MAR_in               <='0';  
			z_hi_out             <='0';  
			z_lo_out            <='0';   
			PC_out              <='0';   
			MDR_out             <='0';   
			port_out            <='0';   
			MDR_in              <='0';   
			ALUcontrol_signals  <="0000000000000";
			con_out       		<='0';
			inport_unit         <=x"00000000";
			outport_unit 		<=x"00000000";
			r14in<='0';
	case present_state is
		when reset_state0 => 
			clear <= '0'; 
			run <= '0';
		when reset_state1 => 
			clear <= '1'; 
			run <= '1'; 
		when fetch0 =>
			clear <= '0'; 
			run <= '0'; 
			PC_out<= '1';
			MAR_in<= '1'after 10 ns, '0' after 25 ns;
		when fetch1 =>
			PC_out<= '0';
			ALUcontrol_signals <= "0111111111111";
			z_lo_in<='1'after 20 ns, '0' after 35 ns; 
			
		when fetch2 =>
			ALUcontrol_signals <= "0000000000000";
			
			
			z_lo_out <= '1'after 10 ns, '0' after 25 ns;
			MDR_in<='1'after 10 ns, '0' after 25 ns;
			MDR_read <= '1'after 10 ns, '0' after 25 ns;
			PCin <= '1'after 10 ns, '0' after 25 ns;	
		when fetch3 => 
			MDR_out<='1';
			IRin <='1';
		when fetch4=>
		
		when add3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when add4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "1000000000000";	
		when add5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when add6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;

			
 
		when sub3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when sub4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0100000000000";	
		when sub5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when sub6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;

 
		when mul3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when mul4 =>
			Gra <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0000000010000";	
		when mul5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
			z_hi_in <='1';
			z_lo_out <='1';
			Loin <= '1';

			
		when mul6=>
			Hiin <= '1';
			z_hi_out <='1';
			
			
			
			

 
		when and3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when and4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0000000001000";	
		when and5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when and6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
 
		when or3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when or4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0000000000100";	
		when or5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when or6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
		
			
			when div3 =>
			IRin <='0';
			Mdr_out<='0';

			Gra <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when div4 =>
			Grb <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0000000000001";	
		when div5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
			z_hi_in <='1';
			z_lo_out <='1';
			Loin <= '1';

			
		when div6=>
			Hiin <= '1';
			z_hi_out <='1';
 
        when shr3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when shr4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0010000000000";	
		when shr5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when shr6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
			
        when shl3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when shl4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0001000000000";	
		when shl5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when shl6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
 
        when ror3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when ror4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0000100000000";	
		when ror5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when ror6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
 
        when rol3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
	 		Yin<='1'after 10 ns, '0' after 25 ns;
	 		Rout <='1'after 10 ns, '0' after 25 ns;
		when rol4 =>
			Grc <='1';
			Rout <='1'after 10 ns, '0' after 25 ns;
			ALUcontrol_signals <= "0000010000000";	
		when rol5 =>
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when rol6=>
			z_lo_in <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <= '1'after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
 

		when neg3 =>
			IRin <='0';
			Mdr_out<='0';

			Rout <= '1';
			Grb <= '1';
			ALUcontrol_signals <= "0000001000000";
			z_lo_in <= '1';
		when neg4 =>
			Rout <= '0';
			Grb <= '0';
			ALUcontrol_signals <= "0000000000000";
			z_lo_in <= '0';
			
			Z_lo_out <= '1';
			Gra <= '1';
			Rin <= '1';

			
		when not3 =>
			IRin <='0';
			Mdr_out<='0';

			Rout <= '1';
			Grb <= '1';
			ALUcontrol_signals <= "0000000000010";
			z_lo_in <= '1';
		when not4 =>
			Rout <= '0';
			Grb <= '0';
			ALUcontrol_signals <= "0000000000000";
			z_lo_in <= '0';

			Z_lo_out <= '1';
			Gra <= '1';
			Rin <= '1';
 			

		when andi3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
			Yin<='1'after 10 ns, '0' after 25 ns;
			Rout <='1'after 10 ns, '0' after 25 ns;
		when andi4 =>
			C_out <= '1';
			ALUcontrol_signals <= "0000000001000";
			z_lo_in <='1'after 35 ns, '0' after 40 ns;
		when andi5 =>
			ALUcontrol_signals <="0000000000000";
			Gra <='1'after 10 ns, '0' after 25 ns;
			Rin <='1'after 10 ns, '0' after 25 ns;
			c_out <='0';
			z_lo_in <='1'after 0 ns, '0' after 10 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
 
		when ori3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
			Yin<='1'after 10 ns, '0' after 25 ns;
			Rout <='1'after 10 ns, '0' after 25 ns;
		when ori4 =>
			C_out <= '1';
			ALUcontrol_signals <= "0000000000100";
			z_lo_in <='1'after 35 ns, '0' after 40 ns;
		when ori5 =>
			ALUcontrol_signals <="0000000000000";
			Gra <='1'after 10 ns, '0' after 25 ns;
			Rin <='1'after 10 ns, '0' after 25 ns;
			c_out <='0';
			z_lo_in <='1'after 0 ns, '0' after 10 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
 
		when addi3 =>
			IRin <='0';
			Mdr_out<='0';

			Grb <='1'after 10 ns, '0' after 25 ns;
			Yin<='1'after 10 ns, '0' after 25 ns;
			Rout <='1'after 10 ns, '0' after 25 ns;
		when addi4 =>
			C_out <= '1';
			ALUcontrol_signals <= "1000000000000";
			z_lo_in <='1'after 35 ns, '0' after 40 ns;
		when addi5 =>
			ALUcontrol_signals <="0000000000000";
			Gra <='1'after 10 ns, '0' after 25 ns;
			Rin <='1'after 10 ns, '0' after 25 ns;
			c_out <='0';
			z_lo_in <='1'after 0 ns, '0' after 10 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
 
			
		WHEN branch3 =>
			MDR_out<='0';
			IRin <='0';
			
			Gra <='1';
			Rout<='1';
			Con_in <='1';
		WHEN branch4 =>
			Gra <='0';
			Rout <='0';
			Con_in <='0';
			Pc_out <='1';
			Yin<='1';
		WHEN branch5 =>
			Pc_out <='0';
			Yin<='0';
			c_out <='1';
			
			ALUcontrol_signals <= "1000000000000";	--add
			

		when branch6 => 
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			z_lo_in <='1';
		when branch7 =>
			z_lo_in <='0';
			z_lo_out <='1';
			if(con_out = '1') then
				PCin <= '1'after 10 ns, '0' after 25 ns;
			else 
				PCin <='0';
			end if;
  ------------------
		WHEN jr3=>	
			Gra <='1';

		WHEN jr4=>
			Gra <='0';
			IRin <='0';
			Mdr_out<='0';
		
			Rout<='1';
			PCin<='1'after 10 ns, '0' after 25 ns;

	when jal3 =>
			Rin <= '1';
			Grb <= '1';
			PC_out <= '1';	
			r14in <='1';
		when jal4 =>
			Rout <= '1';
			Gra <= '1';
			PCin <= '1';
 
		WHEN in3 =>
		    IRin <='0';
			Mdr_out<='0';

			Gra <='1'after 10 ns, '0' after 25 ns;
            Rin <='1'after 10 ns, '0' after 25 ns;
            port_out<='1'after 10 ns, '0' after 25 ns;
 	
		WHEN out3 =>
		    IRin <='0';
			 Mdr_out<='0';

			Gra <='1'after 10 ns, '0' after 25 ns;
            Rout <='1'after 10 ns, '0' after 25 ns;
            outportin<='1'after 10 ns, '0' after 25 ns;
 			
		when mfhi3 =>
			Gra <='1'after 10 ns, '0' after 25 ns;
			Yin<='1'after 10 ns, '0' after 25 ns;
			hi_out <=  '1';
			Rin <='1'after 10 ns, '0' after 25 ns;
 				
		when mflo3 =>
			IRin <='0';
			Mdr_out<='0';

			Gra <='1'after 10 ns, '0' after 25 ns;
			Yin<='1'after 10 ns, '0' after 25 ns;
			lo_out <=  '1';
			Rin <='1'after 10 ns, '0' after 25 ns;
 
		when ld3 =>
			IRin <='0';
			Mdr_out<='0';
			MAR_in<= '1';	
			MDR_in<='1'after 19 ns, '0' after 40 ns;
			MDR_read <= '1'after 19 ns, '0' after 40 ns;

		when ld4 =>
			Grb <='1'after 10 ns, '0' after 25 ns;
			Rout<='1'after 10 ns, '0' after 25 ns;
			Yin<='1'after 10 ns, '0' after 25 ns;

		when ld5 =>
			C_out<='1';
			ALUcontrol_signals <= "1000000000000";   
			z_lo_in <='1'after 35 ns, '0' after 40 ns;

		when ld6 =>
			z_lo_in <='1'after 0 ns, '0' after 5 ns;
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			
			z_lo_out <='1';
			MAR_in <='1' after 19 ns, '0' after 40 ns;
		when ld7 =>
			z_lo_out <='1';
			MDR_read <='1'after 10 ns, '0' after 25 ns;
			MDR_in <='1'after 10 ns, '0' after 25 ns;
		when ld8 =>
			z_lo_out <='0';
			MDR_in <='0';
			
			MDR_out <='1'after 10 ns, '0' after 25 ns;
			Gra <='1'after 10 ns, '0' after 25 ns;
			Rin <='1'after 19 ns, '0' after 40 ns;

 
		when ldi3 =>
			IRin <='0';
			Mdr_out<='0';
			MAR_in<= '1';	
			MDR_in<='1'after 19 ns, '0' after 40 ns;
			MDR_read <= '1'after 19 ns, '0' after 40 ns;

		when ldi4 =>
			Grb <='1'after 10 ns, '0' after 25 ns;
			Rout<='1'after 10 ns, '0' after 25 ns;
			Yin<='1'after 10 ns, '0' after 25 ns;
			--BAout<='1'after 10 ns, '0' after 25 ns;
		when ldi5 =>
			C_out<='1' ;
			ALUcontrol_signals <= "1000000000000";			
			z_lo_in <='1'after 20 ns, '0' after 40 ns;

		when ldi6=>
			z_lo_in <='1'after 0 ns, '0' after 4 ns;
			ALUcontrol_signals <="0000000000000";
			c_out <='0';
			Gra <= '1'after 10 ns, '0' after 25 ns;
			Rin <='1' after 10 ns, '0' after 25 ns;
			z_lo_out <='1'after 10 ns, '0' after 25 ns;
			
			
		when st3 =>
	   IRin <='0';
			Mdr_out<='0';
         Grb <='1'after 10 ns, '0' after 25 ns;
			Rout <='1';
         
		when st4 =>
			Rout <='0';
			C_out<='1';
			Yin<='1', '0' after 15 ns;
		when st5 =>
			Yin<='0';
			ALUcontrol_signals <= "1000000000000";	
			z_lo_in <='1'after 10 ns, '0' after 25 ns;
		when st6 =>
				ALUcontrol_signals <="0000000000000";
			c_out <='0';

			MAR_in <='1';
			z_lo_out <='1';
			
			
		when st7 =>
				MAR_in<='0';
			z_lo_out <='0';
			
			Gra <='1';
			Rout <='1';
			wren_sig<='1';
			MDR_read <='0';
			MDR_in <='1'	;
			-- Gra_tb <='1'after 10 ns, '0' after 25 ns;
			-- Rout_tb<='1';

 
		when nop =>
		when halt =>
			run <= '0';
		when others=>
	end case;
end process;
end behavior;