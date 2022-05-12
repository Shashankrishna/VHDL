-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"
-- CREATED		"Wed May 04 04:43:59 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY multiplier IS 
	PORT
	(
		Reset :  IN  STD_LOGIC;                          -- Reset Signal
		Clock :  IN  STD_LOGIC;                          -- Clock Signal
		Start :  IN  STD_LOGIC;                          -- Start Signal
		X :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);           -- X Input Signal
		Y :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);           -- Y Input Signal
		Done :  OUT  STD_LOGIC;                          -- Done Signal
		Result :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)     -- Result Signal
	);
END multiplier;

ARCHITECTURE bdf_type OF multiplier IS 

COMPONENT adder                                        -- Addition Component
	PORT(Add_op : IN STD_LOGIC;                         -- Initiate Addition Operation
		 Hold_carry : IN STD_LOGIC;                      -- Hold Carry Signal
		 A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);            -- Input Signal
		 B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);            -- Input Signal
		 Carry_out : OUT STD_LOGIC;                      -- Carry Output Signal
		 Sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)          -- Summation Output Signal
	);
END COMPONENT;

COMPONENT controller                             -- Controller Component
	PORT(Reset : IN STD_LOGIC;                    -- Reset Signal
		 Clock : IN STD_LOGIC;                     -- Clock Signal
		 Start : IN STD_LOGIC;                     -- Start Signal (start the multiplication operation)
		 Q0 : IN STD_LOGIC;                        -- LSB of shift register Q
		 A_Load_0 : OUT STD_LOGIC;                 -- Clear Signal for Shift Register A
		 Add_op : OUT STD_LOGIC;                   -- Addition Operation Signal
		 Awrite : OUT STD_LOGIC;                   -- Enable signal to Shift Register A
		 Done : OUT STD_LOGIC;                     -- Done Signal
		 Enable_Multiplicand : OUT STD_LOGIC;      -- Enable signal to Register B
		 Enable_Multiplier : OUT STD_LOGIC;        -- Enable signal to Shift Register Q
		 Enable_Adder : OUT STD_LOGIC;             -- Enable signal to Adder
		 Enable_Shift : OUT STD_LOGIC;             -- Shift Operation for both Shift Registers
		 Hold_carry : OUT STD_LOGIC                -- Hold Carry signal to Adder Block
	);
END COMPONENT;

COMPONENT register_b                             -- Register B: To store Input X
	PORT(Reset : IN STD_LOGIC;
		 Clock : IN STD_LOGIC;
		 Enable : IN STD_LOGIC;                    -- Enable Signal to Register
		 D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);      -- D input [D Flip Flop]
		 Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)      -- Q output [D Flip Flop]
	);
END COMPONENT;

COMPONENT shiftregister                          -- Shift Operation
	PORT(Reset : IN STD_LOGIC;
		 Clock : IN STD_LOGIC;
		 Enable : IN STD_LOGIC;                    -- Enable Shift Register
		 Shift_op : IN STD_LOGIC;                  -- Start Shift Operation
		 ShiftIn : IN STD_LOGIC;                   -- Shift In signal
		 D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);      -- D Input Signal
		 ShiftOut : OUT STD_LOGIC;                 -- Shift Out Signal
		 Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)      -- Q Output Signal
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;


BEGIN 



b2v_Adder : adder
PORT MAP(Add_op => SYNTHESIZED_WIRE_0,
		 Hold_carry => SYNTHESIZED_WIRE_1,
		 A => SYNTHESIZED_WIRE_2,
		 B => SYNTHESIZED_WIRE_3,
		 Carry_out => SYNTHESIZED_WIRE_9,
		 Sum => SYNTHESIZED_WIRE_10);


b2v_Controller : controller
PORT MAP(Reset => Reset,
		 Clock => Clock,
		 Start => Start,
		 Q0 => SYNTHESIZED_WIRE_4,
		 A_Load_0 => SYNTHESIZED_WIRE_6,
		 Awrite => SYNTHESIZED_WIRE_7,
		 Done => Done,
		 Enable_Multiplicand => SYNTHESIZED_WIRE_5,
		 Enable_Multiplier => SYNTHESIZED_WIRE_11,
		 Enable_Adder => SYNTHESIZED_WIRE_0,
		 Enable_Shift => SYNTHESIZED_WIRE_14,
		 Hold_carry => SYNTHESIZED_WIRE_1);


b2v_Register_B : register_b
PORT MAP(Reset => Reset,
		 Clock => Clock,
		 Enable => SYNTHESIZED_WIRE_5,
		 D => X,
		 Q => SYNTHESIZED_WIRE_3);


b2v_ShiftRegister_A : shiftregister
PORT MAP(Reset => SYNTHESIZED_WIRE_6,
		 Clock => Clock,
		 Enable => SYNTHESIZED_WIRE_7,
		 Shift_op => SYNTHESIZED_WIRE_14,
		 ShiftIn => SYNTHESIZED_WIRE_9,
		 D => SYNTHESIZED_WIRE_10,
		 ShiftOut => SYNTHESIZED_WIRE_13,
		 Q => SYNTHESIZED_WIRE_2);


b2v_ShiftRegister_Q : shiftregister
PORT MAP(Reset => Reset,
		 Clock => Clock,
		 Enable => SYNTHESIZED_WIRE_11,
		 Shift_op => SYNTHESIZED_WIRE_14,
		 ShiftIn => SYNTHESIZED_WIRE_13,
		 D => Y,
		 ShiftOut => SYNTHESIZED_WIRE_4,
		 Q => Result(31 downto 0));   -- Output of Shift Register Q

   -- append the output from Shift Register A to Result.
	-- Eliminating an additional Register, combining the outputs of Shift Registers.
	
   Result(63 downto 32) <= SYNTHESIZED_WIRE_2(31 downto 0);
 
END bdf_type;