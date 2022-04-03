LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity sequencer is
  port(
    Reset     : in   std_logic;
    Clock      : in   std_logic;
    Start     : in   std_logic;
    Done      : in  std_logic;
    End_sig : in std_logic;
    Goto6 : in std_logic;
    Read_control : in std_logic;
    Write_control : in std_logic;
    Wait_sig : in std_logic;
    Stop_sig : in std_logic;
    t0 : out std_logic;
    t1 : out std_logic;
    t2 : out std_logic;
    t3 : out std_logic;
    t4 : out std_logic;
    t5 : out std_logic;
    t6 : out std_logic;
    t7 : out std_logic;
    t8 : out std_logic;
    t9 : out std_logic;
    t10 : out std_logic;
    t11 : out std_logic;
    t12 : out std_logic;
    t13 : out std_logic;
    t14 : out std_logic;
    t15 : out std_logic;
    r_sequencer : out std_logic;
    w_sequencer : out std_logic
    );
end sequencer;

architecture rtl of sequencer is
    type states is (Initial, Stop, Run, Read_Q, Wite_Q);
	 signal current_state, next_state : states;
	 signal t_counter, t_counter_next : unsigned(3 downto 0);
	 signal run_Sign, Run_sig_next : std_logic;
	 
begin
    
	 -- This process models a JK flip flop, where J = start and K = Stop_sig.
	 -- The purpose is to capture the rising edge of start that starts the CPU and 
	 -- rising edge of Stop_sig that stops the CPU.
	 run_signal_process : process(Clock, Reset)
	 
	 begin
	   if(Reset ='1') then
		   run_sign <= '0';
	   elsif rising_edge(clock) then
         run_sign <= run_sig_next;
      end if;
    end process run_signal_process;		

   -- JK flip flop: q+ = Jq' + k'q, J = Start, K = Stop_sig
	Run_sig_next <= (Start and not(Run_sig)) or (not(Stop_sig) and Run_sig);

   -- The following processes implement the fetch-execute FSM for the control unit.
	current_state_fetch_execute : process(Clock, Reset)
	begin
	    if(Reset ='1') then
		    current_state <= Initial;
		 elsif rising_edge(clock) then
          current_state <= next_state;
		 end if;	 
	end process current_state_fetch_execute;
	
   next_state_fetch_execute : process(current_state, Run_sig, Done, Read_control, Write_Control)
   begin
     case current_state is
	    when Initial =>
		    if (run_sig = '1') then
			   next_state <= Run;
			 else
			   next_state <= Initial; 
			 end if;
			
		 when Run => 
		    if (run_sig = '0') then
			    next_stop <= Stop;
			 elsif (read_control = '1') then
		       next_state <= Read_Q;
		    elsif (write_control = '1') then
	          next_state <= Write_Q;
		    else
	          next_state <= Run;
		    end if;
	   
       when Read_Q | Write_Q =>
	       if (Done = '0') then
		       next_state <= current_State;
			 else
		       next_state <= Run;
			 end if;
		 
	    when Stop =>  
	        next_state <= Stop;
			
	  end case;
	end process next_state_fetch_execute;

   fetch_execute_output : process (current_state)
     begin
	    case current_state is
		   when Initial =>
		      r_sequencer <= '0';
			   W_sequencer <= '0';
			when Run =>
		      r_sequencer <= '0';
			   W_sequencer <= '0';			   
	      when Read_Q =>
		      r_sequencer <= '1';
			   W_sequencer <= '0';
         when Write_Q =>
		      r_sequencer <= '0';
			   W_sequencer <= '1';			
	      when Stop =>
				r_sequencer <= '0';
			   W_sequencer <= '0';
		 end case;
	end process fetch_execute_output;	 
				
-- Finally, following code implements that ocunter that genrate the T0-T15 sequence timing signals

  current_state_t_counter : process (Reset, Clock)	
  begin
    if (Reset = '1') then
       t_counter <= (others => '0');
    elsif rising_edge(clock) then
       t_counter <= t_counter_next;
    end if;
  end process current_state_t_counter;

next_state_t_counter : process (t_counter, current_state, Run_sig, End_sig, Goto6, Wait_sig, Done)
begin
  case current_state is
     when Run =>
	    if (wait_sig ='1') then
	      t_counter_next <= t_counter;
	    else
	      if (end_Sig = '1') then
	        t_counter_next <= (others => '0');
			elsif (goto6 = '1') then
	        t_counter_next <= "0110";
			else
	        t_counter_next <= t_counter + 1;
			end if;
	    end if;
		 
	  when Read_Q | Write_Q =>
	    if (Done = '0') then
	       t_counter_next <= t_counter;
		 elsif (end_sig = '1') then
	       t_counter_next <= (others => '0');
		 else
		    t_counter_next <= t_counter + 1;
		 end if;
		 
	  when others =>
	      t_counter_next <= t_counter;
	  end case;
	end process next_state_t_counter;

-- output logic
-- t0 <= '1' when t_counter = "0000" else '0'	
   t0 <= not t_counter(3) and not t_counter(2) and not t_counter(1) and not t_counter(0);

end rtl;
