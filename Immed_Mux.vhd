--Reg_A_Mux

library IEEE;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity Immed_Mux is 
	port(
	    Immed19   : in std_logic_vector(18 downto 0);
		Immed15   : in std_logic_vector(14 downto 0);
		Immed14   : in std_logic_vector(13 downto 0);
		Immed9    : in std_logic_vector(8 downto 0);
		SEL       : in std_logic_vector(1 downto 0);
		OUT_IMM   : out std_logic_vector(23 downto 0));
		end Immed_Mux;
		
	Architecture Dataflow1 of Immed_Mux is
	begin
	with SEL select
		OUT_IMM <=    "00000" & Immed19 when "00", 
		              "0000000000" & Immed14(13 downto 0) when "01",
		              "000000000000000" & Immed9 when "10",
		              "000000000" & Immed15 when "11",
				      (others => 'Z') when others;
				
	end Dataflow1;
	
	
		