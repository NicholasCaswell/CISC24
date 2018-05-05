
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PMem_Addr_Mux is 
	port(
		PC        : in std_logic_vector(8 downto 0);
		IIR_18to0 : in std_logic_vector(18 downto 0);
		IIR_7to0  : in std_logic_vector(8 downto 0);
		Pop       : in std_logic_vector(23 downto 0);
		SEL       : in std_logic_vector(2 downto 0);
		OFFSET : in std_logic_vector(8 downto 0);
		Addr      : out std_logic_vector(8 downto 0));
		end PMem_Addr_Mux;
		
	Architecture Dataflow1 of PMem_Addr_Mux is
	begin
	with SEL select
		Addr <= PC                when "000",
		        IIR_18to0(8 downto 0)         when "001",
		        (PC) + ('0' & IIR_7to0(7 downto 0)) when "010",
		        Pop(8 downto 0)   when "011",
		        std_logic_vector(PC + OFFSET) when "100",
				(others => 'Z')   when others;
				
	end Dataflow1;
	