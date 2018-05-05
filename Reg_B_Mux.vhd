--Reg_B_Mux

library IEEE;
use ieee.std_logic_1164.all;


entity Reg_B_Mux is 
	port(
		Reg_Bank_B    : in std_logic_vector(23 downto 0);
		Data_Mem      : in std_logic_vector(23 downto 0);
		Immed         : in std_logic_vector(23 downto 0);
		SEL           : in std_logic_vector(1 downto 0);
		OUT_B         : out std_logic_Vector(23 downto 0));
		
	end Reg_B_Mux;
	
	Architecture Dataflow1 of Reg_B_Mux is
		begin
		with SEL select
			OUT_B <= Reg_Bank_B when "00",
					Data_Mem   when "01",
					Immed      when "10",
					Immed      when "11",
					(others => 'Z') when others;
	end Dataflow1;