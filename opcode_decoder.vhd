LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;

entity opcode_decoder is
  port(
    opcode : in std_logic_vector(4 downto 0);
    nop_instr : out std_logic;
	 ld_instr : out std_logic;
	 ldr_instr: out std_logic;
	 st_instr : out std_logic;
	 str_instr : out std_logic;
	 la_instr : out std_logic;
	 lar_instr : out std_logic;
	 br_instr : out std_logic;
	 brl_instr : out std_logic;
	 add_instr : out std_logic;
	 addi_instr : out std_logic;
	 sub_instr : out std_logic;
	 neg_instr : out std_logic;
	 and_instr : out std_logic;
	 andi_instr : out std_logic;
	 or_instr : out std_logic;
	 ori_instr : out std_logic;
	 not_instr : out std_logic;
	 shr_instr : out std_logic;
	 shra_instr : out std_logic;
	 shl_instr : out std_logic;
	 shc_instr : out std_logic;
	 stop_instr : out std_logic
    );
end opcode_decoder;

architecture rtl of opcode_decoder is
  
begin -- rtl
  
 nop_instr <= (not opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and not opcode(1));   
 ld_instr <=  (not opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and opcode(1));   
 ldr_instr <= (not opcode(4) and not opcode(3) and not opcode(2) and opcode(1) and not opcode(1)); 		 
 st_instr <= (not opcode(4) and not opcode(3) and not opcode(2) and opcode(1) and opcode(1));
 str_instr <= (not opcode(4) and not opcode(3) and opcode(2) and not opcode(1) and not opcode(1));
 la_instr <= (not opcode(4) and not opcode(3) and  opcode(2) and not opcode(1) and opcode(1));
 lar_instr <= (not opcode(4) and not opcode(3) and  opcode(2) and opcode(1) and not opcode(1));
 br_instr <= (not opcode(4) and not opcode(3) and  opcode(2) and opcode(1) and opcode(1));
 brl_instr <= (not opcode(4) and opcode(3) and  not opcode(2) and not opcode(1) and not opcode(1));
 add_instr <= (not opcode(4) and opcode(3) and  not opcode(2) and not opcode(1) and opcode(1));
 addi_instr <= (not opcode(4) and opcode(3) and  not opcode(2) and opcode(1) and not opcode(1));
 sub_instr <= (not opcode(4) and opcode(3) and  not opcode(2) and opcode(1) and opcode(1));
 neg_instr <= (not opcode(4) and opcode(3) and  opcode(2) and not opcode(1) and not opcode(1));
 and_instr <= (not opcode(4) and opcode(3) and  opcode(2) and not opcode(1) and opcode(1));
 andi_instr <= (not opcode(4) and opcode(3) and opcode(2) and opcode(1) and not opcode(1));
 or_instr <= (not opcode(4) and opcode(3) and opcode(2) and opcode(1) and opcode(1));
 ori_instr <= (opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and not opcode(1));   
 not_instr <= (opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and opcode(1));   
 shr_instr <= (opcode(4) and not opcode(3) and not opcode(2) and opcode(1) and not opcode(1));
 shra_instr <= (opcode(4) and not opcode(3) and not opcode(2) and opcode(1) and opcode(1));
 shl_instr <= (opcode(4) and not opcode(3) and opcode(2) and not opcode(1) and not opcode(1));
 shc_instr <= (opcode(4) and not opcode(3) and opcode(2) and not opcode(1) and opcode(1));
 stop_instr <= (opcode(4) and not opcode(3) and opcode(2) and opcode(1) and not opcode(1));
		 
end rtl;

 