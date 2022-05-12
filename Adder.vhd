LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Adder is
    PORT ( A : IN STD_LOGIC_VECTOR (31 downto 0);    -- A Input Signal
           B : IN STD_LOGIC_VECTOR (31 downto 0);    -- B Input Signal
			  Add_op: IN STD_LOGIC;                    -- Addition Start Signal
			  Hold_carry: IN STD_LOGIC;                -- Carry Signal used, if Carry Exists.
           Sum : OUT STD_LOGIC_VECTOR (31 downto 0); -- Summation Signal
			  Carry_out: OUT STD_LOGIC                 -- Carry Out Signal
			 );
END ENTITY Adder;

ARCHITECTURE rtl of Adder is
signal tmp: std_logic_vector(32 downto 0);  
BEGIN
	PROCESS (A, B, Add_op)
	BEGIN
		IF (Add_op = '1' AND Hold_carry = '1') THEN
            tmp <= conv_std_logic_vector((conv_integer(A)+conv_integer(B)),33);  
            Sum <= tmp(31 downto 0);  
            Carry_out  <= tmp(32); 
		ELSE
			Sum <= A;
		END IF;
	END PROCESS;

END rtl;

-- Add two numbers and check for added value and carry out.
-- If the addition operation and hold carry signal is active high, will calculate 
-- Summation and Carry Signal.
