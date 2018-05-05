--Control Block Data A Mux
LIBRARY IEEE;
use ieee.std_logic_1164.all;


entity Stack_Mux is
	port(
		PC : in std_logic_vector(8 downto 0);
		RBnk_A : in std_logic_vector(23 downto 0);
		SEL    : in std_logic;
		Data_Out : out std_logic_vector(23 downto 0));
	end Stack_Mux;
	
Architecture Dataflow1 of Stack_Mux is
	begin
		with SEL select
		  Data_Out <=  "000000000000000" & PC   when '0',
					   RBnk_A                  when '1',
					   (others => 'Z')         when others;
end Dataflow1;