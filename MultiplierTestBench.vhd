library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity  MultiplierTestBench  is
end MultiplierTestBench;

architecture BEHAVIORAL of MultiplierTestBench is
component Multiplier
	PORT
	(
		Reset :  IN  STD_LOGIC;                             -- Reset Signal
		Clock :  IN  STD_LOGIC;                             -- Clock Signal
		Start :  IN  STD_LOGIC;                             -- Start Signal
		X :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);              -- X Input Signal
		Y :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);              -- Y Input Signal 
		Done :  OUT  STD_LOGIC;                             -- Done Signal
		Result :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)        -- Result Signal
	);
end component;

-- Signal Declaration

Signal		Reset :  STD_LOGIC;                          
Signal		Clock :  STD_LOGIC;                          
Signal		Start :  STD_LOGIC;                          
Signal		X :  STD_LOGIC_VECTOR(31 DOWNTO 0);           
Signal		Y :  STD_LOGIC_VECTOR(31 DOWNTO 0);           
Signal		Done :  STD_LOGIC;                           
Signal		Result :  STD_LOGIC_VECTOR(63 DOWNTO 0);     

begin

-- Instantiate the Device Under Test
inst_DUT : Multiplier
  port map (
    X => X,
    Y => Y,
    Clock => Clock,
    Reset => Reset,
    Result => Result,
    Start => Start,
    Done => Done);
	 
   testbench_process : process

    begin

        -- Initialize
        Reset <= '0';
        Clock <= '0';
        Start <= '0';
        X <= (others => '0');
        Y <= (others => '0');

        -- Reset
        Reset <= '1';
        wait for 10 ns;
        Reset <= '0';

	  
          X <= "00000000000000000000000000000001";      -- Assign X Values [Multiplicabd]
          Y <= "00000000000000000000000000000001";      -- Assign Y Values [Multiplier]
  
        Start <= '1';             -- Start the multiplier operation
         wait for 50 ns;
         Clock <= not Clock;
         wait for 50 ns;
         Clock <= not Clock; 
		   Start <= '0';
			
			
        loop                     -- Continue Clock Cycles
         wait for 50 ns;
         Clock <= not Clock;
         wait for 50 ns;
         Clock <= not Clock; 
        end loop;

        wait until Done = '1';   -- Wait for the multiplier to finish
		  
     
    end process;



end BEHAVIORAL;

