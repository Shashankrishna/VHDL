LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY register_file IS
	PORT (
		Reset: IN STD_LOGIC;
		Clock: IN STD_LOGIC;
		register_select: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Rin: IN STD_LOGIC;
		Rout: IN STD_LOGIC;
		BAout: IN STD_LOGIC;
		cpu_bus: INOUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'Z')
		);
END register_file;

ARCHITECTURE rtl OF register_file IS
	TYPE register_array IS ARRAY (31 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL register_Q: register_array;
	
BEGIN --rtl

	RF_process: PROCESS(Reset, Clock, register_select, Rin, cpu_bus)
		VARIABLE i: INTEGER := 0;
	BEGIN
		IF (Reset = '1') THEN
			FOR i IN 31 DOWNTO 0 LOOP
				register_Q(i) <= (OTHERS => '0');
			END LOOP;
			
			-- register_Q<=(OTHERS=>(OTHERS=>'0'));
			
		ELSIF (Rin = '1' AND RISING_EDGE(Clock)) THEN
			register_Q(to_integer(unsigned(register_select))) <= cpu_bus;
		END IF;
	END PROCESS RF_process;
	
	OUT_process: PROCESS(register_select, Rout, BAout)
	BEGIN
		IF (Rout = '1') THEN
			cpu_bus <= register_Q(to_integer(unsigned(register_select)));
		ELSIF (BAout = '1') THEN
			IF (to_integer(unsigned(register_select)) = 0) THEN
				cpu_bus <= (OTHERS => '0');
			ELSE
				cpu_bus <= register_Q(to_integer(unsigned(register_select)));
			END IF;
		ELSE
			cpu_bus <= (OTHERS => 'Z');
		END IF;
	END PROCESS OUT_process;

END rtl;
