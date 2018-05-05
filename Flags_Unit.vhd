----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 04:51:19 PM
-- Design Name: 
-- Module Name: Flags_Unit - Behavioral
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
use ieee.numeric_std.ALL;

entity Flags_Unit is
 Port (
    ALU_In : in std_logic_vector(31 downto 0);
    Valid : in std_logic;
    V_Reset : out std_logic;
    Flags : out std_logic_vector(3 downto 0);
    OP_CODE : in std_logic_vector(4 downto 0);
    ALU_OUT : out std_logic_vector(23 downto 0)
    --carry : in std_logic
);
end Flags_Unit;

architecture Behavioral of Flags_Unit is
begin

    process(Valid)
begin
if(Valid = '1') then
    if (ALU_IN = "00000000000000000000000000000000") then
        Flags(1) <= '1';
    else
        Flags(1) <= '0';
    end if;
    if (to_integer(signed(ALU_IN)) < 0) then
        Flags(3) <= '1';
    else
        Flags(3) <= '0';
    end if;
    if (ALU_IN >= "11111111111111111111111111111111") then
        Flags(2) <= '1';
    else
        Flags(2) <= '0';
    end if;
    if(ALU_IN >= "111111111111111111111111") then
        Flags(0) <= '1';
    else
        Flags(0) <= '0'; 
    end if;
  
    if (OP_CODE = "11111") then
        Flags <= "0000";
    end if;
    ALU_OUT <= ALU_IN(23 downto 0);
    V_Reset <= '1';
else
    ALU_OUT <= ALU_IN(23 downto 0);
    V_Reset <= '0';    
end if;
--   if(ALU_IN /= "ZZZZZZZZZZZZZZZZZZZZZZZZ") then
--    Dvalid <= '1';
--   else
--    Dvalid <= '0';
--   end if;
end process;
end Behavioral;
