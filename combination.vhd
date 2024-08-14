library IEEE;

use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_1164.all;
entity combination is
   Port(
					 clock        : in std_logic;
					 reset                   :in std_LOGIC;
					 run                     : out std_logic;
					 stop                    : in std_logic

        ); 
end combination;

architecture structural of combination is
Component register32 is
        generic(
        VAL : std_logic_vector(31 downto 0) := x"00000000"
        );
        port(   clr,clk,wr: in std_logic;
            inputD: IN std_logic_vector(31 downto 0); --BusMuxOut--
            outputQ: out std_logic_vector(31 downto 0) --BusMuxIn-Rn--
        );
end component register32;
----------------------------------------------------------------------

Component register14 is
        generic(
        VAL : std_logic_vector(31 downto 0) := x"00000000"
        );
        port(   clr,clk,wr: in std_logic;
            inputD: IN std_logic_vector(31 downto 0); --BusMuxOut--
            outputQ: out std_logic_vector(31 downto 0) --BusMuxIn-Rn--
        );
end component register14;


component control_unit is
port(
					clock         : in std_logic;
					reset                   :in std_LOGIC;
                clear                   : out std_logic;					 
					 run                     : out std_logic;
					 stop                    : in std_logic;
					 MDR_read						: out std_logic;
					 MDR_write						: out std_logic;
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
                IRoutput                 : in std_LOGIC_VECTOR(31 downto 0); 
					 con_out                 :out std_LOGIC;
                inport_unit             : out std_logic_vector(31 downto 0);
                outport_unit            : out std_logic_vector(31 downto 0);
					 r14in                   : out std_logic

);
end component control_unit;
-------------------------------------------------------------------------------------------------
Component PC is
        generic(
        VAL : std_logic_vector(31 downto 0) := x"00000000"
        );
        port(   clr,clk,wr: in std_logic;
            inputD: IN std_logic_vector(31 downto 0); --BusMuxOut--
            outputQ: buffer std_logic_vector(31 downto 0); --BusMuxIn-Rn--
				IncPC : in std_logic
        );
end component PC;

----------------------------------------------------------------------------------------------------
component busMux is
generic(
        VAL : std_logic_vector(31 downto 0) := x"00000000"
        );
PORT(
        r00_in, r01_in, r02_in, r03_in,
        r04_in, r05_in, r06_in, r07_in,
        r08_in, r09_in, r10_in, r11_in,
        r12_in, r13_in, r14_in, r15_in,
        BMIn_MDR, inhi, inlo ,BMI_z_hi,
        BMI_z_lo, BMI_inpc, BMI_portin, 
        BMIcSignExtended                : IN std_logic_vector (31 downto 0);
        s_in                            : IN std_logic_vector(4 downto 0);
        BusMuxOut                       : out std_logic_vector(31 downto 0)
);
end component busMux;

---------------------------------------------------------------------------------------------------------
component encoder is
PORT(
        r00_out, r01_out, r02_out, r03_out,
        r04_out, r05_out, r06_out, r07_out,
        r08_out, r09_out, r10_out, r11_out,
        r12_out, r13_out, r14_out, r15_out,
        hi_out, lo_out, z_hi_out, z_lo_out,
        PC_out, MDR_out, port_out, c_out    : IN std_logic;
        s_out                               : OUT std_logic_vector(4 downto 0)
);
end component encoder;
-------------------------------------------------------------------------------------------------------
component ram
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC;
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

component MAR is
        generic(
        VAL : std_logic_vector(31 downto 0) := x"00000000";
		  ADDRESS : std_logic_vector(8 downto 0):= b"000000000"
        );
	port(clr, clk,wr: in std_logic;
			inputD: in std_logic_vector(31 downto 0);
			outputQ : buffer std_logic_vector(8 downto 0)
			);
end component MAR;

component MDR is
generic(
        VAL : std_logic_vector(31 downto 0) := x"00000000"
        );
port(   busMuxOut, MDataIn          : IN std_logic_vector(31 downto 0);
        clr,clk,MDRread, mdr_in     : IN std_logic;
        outputQ                     : Out std_logic_vector(31 downto 0)
);
end component MDR;


component ALU is
port(   A,B                 : in std_logic_vector(31 downto 0);
        ALUcontrol_signals     : in std_logic_vector(12 downto 0);
        C_hi                : out std_logic_vector(31 downto 0); --
        c_lo                : out std_logic_vector(31 downto 0);
        clk                 : in std_logic);
end component ALU;

component select_and_encoder is
    generic(
        VAL : std_logic_vector(15 downto 0):= x"0000"
    );
port (
        Rin     : in std_logic;
        Rout    : in std_logic;
        BAout   : in std_logic;
        Gra, Grb, Grc : in std_logic;
        R0to15_out     : out std_logic_vector(15 downto 0);
        R0to15_in     : out std_logic_vector(15 downto 0);
	IR_in : in std_logic_vector(31 downto 0);
        c_sign_extended : out std_logic_vector(31 downto 0)		
);
end component select_and_encoder;

component revised_register is
 port(
        BAout : in std_logic;
        registeroutQ: in std_logic_vector(31 downto 0);
        BusMuxIn_R: out std_logic_vector(31 downto 0)
        );
end component revised_register;

component CON_FF_Logic is
        port(
            IR_in_Conff: in std_logic_vector(31 downto 0);
            BusMuxout : in std_logic_vector(31 downto 0);
            Con_in    : in std_logic;
            outputQ   : out std_logic
        );
end component CON_FF_Logic;

signal  s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15, 
        BMIn_MDR, inhi, inlo ,BMI_z_hi, BMI_z_lo, BMI_inpc, BMI_portin, 
        BMIcSignExtended,A,BusMuxOut:std_logic_vector(31 downto 0) ;--signal C:std_logic_vector(6 downto 0);
signal  BMIN_R0, BMIN_R1, BMIN_R2, BMIN_R3, BMIN_R4, BMIN_R5, BMIN_R6, 
        BMIN_R7, BMIN_R8, BMIN_R9, BMIN_R10, BMIN_R11, BMIN_R12, BMIN_R13, BMIN_R14, BMIN_R15 :std_logic_vector(31 downto 0) ;
signal  C_hi, C_lo: std_logic_vector(31 downto 0);
signal  sout:std_logic_vector(4 downto 0);
signal address_sig: std_LOGIC_VECTOR(8 downto 0);


--phase 2
signal R0to15_out, R0to15_in :std_logic_vector(15 downto 0);
signal IRoutput, ram_out, c_sign_extended:std_logic_vector(31 downto 0);

signal MData_in :std_logic_vector(31 downto 0);

--phase 3
signal Yin, z_hi_in ,z_lo_in,Hiin,Loin,Pcin,IRin,outportin,c_sign_extendedin,strobe,wren_sig,Rin,Rout,Gra,Grb,Grc,BAout,Con_in,c_out,incpc,hi_out,lo_out,MAR_in,z_hi_out,z_lo_out,PC_out
			,MDR_out,port_out,MDR_in, con_out ,MDR_read,MDR_write,clear,r14in: std_LOGIC;
signal ALUcontrol_signals: std_LOGIC_VECTOR(12 downto 0);

signal inport_unit,outport_unit  :  std_logic_vector(31 downto 0);


begin

        
regY: register32  port map(clr=>clear,clk=>clock,wr=>Yin,outputQ=>A,  inputD=>busMuxOut); --BUXMUX related register
reg0: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(0),outputQ=>s0,inputD=>busMuxOut);
reg1: register32 generic map (VAL => x"00000055") port map(clr=>clear,clk=>clock,wr=>R0to15_in(1),outputQ=>s1,inputD=>busMuxOut);
reg2: register32 generic map (VAL => (x"00000000")) port map(clr=>clear,clk=>clock,wr=>R0to15_in(2),outputQ=>s2,inputD=>busMuxOut);
reg3: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(3),outputQ=>s3,inputD=>busMuxOut);
reg4: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(4),outputQ=>s4,inputD=>busMuxOut);
reg5: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(5),outputQ=>s5,inputD=>busMuxOut);
reg6: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(6),outputQ=>s6,inputD=>busMuxOut);
reg7: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(7),outputQ=>s7,inputD=>busMuxOut);
reg8: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(8),outputQ=>s8,inputD=>busMuxOut);
reg9: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(9),outputQ=>s9,inputD=>busMuxOut);
reg10: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(10),outputQ=>s10,inputD=>busMuxOut);
reg11: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(11),outputQ=>s11,inputD=>busMuxOut);
reg12: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(12),outputQ=>s12,inputD=>busMuxOut);
reg13: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(13),outputQ=>s13,inputD=>busMuxOut);
reg14: register14 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>r14in,outputQ=>s14,inputD=>busMuxOut);
reg15: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>R0to15_in(15),outputQ=>s15,inputD=>busMuxOut);

PC1: PC generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>Pcin,outputQ=>BMI_inpc,inputD=>busMuxOut,incPC=>incPC);

IR1: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>IRin,outputQ=>IRoutput,inputD=>busMuxOut);

regHi: register32 generic map (VAL => x"00001111") port map(clr=>clear,clk=>clock,wr=>Hiin,outputQ=>inhi,inputD=>busMuxOut);
regLo: register32 generic map (VAL => x"00001111") port map(clr=>clear,clk=>clock,wr=>Loin,outputQ=>inlo,inputD=>busMuxOut);
regzhi: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>z_hi_in,outputQ=>BMI_z_hi,inputD=>c_Hi);
regzlo: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>z_lo_in,outputQ=>BMI_z_lo,inputD=>c_Lo);
inport: register32 generic map (VAL => x"00010101") port map(clr=>clear,clk=>clock,wr=>strobe,outputQ=>BMI_portin,inputD=>inport_unit);
outport: register32 generic map (VAL => x"00000000") port map(clr=>clear,clk=>clock,wr=>outportin,outputQ=>outport_unit,inputD=>busMuxOut);
 
--Revised_register
revised_register0: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R0,registeroutQ=>s0);
revised_register1: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R1,registeroutQ=>s1);
revised_register2: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R2,registeroutQ=>s2);
revised_register3: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R3,registeroutQ=>s3);
revised_register4: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R4,registeroutQ=>s4);
revised_register5: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R5,registeroutQ=>s5);
revised_register6: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R6,registeroutQ=>s6);
revised_register7: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R7,registeroutQ=>s7);
revised_register8: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R8,registeroutQ=>s8);
revised_register9: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R9,registeroutQ=>s9);
revised_register10: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R10,registeroutQ=>s10);
revised_register11: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R11,registeroutQ=>S11);
revised_register12: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R12,registeroutQ=>s12);
revised_register13: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R13,registeroutQ=>s13);
revised_register14: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R14,registeroutQ=>s14);
revised_registerr15: revised_register port map(BAout =>BAout,BusMuxIn_R=>BMIN_R15,registeroutQ=>s15);

--CON_FF_Logic
CON_FF_Logic1: CON_FF_Logic port map(   IR_in_Conff=>IRoutput ,
                                        BusMuxout=>BusMuxout ,
                                        Con_in=> Con_in,
                                        outputQ=> con_out
					); 
       
--MDR
MDR1: MDR generic map (VAL => x"00000000") port map( busMuxOut => busMuxOut,
                    MDataIn => MData_in ,
                    clr => clear, clk => clock ,
                    mdr_in => MDR_in,
                    MDRread => MDR_read,
                    outputQ=>BMIn_MDR);--BusMuxin_inPort: register32 port map(clr=>clear,clk=>clock,wr=>Pcin,outputQ=>busMuxOut,inputD=>busMuxOut);

                        
--encoder
encoder1: encoder port map( r00_out=>R0to15_out(0),
                            r01_out=>R0to15_out(1),
                            r02_out=>R0to15_out(2),
                            r03_out=>R0to15_out(3),
                            r04_out=>R0to15_out(4),
                            r05_out=>R0to15_out(5),
                            r06_out=>R0to15_out(6),
                            r07_out=>R0to15_out(7),
                            r08_out=>R0to15_out(8),
                            r09_out=>R0to15_out(9),
                            r10_out=>R0to15_out(10),
                            r11_out=>R0to15_out(11),
                            r12_out=>R0to15_out(12),
                            r13_out=>R0to15_out(13),
                            r14_out=>R0to15_out(14),
                            r15_out=>R0to15_out(15),
                            hi_out=>hi_out,
                            lo_out=>lo_out,
                            z_hi_out=>z_hi_out,
                            z_lo_out=>z_lo_out,
                            PC_out=>PC_out,
                            MDR_out=>MDR_out,
                            port_out => port_out,
                            c_out => c_out,
                            s_out => sout);
                            
--32:1 Multiplexer BusMux
busMux1: busMux generic map (VAL => x"00000000") port map(   r00_in => s0, r01_in => s1, r02_in => s2,
                            r03_in => s3,r04_in => s4, r05_in => s5,
                            r06_in => s6,r07_in => s7,r08_in => s8, 
                            r09_in => s9, r10_in => s10,r11_in => s11,
                            r12_in => s12, r13_in => s13, r14_in => s14,
                            r15_in => BMIN_R15,

                            BMIn_MDR=>BMIn_MDR, inhi=>inhi,
                            inlo=>inlo ,BMI_z_hi=>BMI_z_hi, 
                            BMI_z_lo=>BMI_z_lo, BMI_inpc=>BMI_inpc,
                            BMI_portin=>BMI_portin,BMIcSignExtended=>c_sign_extended,
                            s_in => sout, BusMuxOut => BusMuxOut);
--ALU

ALU1: ALU port map(     A => A ,
                        B => BusMuxout,
                        ALUcontrol_signals => ALUcontrol_signals,
                        C_hi=> C_hi , c_lo=>c_lo ,
                        clk =>  clock
                ); 

-- RAM
ram_inst : ram PORT MAP (
		address	 => address_sig,
		clock	 => clock,
		data	 => BMIn_MDR,
		wren	 => wren_sig,
		q	 => MData_in
	);
--select_and_encoder
select_and_encoder1 : select_and_encoder generic map (VAL => x"0000") port map(
                Rin             =>      Rin,
                Rout            =>      Rout,
                BAout           =>      BAout,
                R0to15_out      =>      R0to15_out,
                R0to15_in       =>      R0to15_in,
                c_sign_extended =>    c_sign_extended,
                Gra             =>      Gra,
                Grb             =>      Grb,
                Grc             =>      Grc,
					 IR_in           =>      IRoutput     
        );
--MAR
MAR1:MAR generic map (VAL => x"00000000", ADDRESS=>b"000000000") port map(clr => clear,clk=>clock,
                wr => MAR_in,
		inputD => busMuxout,
		outputQ => address_sig
			);
			
control_unit1: control_unit port map(
		clock                    =>  clock,
		reset                   => reset,
       clear                  =>  clear,					 
		 run                    =>  run,
		 stop                   =>  stop,
		 MDR_read		=> MDR_read,
		 MDR_write		=> MDR_write,
                Yin                     =>  Yin,
                z_hi_in                 =>  z_hi_in,
                z_lo_in                 =>  z_lo_in,
                Hiin                    =>  Hiin,
                Loin                    =>  Loin,
                pcin                    =>  pcin,
                IRin                    =>  IRin,
                outportin               =>  outportin,
                c_sign_extendedin       =>  c_sign_extendedin,
                strobe                  =>  strobe,
                wren_sig                =>  wren_sig,
                Rin                     =>  Rin,
                Rout                    =>  Rout,
                Gra                     =>  Gra,
                Grb                     =>  Grb,
                Grc                     =>  Grc,
                BAout                   =>  BAout,
                Con_in                  =>  Con_in,
					 c_out						 =>  c_out,
					 incpc						 =>  incpc,
                hi_out                  =>  hi_out,
                lo_out                  =>  lo_out,
                MAR_in                  =>  MAR_in,
                z_hi_out                =>  z_hi_out,
                z_lo_out                =>  z_lo_out,
                PC_out                  =>  PC_out,
                MDR_out                 =>  MDR_out,
                port_out                =>  port_out,
                MDR_in                  =>  MDR_in,
                ALUcontrol_signals      =>  ALUcontrol_signals,
					 IRoutput                => IRoutput,
                con_out                 => con_out,
                inport_unit             => inport_unit,
                outport_unit            => outport_unit,
					 r14in                  =>r14in

				);
end architecture structural;