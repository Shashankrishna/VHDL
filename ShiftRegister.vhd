LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY ShiftRegister is                         -- Shift Register         
  PORT (
         Reset: IN STD_LOGIC;                   -- Reset Signal
         Clock: IN STD_LOGIC;                   -- Clock Signal
         Enable: IN STD_LOGIC;                  -- Enable Signal
			Shift_op: IN STD_LOGIC;                -- Shift Start Signal
			ShiftIn: IN STD_LOGIC;                 -- Shift In Signal
         D: IN STD_LOGIC_VECTOR (31 downto 0);   -- D Input Signal
			ShiftOut: OUT STD_LOGIC;               -- Shift Out Signal
         Q: OUT STD_LOGIC_VECTOR (31 downto 0)   -- Q Output Signal
  );

end ShiftRegister;


ARCHITECTURE rtl OF ShiftRegister IS 

COMPONENT Register_B                              -- Register B Component
	PORT( Reset: IN STD_LOGIC;
         Clock: IN STD_LOGIC;
         Enable: IN STD_LOGIC;
         D: IN STD_LOGIC_VECTOR (31 downto 0);
         Q: OUT STD_LOGIC_VECTOR (31 downto 0)
	);
END COMPONENT;

     -- Create local signal 
     signal register_Q : std_logic_vector(31 downto 0);  -- Register Signal. 
	  signal internal_D : std_logic_vector(31 downto 0);  -- MUX output signal.
BEGIN
    
	b2v_PC_0 : Register_B
    PORT MAP(
      Reset => Reset,
      Clock => Clock,
      Enable => Enable,
      D => internal_D,
      Q => register_Q);
		
		
  process_muxselect : process(Shift_op, ShiftIn, D, register_Q) 	
  begin 
        if (Shift_op = '1') then  	      -- Shift operation		                         
            internal_D <= D;  -- D is selected as the input to the register
		  else		       
				internal_D(31) <= ShiftIn;  				             -- MSB is ShiftIn   
			   internal_D(30 downto 0)	<= register_Q(31 downto 1);	 -- register contents assigned to internal_D i.e., right shift.			
		  end if; 
				
  end process process_muxselect;				
  
       ShiftOut <= register_Q(0); -- @ any given time the LSB of Q is assigned to ShiftOut
		 Q <= register_Q;           -- register_Q assigned to Q 
		
  
end rtl; 

-- Enable_Multiplier output from controller to Enable Input of ShiftRegister_Q.
-- Awrite output from controller to Enable Input of ShiftRegister_A.