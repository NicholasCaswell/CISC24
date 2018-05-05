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

use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--------------------------------------------------------------

entity Stack is
generic(	
        width:	integer:=24;
		depth:	integer:=9;
		addr:	integer:=4);
port(	
    Clock  :		in std_logic;	
	Enable :		in std_logic;
	Push   :		in std_logic;
	Pop    :		in std_logic;
	Data_in    :   in std_logic_vector(width-1 downto 0);
	Data_out   :   out std_logic_vector(width-1 downto 0));
end Stack;

--------------------------------------------------------------

architecture behavioral of Stack is

-- use an array to define internal temporary signals

type ram_type is array (0 to depth-1) of 
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type := (8 downto 0 => x"000000");
signal Pointer  :   integer range 0 to 9 := 0; --8 registers plus prog count
signal Tmp_1  :   integer range 0 to 9 := 0; --8 registers plus prog count
signal Tmp_2  :   integer range 0 to 9 := 0; --8 registers plus prog count
begin	
			   
    -- Read Functional Section operates on rising edge
   
--  Pointinc:process(Clock)
--        begin
--        if (Clock'event and Clock='1') then
--            if (Enable = '1') then
--                if (Pop = '1') then
--                    Case Pointer is                           
--                        when 0 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 0; --hold at 0     
--                        when 1 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 0;                 
--                        when 2 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 1;                 
--                        when 3 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 2;                 
--                        when 4 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 3;                 
--                        when 5 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 4;                 
--                        when 6 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 5;                 
--                        when 7 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 6;                 
--                        when 8 =>                         
--                            Data_out <= tmp_ram(Pointer); 
--                            pointer <= 7;                 
--                        when others =>                    
--                            pointer <= 0;                 
--                   end case;                              
--                end if;
--            end if;
--        end if;
--    end process;
--        tmp <= pointer;

--        Pointdec:process(Clock)
--                begin
--                if (Clock'event and Clock='0') then
--                    if (Enable = '1') then
--                       if (Push = '1') then
--                        Case Pointer is                      
--                           when 0 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 1; --hold at 0    
--                           when 1 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 2;                
--                           when 2 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 3;                
--                           when 3 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 4;                
--                           when 4 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 5;                
--                           when 5 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 6;                
--                           when 6 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 7;                
--                           when 7 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 8;                
--                           when 8 =>                        
--                               tmp_ram(Pointer) <= Data_in; 
--                               pointer <= 8;                
--                           when others =>                   
--                               pointer <= 8;                
--                       end case;                              
--                       end if;
--                    end if; 
                   
--                end if;
--                end process;
    
 PO:process(Clock)
    begin
	if (Clock'event and Clock='1') then
	   if (Enable = '1') then
	       if (Pop = '1') then
	           tmp_1 <= pointer;
	           Case Pointer is                    
                    when 0 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 0; --hold at 0
                    when 1 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 0;
                    when 2 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 1;
                    when 3 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 2;
                    when 4 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 3;
                    when 5 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 4;
                    when 6 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 5;
                    when 7 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 6;
                    when 8 =>
                        Data_out <= tmp_ram(tmp_1);
                        tmp_1 <= 7;
                    when others =>
                        tmp_1 <= 0;
               end case;
	       else
		       Data_out <= (Data_out'range => 'Z');
		   end if;
	   end if;
	end if;
	end process;
	
PU:process(clock)
	begin
	if (Clock'event and Clock='0') then
        if (Enable = '1') then
            if (Push = '1') then
                Tmp_2 <= pointer;
                Case Pointer is                    
                    when 0 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 1; --hold at 0
                    when 1 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 2;
                    when 2 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 3;
                    when 3 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 4;
                    when 4 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 5;
                    when 5 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 6;
                    when 6 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 7;
                    when 7 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 8;
                    when 8 =>
                        tmp_ram(Tmp_2) <= Data_in;
                        Tmp_2 <= 8;
                    when others =>
                        Tmp_2 <= 8;
               end case;
            end if;
        end if;
    end if;
    end process;

end behavioral;