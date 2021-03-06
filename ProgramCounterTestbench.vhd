LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY ProgramCounterTestbench IS 
END ProgramCounterTestbench;

ARCHITECTURE bdf_type OF ProgramCounterTestbench IS 

  COMPONENT program_counter
    PORT(
      Reset : IN STD_LOGIC;
      Clock : IN STD_LOGIC;
      PCin : IN STD_LOGIC;
      PCout : IN STD_LOGIC;
      cpu_bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
  END COMPONENT;

  signal Reset :  STD_LOGIC;
  signal Clock :  STD_LOGIC;
  signal pcin :  STD_LOGIC;
  signal pcout :  STD_LOGIC;
  signal cpu_bus :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 

  b2v_PC_0 : program_counter
    PORT MAP(
      Reset => Reset,
      Clock => Clock,
      PCin => pcin,
      PCout => pcout,
      cpu_bus => cpu_bus);

  testbench_process : process
  begin
    -- Initialize input signals
    PCin <= '0';
    PCout <= '0';
    cpu_bus <= (others => 'Z');
    Clock <= '0';

    -- Reset
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    wait for 40 ns;

    -- begin by loading the Program Counter (PC)
    cpu_bus <= "01010101010101010101010101010101";
    PCin <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    PCin <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    -- now, drive the data bus with the contents of the PC
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    PCout <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    PCout <= '0';
    cpu_bus <= "10101010101010101010101010101010";
    
    wait;
    
  end process testbench_process;

END bdf_type;
