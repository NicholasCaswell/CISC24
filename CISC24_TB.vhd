--CPU TB

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CISC24_TB IS
END CISC24_TB;

ARCHITECTURE IOTEST OF CISC24_TB IS

component CISC_24_V2_4_13_2018_wrapper
    Port ( 
	        ALU_OUT_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            CLK_0 : in STD_LOGIC;
            DMem_Dout_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            DMem_Dout_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            Data_Valid_0 : out STD_LOGIC;
            Ext_Mem_In_0 : in STD_LOGIC_VECTOR ( 23 downto 0 );
            Flags_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
            Inst : out STD_LOGIC_VECTOR ( 23 downto 0 );
            MASK_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
            Mem_Reg_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            Mem_Reg_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            Opcode_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
            PC_0 : out STD_LOGIC_VECTOR ( 8 downto 0 );
            RST_0 : in STD_LOGIC;
            Reg_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            Reg_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            Reg_Bank_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            Reg_Bank_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
            PMem_Data_0  : out STD_LOGIC_VECTOR ( 23 downto 0 );
            STATE_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
            Reg_A_Mux_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
            Reg_B_Mux_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
            key_board_input_0 : in STD_LOGIC_VECTOR ( 23 downto 0 ));
END COMPONENT;

    signal ALU_OUT_1 : STD_LOGIC_VECTOR ( 23 downto 0 );
    signal CLK_1 :  STD_LOGIC;
    signal DMem_Dout_A_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal DMem_Dout_B_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Data_Valid_1 :  STD_LOGIC;
    signal Ext_Mem_In_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Flags_1 :  STD_LOGIC_VECTOR ( 3 downto 0 );
    signal Inst_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal MASK_1 :  STD_LOGIC_VECTOR ( 3 downto 0 );
    signal Mem_Reg_A_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Mem_Reg_B_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Opcode_1 :  STD_LOGIC_VECTOR ( 4 downto 0 );
    signal PC_1 :  STD_LOGIC_VECTOR ( 8 downto 0 );
    signal RST_1 :  STD_LOGIC;
    signal Reg_A_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Reg_B_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Reg_Bank_A_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Reg_Bank_B_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal PMem_Data_1 :  STD_LOGIC_VECTOR ( 23 downto 0 );
    signal STATE_1 :  STD_LOGIC_VECTOR ( 3 downto 0 );
    signal key_board_input_1 : STD_LOGIC_VECTOR ( 23 downto 0 );
    signal Reg_A_Mux_1 :  STD_LOGIC_VECTOR ( 1 downto 0 );
    signal Reg_B_Mux_1 :  STD_LOGIC_VECTOR ( 1 downto 0 );

    constant period : time := 40 ns;
begin
uut: CISC_24_V2_4_13_2018_wrapper port map(
        ALU_OUT_0 => ALU_OUT_1,
        CLK_0  => CLK_1,
        DMem_Dout_A_0 => DMem_Dout_A_1, 
        DMem_Dout_B_0  => DMem_Dout_B_1,
        Data_Valid_0 => Data_Valid_1, 
        Ext_Mem_In_0  => Ext_Mem_In_1,
        Flags_0  => Flags_1,
        Inst  => Inst_1,
        MASK_0  => MASK_1,
        Mem_Reg_A_0  => Mem_Reg_A_1,
        Mem_Reg_B_0  => Mem_Reg_B_1,
        Opcode_0  => Opcode_1,
        PC_0  => PC_1,
        RST_0  => RST_1,
        Reg_A_0  => Reg_A_1,
        Reg_B_0  => Reg_B_1,
        Reg_Bank_A_0  => Reg_Bank_A_1,
        Reg_Bank_B_0  => Reg_Bank_B_1,
        STATE_0  => STATE_1,
        key_board_input_0 => key_board_input_1,
        Reg_A_Mux_0 => Reg_A_Mux_1,
        Reg_B_Mux_0 => Reg_B_Mux_1,
        PMem_Data_0 => PMem_Data_1); 
		
Clk_Process : process
begin 
	CLK_1 <= '1'; wait for period;
	CLK_1 <= '0'; wait for period;
end process CLk_Process;

tb : process

begin
    RST_1 <= '1';
	wait for period;
	wait for period;
	wait for period;
    wait for period;
    wait for period;
	RST_1 <= '0';
	wait for 4ms;
end process;

END IOTEST;