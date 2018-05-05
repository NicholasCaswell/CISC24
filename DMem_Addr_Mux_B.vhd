
library IEEE;
use ieee.std_logic_1164.all;

entity DMem_Addr_Mux_B is 
	port(
		Reg_Bank  : in std_logic_vector(23 downto 0);
		IIR_18to9 : in std_logic_vector(18 downto 9);
		IIR_13to0   : in std_logic_vector(13 downto 0);
		IIR_8to0   : in std_logic_vector(8 downto 0);
		SEL       : in std_logic_vector(1 downto 0);
		Addr      : out std_logic_vector(8 downto 0));
		end DMem_Addr_Mux_B;
		
	Architecture Dataflow1 of DMem_Addr_Mux_B is
	begin
	with SEL select
		Addr <= Reg_Bank(8 downto 0)     when "00",
		        IIR_18to9(17 downto 9) when "01",
		        IIR_13to0(8 downto 0) when "10",
		        IIR_8to0  when "11",
				(others => 'Z') when others;
				
	end Dataflow1;
	