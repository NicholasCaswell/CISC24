--PMemDataMux_Real

library IEEE;
use ieee.std_logic_1164.all;

entity PMem_Data_Mux is
	port(
		key_board_input : in std_logic_vector(23 downto 0);
		ext_mem : in std_logic_vector(23 downto 0);
		SEL : in std_logic;
		Data_In : out std_logic_vector(23 downto 0));
		
end PMem_Data_Mux;

Architecture DataFlow1 of PMem_Data_Mux is
begin
with SEL select
	Data_In <= key_board_input when '0',
			   ext_mem when '1',
			   (others => 'Z') when others;
end DataFlow1;

