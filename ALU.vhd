LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alu IS
	PORT (
		Reset: IN STD_LOGIC;
		Clock: IN STD_LOGIC;
		Ain: IN STD_LOGIC;
		Cin: IN STD_LOGIC;
		Cout: IN STD_LOGIC;
		ADD_op: IN STD_LOGIC;
		SUB_op: IN STD_LOGIC;
		Neg_op: IN STD_LOGIC;
		AND_op: IN STD_LOGIC;
		OR_op: IN STD_LOGIC;
		Not_op: IN STD_LOGIC;
		SHR_op: IN STD_LOGIC;
	   SHRA_op: IN STD_LOGIC;
		SHL_op: IN STD_LOGIC;
		SHC_op: IN STD_LOGIC;
		CeqB_op: IN STD_LOGIC;
	   INCR4_op: IN STD_LOGIC;	
		cpu_bus: INOUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'Z')
		);
END alu;

ARCHITECTURE rtl OF alu IS
	SIGNAL A_Q: unsigned(31 downto 0);
	SIGNAL B: unsigned(31 downto 0);
	SIGNAL C: unsigned(31 downto 0);
	SIGNAL C_Q: unsigned(31 downto 0);
	
	
BEGIN --rtl
  
  a_register: process(Clock, Reset)
  begin     
      if (Reset = '1')then
		  A_Q <= (others => '0');
      elsif (rising_edge(clock)) then
        if (Ain ='1') then
          A_Q <= unsigned(cpu_bus);
        end if;
      end if;
  end process a_register;

  b_input : B <= unsigned(cpu_bus);
  
  alu_logic : process(A_Q, B, ADD_op, CeqB_op, Not_op, OR_op, Neg_op,
                      AND_op, SUB_op, SHR_op, SHRA_op, SHL_op, SHC_op, INCR4_op)
							 
  begin
    if (ADD_op = '1')then
	   C <= A_Q + B;
	 elsif (SUB_op = '1')then
	   C <= A_Q - B;
	 elsif (Neg_op = '1')then
	   C <= Not(B) + 1;
	 elsif (AND_op = '1')then
	   C <= A_Q AND B;
	 elsif (OR_op = '1')then
	   C <= A_Q OR B;
	 elsif (Not_op = '1')then
	   C <= NOT(B);
	 elsif (SHR_op = '1')then
	   C(31) <= '0';
		C(30 downto 0) <= B(31 downto 1);
	 elsif (SHRA_op = '1')then
	   C(31) <= B(31);
		C(30 downto 0) <= B(31 downto 1);
	 elsif (SHL_op = '1')then
		C(31 downto 1) <= B(30 downto 0);
		C(0) <= '0';
	 elsif (SHC_op = '1')then
		C(31 downto 1) <= B(30 downto 0);
		C(0) <= B(31);
	 elsif (CeqB_op = '1')then
      C <= B;
	 elsif (INCR4_op = '1')then
     C <= B + 4;
	 else
	   C <= (others => '0');
	 end if; 
  end process alu_logic;
 
  c_register : process(Clock, Reset)
  begin     
      if (Reset = '1')then
		  C_Q <= (others => '0');
      elsif (rising_edge(clock)) then
        if (Cin ='1') then
          C_Q <= C;
        end if;
      end if;
  end process c_register;
 
  c_tristate : process(Cout, C_Q)
  begin
        if (Cout = '1')then
		    cpu_bus <= STD_LOGIC_VECTOR(C_Q);
		  else
		    cpu_bus <= (OTHERS => 'Z');
		  end if;
  end process c_tristate;
	

END rtl;
