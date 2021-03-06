LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY control_unit IS 
	PORT
	(
		reset : IN  STD_LOGIC;
		clock : IN  STD_LOGIC;
		start : IN  STD_LOGIC;
		done : IN  STD_LOGIC;
		opcode :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);	
		c3_2_downto_0 : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		
		cpu_bus :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r_memory : OUT  STD_LOGIC;
		w_memory : OUT  STD_LOGIC;
		main : OUT  STD_LOGIC;
		mdwr : OUT  STD_LOGIC;
		mdbus : OUT  STD_LOGIC;
		mdrd : OUT  STD_LOGIC;
		mdout : OUT  STD_LOGIC;
		pcout : OUT  STD_LOGIC;
		pcin : OUT  STD_LOGIC;
		irin : OUT  STD_LOGIC;
		rin : OUT  STD_LOGIC; 
		rout : OUT  STD_LOGIC; 
		baout : OUT  STD_LOGIC; 
		gra : OUT  STD_LOGIC; 
		grb : OUT  STD_LOGIC;
		grc : OUT  STD_LOGIC;
		c1out : OUT  STD_LOGIC;
		c2out : OUT  STD_LOGIC;
		cin : OUT  STD_LOGIC;
		cout : OUT  STD_LOGIC;
		ain : OUT  STD_LOGIC;
		incr4_op : OUT  STD_LOGIC;
		add_op : OUT  STD_LOGIC;
		sub_op : OUT  STD_LOGIC;
		neg_op :  OUT  STD_LOGIC;		
		and_op :  OUT  STD_LOGIC; 
		or_op :  OUT  STD_LOGIC;
		not_op :  OUT  STD_LOGIC;
		shr_op :  OUT  STD_LOGIC;
		shra_op :  OUT  STD_LOGIC;
		shl_op :  OUT  STD_LOGIC;
		shc_op :  OUT  STD_LOGIC;
		ceqb_op :  OUT  STD_LOGIC;
	);
END control_unit;

ARCHITECTURE bdf_type OF control_unit IS 

COMPONENT 
	PORT(
	);
END COMPONENT;


SIGNAL	


BEGIN 


END bdf_type;