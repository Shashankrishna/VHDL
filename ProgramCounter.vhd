LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity program_counter is
  port (
    Reset : in std_logic;
    Clock : in std_logic;
    PCin  : in std_logic;
    PCout : in std_logic;
    cpu_bus : inout std_logic_vector(31 downto 0) := (others => 'Z')
    );
end program_counter;

architecture rtl of program_counter is
  signal register_Q : std_logic_vector(31 downto 0);

begin  -- rtl;

  process_pc : process(Clock, Reset, cpu_bus, PCin, register_Q)
  begin 
    if (Reset = '1') then 
      register_Q <= (others => '0');
    elsif (rising_edge(clock) and PCin = '1') then
      register_Q <= cpu_bus;
    end if;
  end process process_pc;

  out_buffer: process(PCout, cpu_bus, register_Q)
  begin
    if (PCout = '0') then
      cpu_bus <= (others => 'Z');
    else
      cpu_bus <= register_Q;
    end if;
  end process out_buffer;     

end rtl;