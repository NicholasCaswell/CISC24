----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2018 06:19:10 PM
-- Design Name: 
-- Module Name: Segment_Top - Behavioral
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

entity Segment_Top is
    Port ( 
           num : in STD_LOGIC_VECTOR (23 downto 0); --24 for 8 digits
           CLK_1 : in STD_LOGIC;
           Cathode : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end Segment_Top;

architecture Behavioral of Segment_Top is
Component Decode is
    Port ( 
           Num : in STD_LOGIC_VECTOR (3 downto 0);
           Cath : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component CLK_DIV is
    Port ( 
           CLK : in STD_LOGIC;
           output: out STD_LOGIC);
end component;

signal dec_in: Std_logic_vector(3 downto 0);
signal counter: Std_logic_vector(3 downto 0); --4
signal sel: std_logic_vector(8 downto 0);
signal clk_out: std_logic;
begin
u1: decode port map(Num=>dec_in,
                    Cath=>Cathode);
u2: CLK_DIV port map(CLK=>CLK_1 ,
                     output=>clk_out);

                
controller :process(clk_out) is
            begin
                if(clk_out'event and clk_out='1') then
                if(counter = x"5") then --x"9" for 8 digits
                counter <=x"0";
                end if;
                case counter is
                when x"0" => dec_in <= num(3 downto 0);
                            AN <= x"7F";
                when x"1" => dec_in <=num(7 downto 4) ;
                            AN <= x"BF";
                when x"2" => dec_in <= num(11 downto 8);
                            AN <= x"DF";
                when x"3" => dec_in <= num(15 downto 12);
                            AN <= x"EF";
                when x"4" => dec_in <= num(19 downto 16);
                            AN <= x"F7";
                when x"5" => dec_in <= num(23 downto 20);
                            AN <= x"FB";
--                when x"6" => dec_in <= num(27 downto 24);
--                            AN <= x"FD";
--                when x"7" => dec_in <= num(31 downto 28);
--                            AN <= x"FE";
                when others => dec_in <= num(23 downto 20); --(31 downto 28) for 8 digits
                            AN<=x"FF";
                                
                end case;
                counter <= std_logic_vector(unsigned( counter) +1);
                end if;
                
            end process;
end Behavioral;
