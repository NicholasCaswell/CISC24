--Data_Mem_Data_Mux

library IEEE;
use ieee.std_logic_1164.all;

entity DMem_Data_Mux_A is
	port(
		Result : in std_logic_vector(23 downto 0);
		Reg_Bank_A : in std_logic_vector(23 downto 0);
		Ext_Mem_In : in std_logic_vector(23 downto 0);
		Mem_out : in std_logic_vector(23 downto 0);
		SEL : in std_logic_vector(2 downto 0);
		Data_In : out std_logic_vector(23 downto 0));
	end DMem_Data_Mux_A;
	
	Architecture Dataflow1 of DMem_Data_Mux_A is
	begin
	with SEL select
		Data_In <= Result when "000",
				   Reg_Bank_A when "001",
				   MEM_OUT when "010",
				   Ext_Mem_In when "011",
				   (Data_In'range => '0') when "100",
				   (others => 'Z') when others;
    end Dataflow1;