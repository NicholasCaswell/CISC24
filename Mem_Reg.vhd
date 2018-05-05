library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mem_Reg_A is
    Port ( 
           DATA_IN : in STD_LOGIC_VECTOR (23 downto 0);
           LATCH : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DATA_OUT : out STD_LOGIC_VECTOR (23 downto 0));
end Mem_Reg_A;

architecture Behavioral of Mem_Reg_A is
signal mem : std_logic_vector(23 downto 0);
begin

DATA_OUT <= mem;

process(CLK)
begin
if(CLK'event and CLK = '0' and LATCH = '1') then
    mem <= DATA_IN;
end if;
end process;
end Behavioral;
