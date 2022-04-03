LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY ALUTestbench IS 
END ALUTestbench;

ARCHITECTURE bdf_type OF ALUTestbench IS 

  COMPONENT alu
    PORT(
      Reset : IN STD_LOGIC;
      Clock : IN STD_LOGIC;
      Ain : IN STD_LOGIC;
      Cin : IN STD_LOGIC;
      Cout : IN STD_LOGIC;
      ADD_op : IN STD_LOGIC;
      CeqB_op : IN STD_LOGIC;
      Not_op : IN STD_LOGIC;
      Neg_op : IN STD_LOGIC;
      SHR_op : IN STD_LOGIC;
      SHC_op : IN STD_LOGIC;
      SHRA_op : IN STD_LOGIC;
      OR_op : IN STD_LOGIC;
      AND_op : IN STD_LOGIC;
      SHL_op : IN STD_LOGIC;
      SUB_op : IN STD_LOGIC;
      INCR4_op : IN STD_LOGIC;
      cpu_bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
  END COMPONENT;

  signal Reset :  STD_LOGIC;
  signal Clock :  STD_LOGIC;
  signal Ain :  STD_LOGIC;
  signal Cin :  STD_LOGIC;
  signal Cout :  STD_LOGIC;
  signal CeqB_op :  STD_LOGIC;
  signal shr_op :  STD_LOGIC;
  signal add_op :  STD_LOGIC;
  signal not_op :  STD_LOGIC;
  signal neg_op :  STD_LOGIC;
  signal shc_op :  STD_LOGIC;
  signal shra_op :  STD_LOGIC;
  signal or_op :  STD_LOGIC;
  signal and_op :  STD_LOGIC;
  signal shl_op :  STD_LOGIC;
  signal sub_op :  STD_LOGIC;
  signal incr4_op :  STD_LOGIC;
  signal cpu_bus :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 

  b2v_ALU0 : alu
    PORT MAP(
      Reset => Reset,
      Clock => Clock,
      Ain => Ain,
      Cin => Cin,
      Cout => Cout,
      ADD_op => add_op,
      CeqB_op => CeqB_op,
      Not_op => not_op,
      Neg_op => neg_op,
      SHR_op => shr_op,
      SHC_op => shc_op,
      SHRA_op => shra_op,
      OR_op => or_op,
      AND_op => and_op,
      SHL_op => shl_op,
      SUB_op => sub_op,
      INCR4_op => incr4_op,
      cpu_bus => cpu_bus
      );

  testbench_process : process
    variable register_index : integer := 0;
  begin
    -- Initialize input signals
    Ain <= '0';
    Cin <= '0';
    Cout <= '0';
    add_op <= '0';
    sub_op <= '0';
    neg_op <= '0';
    and_op <= '0';
    or_op <= '0';
    not_op <= '0';
    shr_op <= '0';
    shra_op <= '0';
    shl_op <= '0';
    shc_op <= '0';
    CeqB_op <= '0';
    incr4_op <= '0';
    cpu_bus <= (others => 'Z');
    Clock <= '0';

    -- Reset
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    wait for 40 ns;

    -- begin by loading the A register
    cpu_bus <= "00000000000000000000000000000010";
    Ain <= '1';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    -- now, change CPU bus for B input and perform arithmetic operations
    Ain <= '0';
    
    cpu_bus <= "00000000000000000000000000000001"; -- 2 + 1 = 3
    add_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    add_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    
    cpu_bus <= "00000000000000000000000000000001"; -- 2 - 1 = 1
    sub_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    sub_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    
    cpu_bus <= "00000000000000000000000000000001"; -- -1 = all 1's
    neg_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    neg_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "11111111111111111111111111111111"; -- 2 AND -1 = 2
    and_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    and_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "00000000000000000000000000000001"; -- 1 OR 2 = 3
    or_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    or_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "11111111111111111111111111111111"; -- not -1 = 0
    not_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    not_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "10101010101010101010101010101010"; -- A shr 1 = 5
    shr_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    shr_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "11111111111111111111111111111110"; -- -2 shra 1 = -1
    shra_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    shra_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "01010101010101010101010101010101"; -- 5 shl 1 = A
    shl_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    shl_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "10000000000000000000000000000000"; -- 0x80000000 -> 0x00000001
    shc_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    shc_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= "00000000000000000000000000000001"; -- C = B
    ceqb_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    ceqb_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    cpu_bus <= (others => '0'); -- C = B + 4
    incr4_op <= '1';
    Cin <= '1';
    Cout <= '0';
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;
    incr4_op <= '0';
    Cin <= '0';
    Cout <= '1';
    cpu_bus <= (others => 'Z');
    wait for 50 ns;
    Clock <= not Clock;
    wait for 50 ns;
    Clock <= not Clock;

    wait;
    
  end process testbench_process;

END bdf_type;
