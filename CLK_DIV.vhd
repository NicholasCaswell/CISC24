----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2018 08:41:17 PM
-- Design Name: 
-- Module Name: CLK_DIV - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLK_DIV is
    Port ( CLK : in STD_LOGIC;
           output: out STD_LOGIC);
end CLK_DIV;

architecture Behavioral of CLK_DIV is
    signal ck,temp: std_logic;
    signal counter: integer range 0 to 100000000; 
begin
    output <= temp;
       
    process(clk)
    begin
        if(clk'event and clk ='1') THEN
            if(counter = 25000) then --clk divider
                temp <= temp xor '1';
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
     end process;
end behavioral;