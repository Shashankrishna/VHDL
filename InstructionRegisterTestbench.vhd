LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY InstructionRegisterTestbench IS 
END InstructionRegisterTestbench;

ARCHITECTURE bdf_type OF InstructionRegisterTestbench IS 

  COMPONENT instruction_register
    PORT(
      Reset : IN STD_LOGIC;
      Clock : IN STD_LOGIC;
      IRin : IN STD_LOGIC;
      C1out : IN STD_LOGIC;
      C2out : IN STD_LOGIC;
      Gra   : IN std_logic;
      Grb   : IN std_logic;
      Grc   : IN std_logic;
      opcode : OUT std_logic_vector(4 downto 0);
      register_select : OUT std_logic_vector(4 downto 0);
      c3_2_downto_0 : OUT std_logic_vector(2 downto 0);
      cpu_bus : INOUT std_logic_vector(31 downto 0) := (others => 'Z')
    );
  END COMPONENT;

  signal Reset :  STD_LOGIC;
  signal Clock :  STD_LOGIC;
  signal IRin  :  STD_LOGIC;
  signal C1out :  STD_LOGIC;
  signal C2out :  STD_LOGIC;
  signal Gra   :  STD_LOGIC;
  signal Grb   :  STD_LOGIC;
  signal Grc   :  STD_LOGIC;
  signal opcode : STD_LOGIC_VECTOR(4 downto 0);
  signal register_select : STD_LOGIC_VECTOR(4 downto 0);
  signal c3_2_downto_0: STD_LOGIC_VECTOR(2 downto 0);
  signal cpu_bus :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 

  b2v_PC_0 : instruction_register
    PORT MAP(
      Reset => Reset,
      Clock => Clock,
      IRin => irin,
      C1out => c1out,
      C2out => c2out,
      Gra => gra,
      Grb => grb,
      Grc => grc,
      cpu_bus => cpu_bus);

  testbench_process : process
  begin
    -- Initialize input signals
    IRin <= '0';
    C1out <= '0';
    C2out <= '0';
    Gra <= '0';
    Grb <= '0';
    Grc <= '0';
    cpu_bus <= (others => 'Z');
    Clock <= '0';

    -- Reset
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    wait for 40 ns;

    -- begin by loading the Instruction Register (IR)
    cpu_bus <= "01010101010101010101010101010101";
    IRin <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    IRin <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    -- now, drive the data bus with the contents of the IR
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    C1out <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    C1out <= '0';

    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    C2out <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    C2out <= '0';

    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    Gra <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    Gra <= '0';

    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    Grb <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    Grb <= '0';

    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    Grc <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    Grc <= '0';
   
    wait;
    
  end process testbench_process;

END bdf_type;
