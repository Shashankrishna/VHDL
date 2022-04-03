LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;

entity control_signals_logic is
  port(
    opcode : in std_logic_vector(4 downto 0);
    t0 : in std_logic;
    t1 : in std_logic;
    t2 : in std_logic;
    t3 : in std_logic;
    t4 : in std_logic;
    t5 : in std_logic;
    t6 : in std_logic;
    t7 : in std_logic;
    t8 : in std_logic;
    t9 : in std_logic;
    t10 : in std_logic;
    t11 : in std_logic;
    t12 : in std_logic;
    t13 : in std_logic;
    t14 : in std_logic;
    t15 : in std_logic;
    neq0      : in   std_logic;
    con       : in   std_logic;
    irin      : out std_logic;
    c1out     : out std_logic;
    c2out     : out std_logic;
    gra       : out std_logic;
    grb       : out std_logic;
    grc       : out std_logic;
    main      : out std_logic;
    mdbus     : out std_logic;
    mdrd      : out std_logic;
    mdout     : out std_logic;
    pcin      : out std_logic;
    pcout     : out std_logic;
    ain       : out std_logic;
    cin       : out std_logic;
    cout      : out std_logic;
    add_op    : out std_logic;
    sub_op    : out std_logic;
    neg_op    : out std_logic;
    and_op    : out std_logic;
    or_op     : out std_logic;
    not_op    : out std_logic;
    shr_op    : out std_logic;
    shra_op   : out std_logic;
    shl_op    : out std_logic;
    shc_op    : out std_logic;
    ceqb_op   : out std_logic;
    incr4_op  : out std_logic;
    baout     : out std_logic;
    rin       : out std_logic;
    rout      : out std_logic;
    end_sig : out std_logic;
    stop_sig : out std_logic;
    read_control : out std_logic;  -- to sequencer
    write_control : out std_logic; -- to sequencer
    wait_sig : out std_logic;
    goto6 : out std_logic;
    conin     : out std_logic;
    ld_shift      : out std_logic;
    decr      : out std_logic
    );
end control_signals_logic;

architecture rtl of control_signals_logic is
    signal nop_instr: std_logic;
	 signal ld_instr: std_logic; 
	 signal ldr_instr: std_logic;
	 signal st_instr: std_logic;
	 signal str_instr: std_logic;
	 signal la_instr: std_logic;
	 signal lar_instr: std_logic;
	 signal br_instr: std_logic;
	 signal brl_instr: std_logic;
	 signal add_instr: std_logic;
	 signal addi_instr: std_logic;
	 signal sub_instr: std_logic;
	 signal neg_instr: std_logic;
	 signal and_instr: std_logic;
	 signal andi_instr: std_logic;
	 signal or_instr: std_logic;
	 signal ori_instr: std_logic;
	 signal not_instr: std_logic;
	 signal shr_instr: std_logic;
	 signal shra_instr: std_logic;
	 signal shl_instr: std_logic;
	 signal shc_instr: std_logic;
	 signal stop_instr:  std_logic;
	 
Component opcode_decoder
   port(
       opcode : in std_logic_vector(4 downto 0);
	    nop_instr : out std_logic;
	    ld_instr : out std_logic;
	    ldr_instr : out std_logic;
	    st_instr : out std_logic;
	    str_instr : out std_logic;
	    la_instr : out std_logic;
	    lar_instr : out std_logic;
	    br_instr : out std_logic;
	    brl_instr : out std_logic;
	    add_instr : out std_logic;
	    addi_instr : out std_logic;
	    sub_instr : out std_logic;
	    neg_instr : out std_logic;
	    and_instr : out std_logic;
	    andi_instr : out std_logic;
	    or_instr : out std_logic;
	    ori_instr : out std_logic;
	    not_instr : out std_logic;
	    shr_instr : out std_logic;
	    shra_instr : out std_logic;
	    shl_instr : out std_logic;
	    shc_instr : out std_logic;
	    stop_instr : out std_logic
		 );
end Component;

begin

     b2v_opcode_decoder: opcode_decoder
	     port map(
		      opcode => opcode,
				nop_instr => nop_instr,
				ld_instr => ld_instr,
				ldr_instr => ldr_instr,
				st_instr => st_instr,
				str_instr => str_instr,
				la_instr => la_instr,
				lar_insr => lar_instr,
				br_instr => br_instr,
				brl_instr => brl_instr,
				add_instr => add_instr,
				addi_instr => addi_instr,
				sub_instr => sub_instr,
				neg_instr => neg_instr,
				and_instr => and_instr,
				andi_instr => andi_instr,
				or_instr => or_instr,
				ori_instr => ori_instr,
			   not_instr => not_instr,
				shr_instr => shr_instr,
				shra_instr => shra_instr,
				shl_instr => shl_instr,
				shc_instr => shc_instr,
				stop_instr => stop_instr
				);
				
	irin <= (t2);
   c1out <= (t4 and ldr) or (t4 and str) or (t4 and lar) or (t3 and shr) or (t3 and shra) or (t3 and shl) or (t3 and shc);
   c2out <= (t4 and ld) or (t4 and st) or (t4 and la) or (t4 and addi) or (t4 and andi) or (t4 and ori);
   gra <= (t7 and ld) or (t7 and ldr) or (t6 and st) or (t6 and str) or (t5 and la) or (t5 and lar) or (t3 and brl) or (t5 and add) or (t5 and addi) or (t5 and sub) or (t5 and neg) or (t5 and and_instr) or (t5 and andi) or (t5 and or_instr) or (t5 and ori) or (t5 and not_instr) or (t7 and shr) or (t7 and shra) or (t7 and shl) or (t7 and shc);
	grb <= (t3 and ld) or (t3 and st) or (t3 and la) or (t4 and br) or (t5 and brl) or (t3 and add) or (t3 and addi) or (t3 and sub) or (t3 and and_instr) or (t3 and andi) or (t3 and or_instr) or (t3 and ori) or (t5 and shr) or (t5 and shra) or (t5 and shl) or (t5 and shc);
	grc <= (t3 and br) or (t4 and brl) or (t4 and add) or (t4 and sub) or (t3 and neg) or (t4 and and_instr) or (t4 and or_instr) or (t3 and not_instr) or (t4 and shr) or (t4 and shra) or (t4 and shl) or (t4 and shc);
	main <= (t0) or (t5 and ld) or (t5 and ldr) or (t5 and st) or (t5 and str);
	mdbus <= (t6 and st) or (t6 and str);
	mdrd <= (t1) or (t6 and ld) or (t6 and ldr);
	mdout <= (t2) or (t7 and ld) or (t7 and ldr);
	pcin <= (t1) or (t4 and br) or (t5 and brl);
	pcout <= (t0) or (t3 and ldr) or (t3 and str) or (t3 and lar) or (t3 and brl);
	ain <= (t3 and ld) or (t3 and ldr) or (t3 and st) or (t3 and str) or (t3 and la) or (t3 and lar) or (t3 and add) or (t3 and addi) or (t3 and sub) or (t3 and and_instr) or (t3 and andi) or (t3 and or_instr) or (t3 and ori);
	cin <= (t0) or (t4 and ld) or (t4 and ldr) or (t4 and st) or (t4 and str) or (t4 and la) or (t4 and lar) or (t4 and add) or (t4 and addi) or (t4 and sub) or (t4 and neg) or (t4 and and_instr) or (t4 and andi) or (t4 and or_instr) or (t4 and ori) or (t4 and not_instr) or (t5 and shr) or (t6 and shr) or (t5 and shr) or (t6 and shr) or (t5 and shr) or (t6 and shra) or (t5 and shl) or (t6 and shl) or (t5 and shc) or (t6 and shc);
	cout <= (t1) or (t5 and ld) or (t5 and ldr) or (t5 and st) or (t5 and str) or (t5 and la) or (t5 and lar) or (t5 and add) or (t5 and addi) or (t5 and sub) or (t5 and neg) or (t5 and and_instr) or (t5 and andi) or (t5 and or_instr) or (t5 and or_instr) or (t6 and shr) or (t7 and shr) or (t6 and shra) or (t7 and shra) or (t6 and shl) or (t7 and shl) or (t6 and shc) or (t7 and shc); 
 	baout <= (t3 and ld) or (t3 and st) or (t3 and la);
	rin <= (t7 and ld) or (t7 and ldr) or (t5 and la) or (t5 and lar) or (t3 and brl) or (t5 and add) or (t5 and addi) or (t5 and sub) or (t5 and neg) or (t7 and shr) or (t7 and shra) or (t7 and shl) or (t7 and shc);
	rout <= (t6 and st) or (t6 and str) or (t3 and br) or (t4 and br) or (t4 and brl) or (t4 and brl) or(t5 and brl) or (t3 and add) or (t4 and add) or (t3 and addi) or (t3 and sub) or (t4 and sub) or (t3 and neg) or (t3 and and_instr) or (t3 and andi) or (t3 and or_instr) or (t4 and or_instr) or (t3 and ori) or (t3 and not_instr) or (t4 and shr) or (t4 and shra) or (t4 and shl) or (t5 and shl) or (t4 and shc) or (t5 and shc);
	end_sig <= (t3 and nop) or (t7 and ld) or (t7 and ldr) or (t7 and st) or (t7 and str) or (t5 and la) or (t5 and lar) or (t4 and br) or (t5 and brl) or (t5 and add) or (t5 and addi) or (t5 and sub) or (t5 and neg) or (t5 and and_instr) or (t5 and andi) or (t5 and or_instr) or (t5 and ori) or (t5 and not_instr) or (t7 and shr) or (t7 and shra) or (t7 and shl) or (t7 and shc);
	stop_sig <= (t3 and stop);
	read_control <= (t1) or (t6) or (ldr);
	write_control <= (t7 and st) or (t7 and str);
	wait_sig <= (t1) or (t6 and ld) or (t6 and ldr) or (t7 and st) or (t7 and str);
   goto6 <= (t6 and shra) or (t6 and shl) or (t6 and shc);
   conin <= (t3 and br) or (t4 and brl);
	ld_shift <= (t3 and shr) or (t4 and shr) or (t3 and shra) or (t4 and shra) or (t3 and shl) or (t4 and shl) or (t3 and shc) or (t4 and shc);
	decr <= (t6 and shr) or (t6 and shra) or (t6 and shl) or (t6 and shc);
	
end rtl;
