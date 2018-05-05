--Reg_A_Mux

library IEEE;
use ieee.std_logic_1164.all;

entity Reg_A_Mux is 
	port(
	    Reg_Bank_A     : in std_logic_vector(23 downto 0);
			Data_Mem      : in std_logic_vector(23 downto 0);
            Immed         : in std_logic_vector(23 downto 0);
            SEL           : in std_logic_vector(1 downto 0);
            OUT_A         : out std_logic_Vector(23 downto 0));
            
        end Reg_A_Mux;
        
        Architecture Dataflow1 of Reg_A_Mux is
            begin
            with SEL select
                OUT_A <= Reg_Bank_A when "00",
                         Data_Mem   when "01",
                         Immed      when "10",
                         Immed      when "11",
                         (others => 'Z') when others;
        end Dataflow1;
	
	
		