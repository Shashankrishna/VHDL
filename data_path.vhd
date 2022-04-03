LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY data_path IS 
	PORT
	(
		reset : IN  STD_LOGIC;
		clock : IN  STD_LOGIC;
		pcout : IN  STD_LOGIC;
		pcin : IN  STD_LOGIC;
		embr : IN  STD_LOGIC;
		irin : IN  STD_LOGIC;
		rin : IN  STD_LOGIC;
		rout : IN  STD_LOGIC;
		baout : IN  STD_LOGIC;
		gra : IN  STD_LOGIC;
		grb : IN  STD_LOGIC;
		grc : IN  STD_LOGIC;
		c1out : IN  STD_LOGIC;
		c2out : IN  STD_LOGIC;
		cin : IN  STD_LOGIC;
		cout : IN  STD_LOGIC; 
		ain : IN  STD_LOGIC; 
		incr4_op : IN  STD_LOGIC; 
		add_op : IN  STD_LOGIC; 
		sub_op : IN  STD_LOGIC;
		neg_op : IN  STD_LOGIC;
		and_op : IN  STD_LOGIC;
		or_op : IN  STD_LOGIC;
		not_op : IN  STD_LOGIC;
		shr_op : IN  STD_LOGIC;
		shra_op : IN  STD_LOGIC;
		shl_op : IN  STD_LOGIC;
		shc_op : IN  STD_LOGIC;
		ceqb_op : IN  STD_LOGIC;
		opcode :  OUT  STD_LOGIC_VECTOR(4 DOWNTO 0);		
		c3_2_downto_0 : OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		cpu_bus :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
	);
END data_path;

ARCHITECTURE bdf_type OF data_path IS 

COMPONENT 
	PORT(
	);
END COMPONENT;


SIGNAL	


BEGIN 


END bdf_type;