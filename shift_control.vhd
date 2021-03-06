library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity shift_control is
  port(
    Reset : in std_logic;
    Clock  : in std_LOGIC;
    ld_shift : in  std_logic;
    Decr : in std_logic;
    Neq0 : out std_logic;
    cpu_bus : inout std_logic_vector(31 downto 0) := (others => 'Z')	 
    );
End shift_control;


Architecture Rtl of shift_control is
     signal counter : unsigned(4 downto 0);
     signal counter_next : unsigned(4 downto 0);
	  
begin

  -- current state:
 Q: process (clock, reset)     
  begin  				
   if (reset = '0') then                 -- asynchronous reset (active low)
      counter <= "00000";
    elsif rising_edge(clock) then  
      if (ld_shift = '1') then
        counter <= counter_next;
      end if;
    end if; 
  end process Q;
  
  
  -- next state
 Q_bar: process (ld_shift, Decr, counter)  
   begin 
     if (ld_shift = '1' and Decr = '0') then 
	     counter_next <= cpu_bus(4 downto 0);
     elsif (ld_shift = '0' and Decr = '1') then
	     counter_next <= counter - 1;
	  else
        counter_next <= (others => 'X');	  
	  end if;
   end process Q_bar;	  
	  
  -- output state
 O: process (counter, Neq0)
   begin
	  if (counter = "00000") then
	     Neq0 <= 1;
	  else
        Neq0 <= 0;	  
	  end if;	  
 end process O;
	  
end Rtl;
