LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY Register_B is                          -- Register_B: D Flip Flop
  PORT (
         Reset: IN STD_LOGIC;                 -- Reset Signal
         Clock: IN STD_LOGIC;                 -- Clock Signal
         Enable: IN STD_LOGIC;                -- Enable Signal
         D: IN STD_LOGIC_VECTOR (31 downto 0); -- D Input Signal
         Q: OUT STD_LOGIC_VECTOR (31 downto 0) -- Q Output Signal
  );

end Register_B;


ARCHITECTURE rtl OF Register_B IS 
BEGIN

  process_Register_B : process(Clock, Reset, Enable, D)
  begin 
    if (Reset = '1') then 
        Q <= (others => '0');
    elsif (rising_edge(clock)) then
	       if (Enable ='1') then
			   Q <= D;
			 end if;
    end if;
  end process process_Register_B;
  
end rtl; 
