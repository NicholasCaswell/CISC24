library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Prog_Counter is
    Port ( 
           RESET : in STD_LOGIC;
           INC : in STD_LOGIC;
           LOAD : in STD_LOGIC_VECTOR (8 downto 0);
           LD_EN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (8 downto 0));
end Prog_Counter;

architecture Behavioral of Prog_Counter is
constant zero : integer := 0;
signal Count : unsigned(8 downto 0) := to_unsigned(zero,9); --Count from 0 to 511
begin

process(clk, RESET)
begin
    if(RESET = '1') then            -- Reset to 0
       Count <= "000000000";
    elsif(CLK'event and CLK = '1') then    -- Triggers on Rising Edge
        if(INC = '1') then              -- Increment Count
            Count <= Count + 1;
        end if;
        if(LD_EN = '1') then            -- Load Immediate
            Count <= unsigned(LOAD);
        end if;
   
    end if;
end process;

PC <= std_logic_vector(Count);

end Behavioral;
