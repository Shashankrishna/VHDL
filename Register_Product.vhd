LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY Register_Product is
  PORT ( D: IN STD_LOGIC_VECTOR (63 downto 0);
         Reset: IN STD_LOGIC;
         Clock: IN STD_LOGIC;
         Enable: IN STD_LOGIC;
         Q: OUT STD_LOGIC_VECTOR (63 downto 0)
  );

end Register_Product;


ARCHITECTURE rtl OF Register_Product IS 
BEGIN

  process_Register_Product : process(Clock, Reset, Enable, D)
  begin 
    if (Reset = '1') then 
        Q <= (others => '0');
    elsif (rising_edge(clock)) then
	       if (Enable ='1') then
			   Q <= D;
			 end if;
    end if;
  end process process_Register_Product;
  
end rtl; 