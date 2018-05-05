library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU is
    Port (
        A :  in  STD_LOGIC_VECTOR(23 downto 0);  -- 1 inputs 32 Bit
        B : in  STD_LOGIC_VECTOR(23 downto 0);  -- 1 inputs 32 Bit
        Data_Valid : out std_logic := '0';
        Val_Reset : in STD_LOGIC;
        ALU_Sel  : in  STD_LOGIC_VECTOR(4 downto 0);  -- OPCODE
        ALU_Out   : out  STD_LOGIC_VECTOR(31 downto 0) -- 1 output 32-bit 
    );
end ALU; 


--Architecture Dataflow1 of ALU is
--signal FA : std_logic_vector(31 downto 0);
--signal FB : std_logic_vector(31 downto 0);
--begin

--FA <= ("00000000" & A);
--FB <= ("00000000" & B);
--    with ALU_Sel select 
--       ALU_Out <= FA + FB when "10000",
--                  FA + FB when "10111", --ADDI
--                  FA - FB when "10001",
--                  FA - FB when "11000", --SUBI
--                  std_logic_vector(to_signed((to_integer(unsigned(FA)) * to_integer(unsigned(FB))),32)) when "10010",
--                  std_logic_vector(to_signed(to_integer(unsigned(FA)) / to_integer(unsigned(FB)),32)) when "10011",
--                  std_logic_vector(unsigned(FA) sll to_integer(unsigned(FB(13 downto 9)))) when "01000",
--                  std_logic_vector(unsigned(FA) srl to_integer(unsigned(FB(13 downto 9)))) when "01001",
--                  FA and FB when "10100",
--                  FA or FB when "10101",
--                  FA xor FB when "10110",
--                  std_logic_vector(not FA) when "00111",
--                  FA + "00000000000000000000000000000001" when "00101",
--                  FA - "00000000000000000000000000000001" when "00110",
--                 (others => 'Z') when others;
----   with ALU_OUT select
----    Data_Valid <= '0' when 'Z',
----                   (others => '1') when others;
-- end Dataflow1;
 
 Architecture Behavioural of ALU is
 signal FA : std_logic_vector(31 downto 0);
 signal FB : std_logic_vector(31 downto 0);
 signal Dvalid : std_logic;
 begin
 FA <= ("00000000" & A);
 FB <= ("00000000" & B);
Data_Valid <= Dvalid;
 
 process(FA, FB, ALU_Sel)
 begin
     if(val_Reset = '1') then
         Dvalid <= '0';
    else
     CASE ALU_Sel is
        when "00100" =>
            ALU_Out <= x"00000000";
            Dvalid <= '1';
            
        when "10000"=>
            ALU_Out <= FA + FB;
            Dvalid <= '1';
        when"10111" =>
            ALU_Out <= FA + FB; --ADDI
            Dvalid <= '1';
       when "10001" =>
            ALU_Out <= FA - FB; 
            Dvalid <= '1';
       when "11000" =>
            ALU_Out <= FA - FB; --SUBI
            Dvalid <= '1';
       when "10010" =>
            ALU_Out <= std_logic_vector(to_signed((to_integer(unsigned(FA)) * to_integer(unsigned(FB))),32));
            Dvalid <= '1';
       when "10011" =>
            ALU_Out <= std_logic_vector(to_signed(to_integer(unsigned(FA)) / to_integer(unsigned(FB)),32));
            Dvalid <= '1';
       when "01000" =>
            ALU_Out <= std_logic_vector(unsigned(FA) sll to_integer(unsigned(FB(13 downto 9)))); 
            Dvalid <= '1';
       when "01001" =>
            ALU_Out <= std_logic_vector(unsigned(FA) srl to_integer(unsigned(FB(13 downto 9))));
            Dvalid <= '1';
       when "10100" => 
            ALU_Out <= FA and FB; 
            Dvalid <= '1';
       when "10101" =>
            ALU_Out <= FA or FB;
            Dvalid <= '1';
       when "10110" =>
            ALU_Out <= FA xor FB;
            Dvalid <= '1';
       when "00111" =>
            ALU_Out <= std_logic_vector(not FA);
            Dvalid <= '1';
       when "00101" => 
            ALU_Out <= FA + "00000000000000000000000000000001";
            Dvalid <= '1';
       when "00110" =>
            ALU_Out <= FA - "00000000000000000000000000000001";
            Dvalid <= '1';
       when others =>
            ALU_Out <= (others => 'Z');
            Dvalid <= '0';
        end CASE;
     end if;
   end process;
end Behavioural;