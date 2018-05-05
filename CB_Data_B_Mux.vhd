--Control Block Data A Mux
LIBRARY IEEE;
use ieee.std_logic_1164.all;


entity CB_Data_B_Mux is
	port(
		RBnk_A: in std_logic_vector(23 downto 0);
		Result : in std_logic_vector(23 downto 0);
		Pop    : in std_logic_vector(23 downto 0);
		Dmem   : in std_logic_vector(23 downto 0);
		SEL    : in std_logic_vector(2 downto 0);
		Data_Out : out std_logic_vector(23 downto 0));
	end CB_Data_B_Mux;
	
Architecture Dataflow1 of CB_Data_B_Mux is
	begin
		with SEL select
		  Data_Out <=  RBnk_A      when "000",
					   Result      when "001",
					   Dmem        when "010",
					   Pop         when "011",
					   (Data_Out'range => '0') when "100",
					   (others => 'Z')         when others;
end Dataflow1;