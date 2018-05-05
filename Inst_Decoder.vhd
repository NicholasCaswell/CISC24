----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2018 11:36:09 AM
-- Design Name: 
-- Module Name: Inst_Decoder - Dataflow
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Inst_Decoder is
    Port ( 
           INST_IN : in STD_LOGIC_VECTOR (23 downto 0);
           OPCODE  : out STD_LOGIC_VECTOR(4 downto 0);
           AMA     : out STD_LOGIC_VECTOR(1 downto 0);
           SRCA    : out STD_LOGIC_VECTOR(2 downto 0);
           AMB     : out STD_LOGIC_VECTOR(1 downto 0);
           SRCB    : out STD_LOGIC_VECTOR(2 downto 0);
           MASK    : out STD_LOGIC_VECTOR(3 downto 0);
           IMM19   : out STD_LOGIC_VECTOR(18 downto 0);
           IMM15   : out STD_LOGIC_VECTOR(14 downto 0);
           IMM14   : out STD_LOGIC_VECTOR(13 downto 0);
           IMM9    : out STD_LOGIC_VECTOR(8 downto 0));
end Inst_Decoder;

architecture Dataflow of Inst_Decoder is
begin
OPCODE  <= INST_IN(23 downto 19);
AMA     <= INST_IN(18 downto 17);
SRCA    <= INST_IN(16 downto 14);
AMB     <= INST_IN(13 downto 12);
SRCB    <= INST_IN(11 downto 9);
MASK    <= INST_IN(18 downto 15);
IMM19   <= INST_IN(18 downto 0);
IMM15   <= INST_IN(14 downto 0);
IMM14   <= INST_IN(13 downto 0);
IMM9    <= INST_IN(8 downto 0);
end Dataflow;
