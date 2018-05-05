LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity OUTER_ALU is
    port (
        A, B : in std_logic_vector(23 downto 0);
        ALU_SEL : in std_logic_vector(4 downto 0);
        clk : in std_logic;
        Data_Valid : out std_logic;
        ALU_OUT : out std_logic_vector(23 downto 0);
        Flags : out std_logic_vector(3 downto 0));
end OUTER_ALU;

architecture ALU_COMPUTE of OUTER_ALU is
signal         Result :  std_logic_vector(31 downto 0);
signal         D_Val  :  std_logic;
signal         D_Reset:  std_logic;

begin
ALU : entity work.ALU 
        port map(
                A => A, 
                B=> B,
                Data_Valid => Data_Valid,
                Val_Reset => D_Reset,
                ALU_SEL => ALU_SEL, 
                ALU_OUT => RESULT);
Flag_Register : entity work.Flags_Unit 
        port map(
                ALU_IN => RESULT,
                Valid => D_Val,
                V_Reset =>  D_Reset,
                OP_CODE => ALU_SEL, 
                Flags => Flags, 
                ALU_OUT => ALU_OUT); 

end ALU_COMPUTE;