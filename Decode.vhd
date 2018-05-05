----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2018 06:19:37 PM
-- Design Name: 
-- Module Name: Decode - Behavioral
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

entity Decode is
    Port ( 
           Num : in STD_LOGIC_VECTOR (3 downto 0);
           Cath : out STD_LOGIC_VECTOR (6 downto 0));
end Decode;

architecture Behavioral of Decode is

begin

with num select cath <= 
                         "0000001" when x"0",
                         "1001111" when x"1",
                         "0010010" when x"2",
                         "0000110" when x"3",
                         "1001100" when x"4",
                         "0100100" when x"5",
                         "0100000" when x"6",
                         "0001111" when x"7",
                         "0000000" when x"8",
                         "0000100" when x"9",
                         "0001000" when x"A",
                         "1100000" when x"B",
                         "0110001" when x"C",
                         "1000010" when x"D",
                         "0110000" when x"E",
                         "0111000" when x"F",
                         "1111111" when others;

end Behavioral;
