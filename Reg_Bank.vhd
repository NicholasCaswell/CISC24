--------------------------------------------------------------
-- A simple 8*8 RAM module with dual read and single write
-- operates on opposing edges
-- 
-- by Dr Fortier
-- 
-- KEYWORD: array, concurrent processes, generic, conv_integer 
--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity Reg_Bank is
generic(	
        width:	integer:=24;
		depth:	integer:=8;
		addr:	integer:=3);
port(	
    Clock  :		in std_logic;	
	Enable :		in std_logic;
	Read_a :		in std_logic;
	Write_a:		in std_logic;
	Read_b :		in std_logic;
    Write_b:        in std_logic;
    incA   :        in std_logic;
    incB   :        in std_logic;
	AddrA  :	in std_logic_vector(addr-1 downto 0);
	AddrB  :	in std_logic_vector(addr-1 downto 0);
	Data_inA   :   in std_logic_vector(width-1 downto 0);
	Data_inB   :   in std_logic_vector(width-1 downto 0);
	Data_outA  :   out std_logic_vector(width-1 downto 0);
	Data_outB  :   out std_logic_vector(width-1 downto 0)
);
end Reg_Bank;

--------------------------------------------------------------

architecture behavioral of Reg_Bank is

-- use an array to define internal temporary signals

type ram_type is array (0 to depth-1) of 
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type := (0 => x"000000", 
                             1 => x"000001", 
                             2 => x"000002", 
                             3 => x"000003", 
                             4 => x"000004", 
                             5 => x"000005", 
                             6 => x"000006", 
                             7 => x"000007");

begin	
			   
    -- Read Functional Section operates on rising edge
    process(Clock, Read_a, Read_b)
    begin
	if (Clock='1') then
	    if (Enable = '1') then
		if (Read_a = '1') then
		    -- built in function conv_integer change the type
		    -- from std_logic_vector to integer
		    Data_outA <= tmp_ram(conv_integer(AddrA));  
		else
		    Data_outA <= (Data_outA'range => 'Z');
		end if;
		if (Read_b = '1') then
            -- built in function conv_integer change the type
            -- from std_logic_vector to integer 
            Data_outB <= tmp_ram(conv_integer(AddrB)); 
        else
            Data_outB <= (Data_outB'range => 'Z');
        end if;
	    end if;
	end if;
    end process;
	
    -- Write Functional Section operate on falling edge
    process(Clock, Write_a, Write_b, IncA, IncB)
    begin
	if (Clock='0') then
	    if (Enable = '1') then
		if (Write_a = '1') then
		    tmp_ram(conv_integer(AddrA)) <= Data_inA;
		end if;
		if Write_b = '1' then
            tmp_ram(conv_integer(AddrB)) <= Data_inB;
        end if;
	    end if;
	    if(IncA = '1') then
	       tmp_ram(conv_integer(AddrA)) <= std_logic_vector(signed(tmp_ram(conv_integer(AddrA)) + 1));
	    end if;
	    if(IncB = '1') then
            tmp_ram(conv_integer(AddrB)) <= std_logic_vector(signed(tmp_ram(conv_integer(AddrB)) + 1));
        end if;
	end if;
    end process;

end behavioral;
----------------------------------------------------------------
