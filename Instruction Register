LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity instruction_register is
  port (
    Reset : in std_logic;
    Clock : in std_logic;
    IRin  : in std_logic;
    c1out : in std_logic;
    c2out : in std_logic;
    Gra   : in std_logic;
    Grb   : in std_logic;
    Grc   : in std_logic;
    opcode : out std_logic_vector(4 downto 0);
    register_select : out std_logic_vector(4 downto 0);
    c3_2_downto_0 : out std_logic_vector(2 downto 0);
    cpu_bus : inout std_logic_vector(31 downto 0) := (others => 'Z')
    );
end instruction_register;

architecture rtl of instruction_register is
   signal register_Q : std_logic_vector(31 downto 0);

begin  -- rtl
  -- model as edge-triggered register with asynchronous reset and enable

  IR_process : process(Clock, Reset)
  begin
    if (Reset = '1') then 
      register_Q <= (others => '0');
    elsif (rising_edge(clock)) then
       if (IRin ='1') then
         register_Q <= cpu_bus;
       end if;
    end if;
  end process IR_process;

  cpu_bus_process : process(c1out, c2out, register_Q)
  begin  
    if (c1out = '1') then
      cpu_bus(21 downto 0) <= register_Q(21 downto 0);
      cpu_bus(31 downto 22) <= (others => register_Q(21));
    elsif (c2out = '1') then
      cpu_bus(16 downto 0) <= register_Q(16 downto 0);
      cpu_bus(31 downto 17) <= (others => register_Q(16));
    else
      cpu_bus <= (others => 'Z');
    end if;
  end process cpu_bus_process;

  register_select_process : process(Gra, Grb, Grc, register_Q)
  begin
    if (Gra = '1') then
      register_select <= register_Q(26 downto 22);
    elsif (Grb = '1') then
      register_select <= register_Q(21 downto 17);
    elsif (Grc = '1') then
      register_select <= register_Q(16 downto 12);  
    else
      register_select <= (others => '0');
    end if;
  end process register_select_process;

-- concurrent signal assignment for opcode
opcode <= register_Q(31 downto 27);

-- concurrent signal assignment for c3
c3_2_downto_0 <= register_Q(2 downto 0);
     
end rtl;
