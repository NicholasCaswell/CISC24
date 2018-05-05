--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Fri May  4 15:47:51 2018
--Host        : Cortana running 64-bit major release  (build 9200)
--Command     : generate_target CISC_24_V2_4_13_2018_wrapper.bd
--Design      : CISC_24_V2_4_13_2018_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity CISC_24_V2_4_13_2018_wrapper is
  port (
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
    PMem_Data_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    RST_0 : in STD_LOGIC;
    Reg_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Reg_A_Mux_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Reg_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Reg_B_Mux_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Reg_Bank_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Reg_Bank_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    STATE_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    key_board_input_0 : in STD_LOGIC_VECTOR ( 23 downto 0 )
  );
end CISC_24_V2_4_13_2018_wrapper;

architecture STRUCTURE of CISC_24_V2_4_13_2018_wrapper is
  component CISC_24_V2_4_13_2018 is
  port (
    CLK_0 : in STD_LOGIC;
    RST_0 : in STD_LOGIC;
    Inst : out STD_LOGIC_VECTOR ( 23 downto 0 );
    DMem_Dout_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    DMem_Dout_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    STATE_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Reg_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Reg_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Reg_A_Mux_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Reg_B_Mux_0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Reg_Bank_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Reg_Bank_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Opcode_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    Data_Valid_0 : out STD_LOGIC;
    Flags_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ALU_OUT_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Mem_Reg_B_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    Mem_Reg_A_0 : out STD_LOGIC_VECTOR ( 23 downto 0 );
    PC_0 : out STD_LOGIC_VECTOR ( 8 downto 0 );
    Ext_Mem_In_0 : in STD_LOGIC_VECTOR ( 23 downto 0 );
    key_board_input_0 : in STD_LOGIC_VECTOR ( 23 downto 0 );
    MASK_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    PMem_Data_0 : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component CISC_24_V2_4_13_2018;
begin
CISC_24_V2_4_13_2018_i: component CISC_24_V2_4_13_2018
     port map (
      ALU_OUT_0(23 downto 0) => ALU_OUT_0(23 downto 0),
      CLK_0 => CLK_0,
      DMem_Dout_A_0(23 downto 0) => DMem_Dout_A_0(23 downto 0),
      DMem_Dout_B_0(23 downto 0) => DMem_Dout_B_0(23 downto 0),
      Data_Valid_0 => Data_Valid_0,
      Ext_Mem_In_0(23 downto 0) => Ext_Mem_In_0(23 downto 0),
      Flags_0(3 downto 0) => Flags_0(3 downto 0),
      Inst(23 downto 0) => Inst(23 downto 0),
      MASK_0(3 downto 0) => MASK_0(3 downto 0),
      Mem_Reg_A_0(23 downto 0) => Mem_Reg_A_0(23 downto 0),
      Mem_Reg_B_0(23 downto 0) => Mem_Reg_B_0(23 downto 0),
      Opcode_0(4 downto 0) => Opcode_0(4 downto 0),
      PC_0(8 downto 0) => PC_0(8 downto 0),
      PMem_Data_0(23 downto 0) => PMem_Data_0(23 downto 0),
      RST_0 => RST_0,
      Reg_A_0(23 downto 0) => Reg_A_0(23 downto 0),
      Reg_A_Mux_0(1 downto 0) => Reg_A_Mux_0(1 downto 0),
      Reg_B_0(23 downto 0) => Reg_B_0(23 downto 0),
      Reg_B_Mux_0(1 downto 0) => Reg_B_Mux_0(1 downto 0),
      Reg_Bank_A_0(23 downto 0) => Reg_Bank_A_0(23 downto 0),
      Reg_Bank_B_0(23 downto 0) => Reg_Bank_B_0(23 downto 0),
      STATE_0(3 downto 0) => STATE_0(3 downto 0),
      key_board_input_0(23 downto 0) => key_board_input_0(23 downto 0)
    );
end STRUCTURE;
