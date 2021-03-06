LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RegisterFileTestBench IS
END RegisterFileTestBench;

ARCHITECTURE bdf_type OF RegisterFileTestBench IS

	COMPONENT register_file
		PORT (
			Reset: IN STD_LOGIC;
			Clock: IN STD_LOGIC;
			register_select: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			Rin: IN STD_LOGIC;
			Rout: IN STD_LOGIC;
			BAout: IN STD_LOGIC;
			cpu_bus: INOUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	
	SIGNAL Reset: STD_LOGIC;
	SIGNAL Clock: STD_LOGIC;
	SIGNAL register_select: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL Rin: STD_LOGIC;
	SIGNAL Rout: STD_LOGIC;
	SIGNAL BAout: STD_LOGIC;
	SIGNAL cpu_bus: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	
	b2v_RF_0 : register_file
		PORT MAP(
			Reset => Reset,
			Clock => Clock,
			register_select => register_select,
			Rin => Rin,
			Rout => Rout,
			BAout => BAout,
			cpu_bus => cpu_bus);
			
	testbench_process : PROCESS
		VARIABLE i : INTEGER := 0;
	BEGIN
		
		-- initialize signals
		Clock <= '0';
		register_select <= (OTHERS => '0');
		Rin <= '0';
		Rout <= '0';
		BAout <= '0';
		cpu_bus <= (OTHERS => 'Z');
		
		-- reset register file
		Reset <= '1';
		wait for 10 ns;
		Reset <= '0';
		wait for 40 ns;
		
		-- load each register with a value specific to it
		Rin <= '1';
		FOR i IN 31 DOWNTO 1 LOOP
			register_select <= STD_LOGIC_VECTOR(TO_UNSIGNED(i,5));
			cpu_bus(31 DOWNTO 5) <= (OTHERS => '0');
			cpu_bus(4 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i,5));
			wait for 50 ns;
			Clock <= not Clock;
			wait for 50 ns;
			Clock <= not Clock;
		END LOOP;
		register_select <= (OTHERS => '0');
		cpu_bus <= (OTHERS => '1');
		wait for 50 ns;
		Clock <= not Clock;
		wait for 50 ns;
		Clock <= not Clock;
		Rin <= '0';
		cpu_bus <= (OTHERS => 'Z');
		
		-- output when Rout = 1
		Rout <= '1';
		FOR i IN 31 DOWNTO 0 LOOP
			register_select <= STD_LOGIC_VECTOR(TO_UNSIGNED(i,5));
			wait for 50 ns;
			Clock <= not Clock;
			wait for 50 ns;
			Clock <= not Clock;
		END LOOP;
		Rout <= '0';
		
		-- output when BAout = 1
		BAout <= '1';
		FOR i IN 31 DOWNTO 0 LOOP
			register_select <= STD_LOGIC_VECTOR(TO_UNSIGNED(i,5));
			wait for 50 ns;
			Clock <= not Clock;
			wait for 50 ns;
			Clock <= not Clock;
		END LOOP;
		BAout <= '0';
		
		
		wait;
		
	END PROCESS testbench_process;
	
END bdf_type;
