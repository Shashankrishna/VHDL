library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity  Controller  is                    -- Control Unit
port (Reset     : in std_logic ;          -- Reset Signal
      Clock     : in std_logic ;          -- Clock Signal
      Start     : in std_logic ;          -- Start Signal
		Q0        : in  std_logic ;         -- LSB Bit of Q 
		
		A_Load_0  : out std_logic ;         -- Clear All Signal
      Add_op    : out std_logic ;         -- Signal NOT USED
      Awrite    : out std_logic ;         
      Done      : out std_logic ;         -- Done Signal
		Enable_Multiplicand : out std_logic ; -- Enable Register_B Module
		Enable_Multiplier : out std_logic ;   -- Enable Shift_Register_Q Module
		Enable_Adder : out std_logic;         -- Enable Addition Operation
	   Enable_Shift : out std_logic;         -- Enabel Shift Operation in Shift_Register Q and A
		Hold_carry: OUT STD_LOGIC             -- Hold Carry in Adder Module
		);         
end;



architecture  rtl  of  Controller  is
   type states is (Initial_state, Awrite_state, Add_state, Shift_state, Counter_state, Stop_state);
	signal current_state, next_state : states;
	signal N_counter, N_counter_next : integer;
	constant Delay : time := 5 ns;
	
	begin

   change_state_multiplier : process(Clock, Reset)
	begin
	    if(Reset ='1') then
		    current_state <= Initial_state;
		 elsif rising_edge(clock) then
          current_state <= next_state;
		 end if;	 
	end process change_state_multiplier;
    
  
  current_state_multiplier : process(Start, Q0, current_state, N_counter, N_counter_next)
   begin
     case current_state is
			when Initial_state =>               
	            Enable_Multiplicand <= '0';
			      Enable_Multiplier <= '0';	
					A_Load_0 <= '0';
					Enable_Adder <= '0';
					Enable_Shift <= '0';
					N_counter_next <= N_counter;
					
	       when Awrite_state =>

			    Enable_Multiplicand <= '1';
		       Enable_Multiplier <= '1';
	          A_Load_0 <= '1'; 
				 Done <=	'0'; 	 
				 Awrite <= '1';
							 
			 when Add_state =>
               if(Q0 = '1') then
					   Enable_Adder <= '1';
						Hold_carry <= '1';
						Enable_Multiplicand <= '1'; 
					end if;	
					 					 
					 
			 when Shift_state =>
			     if(Q0 = '0') then        
				      Enable_Shift <= '1';
						Enable_Adder <= '1';  
						Enable_Multiplier <= '1'; 
						Awrite <= '1';             
					end if;		             
						
			 when Counter_state =>
					Enable_Shift <= '0';
					Enable_Adder <= '0';
				   N_counter_next <= N_counter - 1;
					if (N_counter_next = 0) then
					    Done <= '1';
				   end if;		 
					
			 when Stop_state =>
               Done <= '1';
	            Enable_Multiplicand <= '0';
			      Enable_Multiplier <= '0';	
					A_Load_0 <= '0';
					Enable_Adder <= '0';
					Enable_Shift <= '0';
	
			 when Others =>
	            Enable_Multiplicand <= '0';
			      Enable_Multiplier <= '0';	
					A_Load_0 <= '0';
					Enable_Adder <= '0';
					Enable_Shift <= '0';
	  end case;
	end process current_state_multiplier;
  
  
    next_state_multiplier : process(Start, N_counter_next, current_state)
   begin
     case current_state is
	  
	  	   when Initial_state =>   
			 if(Start = '1') then
	    		next_state <= Awrite_state;
			 else
			 	next_state <= Initial_state;
	       end if;
			
	       when Awrite_state =>
				 next_state <= Add_state; 
				 
				 
			 when Add_state =>
					 next_state <= Shift_state; 
					 
					 
			 when Shift_state =>
						next_state <= Counter_state; 
						
			 when Counter_state =>
					 if (N_counter_next = 0) then
					      
						    next_state <= Stop_state; 
					 else
							 next_state <= Add_state;
					 end if;		
					 
			 when Stop_state =>
			      if(Start = '1') then
	    		      next_state <= Initial_state;
			          else
						next_state <= Stop_state;
					end if;
	            	
			 when Others =>
			      next_state <= Stop_state;
	  end case;
	end process next_state_multiplier;

	
	
 counter : process(Clock, Reset)
	begin 
     if(Reset ='1') then
		    N_counter <= 32;
		 elsif rising_edge(clock) then
          N_counter <= N_counter_next;
		 end if;	 
   end process counter;  
	
	
end rtl;