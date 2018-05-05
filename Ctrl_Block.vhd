----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2018 11:36:09 AM
-- Design Name: 
-- Module Name: Ctrl_Block - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ctrl_Block is
    Port ( 
---------------------------------------INPUTS
           CLK      : in STD_LOGIC;
           RST      : in STD_LOGIC;
           VALID    : in STD_LOGIC;
           FLAGS    : in STD_LOGIC_VECTOR(3 downto 0);
           OPCODE   : in STD_LOGIC_VECTOR(4 downto 0);
           AMA      : in STD_LOGIC_VECTOR(1 downto 0);
--           SRCA     : in STD_LOGIC_VECTOR(2 downto 0);
           AMB      : in STD_LOGIC_VECTOR(1 downto 0);
           SRCB     : in STD_LOGIC_VECTOR(2 downto 0);
           MASK     : in STD_LOGIC_VECTOR(3 downto 0);
--           IMM19    : in STD_LOGIC_VECTOR(18 downto 0);
--           IMM15    : in STD_LOGIC_VECTOR(14 downto 0);
           IMM14    : in STD_LOGIC_VECTOR(13 downto 0);
--           IMM9     : in STD_LOGIC_VECTOR(8 downto 0);

  -------------------------------------OUTPUTS
           ------------MUX SELECT CONTROLS
           SEL_PMEM_ADDR    : out STD_LOGIC_VECTOR(2 downto 0)  := "000";
           SEL_PMEM_DATA    : out STD_LOGIC_VECTOR(1 downto 0)  := "00";
           SEL_DMEM_ADDR_A  : out STD_LOGIC_VECTOR(1 downto 0)  := "00";
           SEL_DMEM_DATA_A  : out STD_LOGIC_VECTOR(2 downto 0)  := "000";
           SEL_DMEM_ADDR_B  : out STD_LOGIC_VECTOR(1 downto 0)  := "00";
           SEL_DMEM_DATA_B  : out STD_LOGIC_VECTOR(2 downto 0)  := "000";
           SEL_CTRL_DATA_A  : out STD_LOGIC_vector(2 downto 0)  := "000";
           SEL_CTRL_DATA_B  : out STD_LOGIC_VECTOR(2 downto 0)  := "000";
           SEL_IMMED        : out STD_LOGIC_VECTOR(1 downto 0)  := "00";
           SEL_REG_A        : out STD_LOGIC_VECTOR(1 downto 0)  := "00";    --1 downto 0 
           SEL_REG_B        : out STD_LOGIC_VECTOR(1 downto 0)  := "00";    --1 downto 0 
           SEL_Stack        : out STD_LOGIC := '0';
           
           ------------R/W ENABLE CONTROLS
           R_PMEM   : out STD_LOGIC := '0';
           W_PMEM   : out STD_LOGIC := '0';
           R_DMEM_A : out STD_LOGIC := '0';
           W_DMEM_A : out STD_LOGIC := '0';
           R_DMEM_B : out STD_LOGIC := '0';
           W_DMEM_B : out STD_LOGIC := '0';
           R_RBNK_A : out STD_LOGIC := '0';
           W_RBNK_A : out STD_LOGIC := '0';
           R_RBNK_B : out STD_LOGIC := '0';
           W_RBNK_B : out STD_LOGIC := '0';
           R_STACK  : out STD_LOGIC := '0';
           W_STACK  : out STD_LOGIC := '0';
           RBank_EN : out STD_LOGIC := '0';
           Stack_EN : out STD_LOGIC := '0';
           
           ------------REGISTER BANK INCREMENT CONTROLS
           INC_RB_A : out STD_LOGIC := '0';
           INC_RB_B : out STD_LOGIC := '0';
           
           ------------REGISTER LATCH CONTROLS
           LATCH_INST   : out STD_LOGIC := '0';
           LATCH_OPCODE : out STD_LOGIC := '0';
           LATCH_A      : out STD_LOGIC := '0';
           LATCH_B      : out STD_LOGIC := '0';
           LATCH_RSLT   : out STD_LOGIC := '0';
           LATCH_FLG    : out STD_LOGIC := '0';
           LATCH_MEM_A  : out STD_LOGIC := '0';
           LATCH_MEM_B  : out STD_LOGIC := '0';
           
           -----------PROGRAM COUNTER CONTROLS
           PC_RESET     : out STD_LOGIC := '0';
           PC_INC       : out STD_LOGIC := '0';
           PC_LOAD_EN   : out STD_LOGIC := '0';
           
           -----------STATE/DEBUG
           STATE       : out STD_LOGIC_VECTOR(3 downto 0));
           
end Ctrl_Block;

architecture Behavioral of Ctrl_Block is

TYPE STATE_TYPE IS (FETCH, DECODE, OPERAND, EXEC_ALU, WRITE, EXEC_OFFSET, MEM_READ, WRITE_REG, SPECIAL, JUMP, BLOCKMM);
SIGNAL CURRENT_STATE : STATE_TYPE := FETCH; 
SIGNAL NEXT_STATE : STATE_TYPE;
signal format   : STD_LOGIC_VECTOR(2 downto 0);
signal mvm   : STD_LOGIC_VECTOR(1 downto 0);
signal halt : STD_LOGIC_VECTOR(0 downto 0);
signal am_A_en : STD_LOGIC_VECTOR(0 downto 0);
signal am_B_en : STD_LOGIC_VECTOR(0 downto 0);
signal ZERO : INTEGER := 0;
signal Zero1 : INTEGER := 0;
signal Zero2 : INTEGER := 0;
signal IMM14temp : STD_LOGIC_VECTOR(13 DOWNTO 0) := IMM14;
signal x : STD_LOGIC_VECTOR(13 DOWNTO 0) := IMM14;

BEGIN

format <= "000" when (OPCODE = "00000" or OPCODE = "00001" or OPCODE = "00010" or OPCODE = "00011" or OPCODE = "01011" or OPCODE = "11011" or OPCODE = "11101" or OPCODE = "11110" or OPCODE = "11111") else
          "001" when (OPCODE = "00100" or OPCODE = "00101" or OPCODE = "00110" or OPCODE = "00111" or OPCODE = "01000" or OPCODE = "01001" or OPCODE = "01110" or OPCODE = "01111" or OPCODE = "10111" or OPCODE = "11000") else
          "010" when (OPCODE = "01010" or OPCODE = "01100" or OPCODE = "01101" or OPCODE = "10000" or OPCODE = "10001" or OPCODE = "10010" or OPCODE = "10011" or OPCODE = "10100" or OPCODE = "10101" or OPCODE = "10110") else
          "011" when (OPCODE = "11100") else 
          "100" when (OPCODE = "11001" or OPCODE = "11010") else
          "ZZZ";

halt <= "1" when (OPCODE = "00000") else 
         "0";

mvm <= "01" when (OPCODE = "01010" or OPCODE = "01011" or OPCODE = "01100" or OPCODE = "01101") else 
       "11" when (OPCODE = "00000" or OPCODE = "00001" or OPCODE = "00010" or OPCODE = "11101" or OPCODE = "11110" or OPCODE = "11100") else
       "00" when (OPCODE = "11001" or OPCODE = "11010" or OPCODE = "11011") else
       "10";    --01 = Memory  --10 = ALU  --11 = Special

-- missing Lab2 insrtuctions
am_A_en <= "1" when (OPCODE = "00100" or OPCODE = "00101" or OPCODE = "00110" or OPCODE = "00111" or OPCODE = "01000" or OPCODE = "01001" or OPCODE = "01010" or OPCODE = "01100" or OPCODE = "01101" or OPCODE = "10000" or OPCODE = "10001" or OPCODE = "10010" or OPCODE = "10011" or OPCODE = "10100" or OPCODE = "10101" or OPCODE = "10110" or OPCODE = "10111" or OPCODE = "11000") else 
            "0";
-- missing Lab2 insrtuctions
am_B_en <= "1" when (OPCODE = "01010" or OPCODE = "10000" or OPCODE = "10001" or OPCODE = "10010" or OPCODE = "10011" or OPCODE = "10100" or OPCODE = "10101" or OPCODE = "10110") else 
            "0";

STATE <=   "0000" when CURRENT_STATE = FETCH else
           "0001" when CURRENT_STATE = DECODE else
           "0010" when CURRENT_STATE = OPERAND else
           "0011" when CURRENT_STATE = EXEC_ALU else
           "0100" when CURRENT_STATE = WRITE else
           "0101" when CURRENT_STATE = EXEC_OFFSET else
           "0110" when CURRENT_STATE = MEM_READ else
           "0111" when CURRENT_STATE = WRITE_REG else
           "1000" when CURRENT_STATE = SPECIAL else
           "1001" when CURRENT_STATE = JUMP else
           "1010" when CURRENT_STATE = BLOCKMM else
           "ZZZZ";
        
        -- Process to hold combinational logic.
        FSM: PROCESS(RST, CURRENT_STATE, VALID, FLAGS, mvm, format)
        BEGIN
            CASE CURRENT_STATE IS
            
                WHEN FETCH =>
                    PC_RESET    <= RST;
                    PC_INC      <= '0';
                    PC_LOAD_EN  <= '0';
                    INC_RB_A <= AMA(1) and am_A_en(0);
                    INC_RB_B <= AMB(1) and am_B_en(0);
                    SEL_PMEM_ADDR <= "000";
                    R_DMEM_A <= '0';     --set indirect A enable 0
                    W_DMEM_A <= '0';     --set indirect A write enable 0
                    R_DMEM_B <= '0';     --set indirect B enable 0
                    W_DMEM_B <= '0';     --set indirect B write enable 0
                    R_RBNK_A <= '0';     --set direct A enable 0
                    W_RBNK_A <= '0';     --set direct A write enable 0
                    R_RBNK_B <= '0';     --set direct B enable 0
                    W_RBNK_B <= '0';     --set direct B write enable 0
                    R_PMEM <= '1';       --set pmem enable to 1
                    W_PMEM <= '0';       --set pmem write en to 0
                    LATCH_INST <= '1';   --set inst reg latch to 1
                    LATCH_RSLT <= '0';      --set latch result to 0
                    LATCH_FLG  <= '0';  --set latch flags to '0'
                    LATCH_OPCODE <= '0';
                    PC_INC <= '0';
                    W_STACK <= '0';
                    R_STACK <= '0';
                    ZERO <= 0;
                    IMM14TEMP <= "00000000000000";
                    X <= "00000000000000";
                    SEL_CTRL_DATA_A <= "000";
                    SEL_CTRL_DATA_B <= "000";
                    
                    NEXT_STATE <= DECODE;--Next State
                    
                WHEN DECODE =>
                    INC_RB_A <= '0';     --set increment A PC to '0'
                    INC_RB_B <= '0';     --set increment B PC to '0'
                    LATCH_INST <= '0';      --set inst reg latch to 0
                    SEL_CTRL_DATA_A <= "000";    --set reg a select
                    SEL_CTRL_DATA_B <= "000";   --set reg b select
                    SEL_DMEM_ADDR_A <= "00";    --set dmem addr A select
                    SEL_DMEM_ADDR_B <= "00";    --set dmem addr A select
                    SEL_IMMED <= format(1 downto 0);--set immed select
                    if(am_A_en = "1") then
                        SEL_REG_A <= ('0' & AMA(0));        --set regbank a select
                        R_RBNK_A <= AMA(0);     --set direct A enable ama
                    else
                        SEL_REG_A <= "00";        --set regbank a select
                    end if;
                    if(am_B_en = "1") then
                        SEL_REG_B <= format(0) & AMB(0); --set regbank b select
                        R_RBNK_B <= AMB(0);     --set direct A enable AMB
                    else
                        SEL_REG_B <= format (0) & '0';      --set regbank b select
                    end if;
                    SEL_DMEM_DATA_A <= "000";    --set dmem data A selct
                    SEL_DMEM_DATA_B <= "000";    --set dmem data B selct
                    SEL_PMEM_ADDR <= "000";     --set pmem addr select
                    SEL_PMEM_DATA <= "00";      --set pmem data select
                    
                    if (mvm = "01") then        --Next State
                        NEXT_STATE <= EXEC_OFFSET;
                    elsif(mvm = "10") then
                        NEXT_STATE <= OPERAND;
                    elsif(mvm = "00") then
                        NEXT_STATE <= JUMP;
                    elsif(mvm = "11") then
                        NEXT_STATE <= SPECIAL;
                    else 
                        NEXT_STATE <= FETCH;
                    end if;
                    
            ----------------------------------------------- ALU Operation
                WHEN OPERAND =>
                    RBank_EN <= '1';    --set regbank enable '1'
                    R_RBNK_A <= '1';    --set regbank a read '1'
                    R_RBNK_B <= '1';    --set regbank b read '1'
                    R_DMEM_A <= '1';    --set dmem A read '1'
                    R_DMEM_B <= '1';    --set dmem B read '1'
                    LATCH_A <= '1';     --set Latch Reg A to '1'
                    LATCH_B <= '1';     --set Latch Reg B to '1'
                    LATCH_OPCODE <= '1';
                    NEXT_STATE <= EXEC_ALU;
                    
                WHEN EXEC_ALU =>                    --Done
                    RBank_EN <= '0';    --set regbank enable '10'
                    R_RBNK_A <= '0';    --set regbank a read '0'
                    R_RBNK_B <= '0';    --set regbank b read '0'
                    R_DMEM_A <= '0';    --set dmem A read '0'
                    R_DMEM_B <= '0';    --set dmem B read '0'
                    LATCH_A <= '0';     --set Latch Reg A to '0'
                    LATCH_B <= '0';     --set Latch Reg B to '0'
                    LATCH_FLG  <= '1';  --set latch flags to '0'
                    if(valid = '0') then
                        NEXT_STATE <= EXEC_ALU;
                    elsif(valid = '1') then
                        PC_INC <= '1';      --set increment PC to '1'
                        LATCH_RSLT <= '1';  --set latch result to '1'
                        NEXT_STATE <= WRITE;
                    end if;
                    
                WHEN WRITE =>               --Needs Select Line Logic
                    LATCH_FLG  <= '0';  --set latch flags to '0'
                    PC_INC <= '0';          --set increment PC to 0
                    --LATCH_RSLT <= '0';      --set latch result to 0
                    SEL_CTRL_DATA_A <= "001";
                    SEL_DMEM_ADDR_A <= "00";
                    SEL_DMEM_DATA_A <= "000";    --set set mem data select
                    RBank_EN <= '1';    --set regbank enable to '1'
                    R_RBNK_A <= '1';    --set regbank A read to '1'
                    R_RBNK_B <= '1';    --set regbank B read to '1'
                    R_DMEM_A <= '1';    --set dmem A enable to '1'
                    R_DMEM_B <= '1';    --set dmem B enable to '1'
                    
                    if(AM_A_en = "1") then
                        W_RBNK_A <= not AMA(0);     --set regbank a write '1'
                        W_DMEM_A <= AMA(0);         --set dmem A write '0'
                    else
                        W_RBNK_A <= '1';            --set regbank a write '1'
                        W_DMEM_A <= '0';            --set dmem A write '0'
                    end if;
                    NEXT_STATE <= FETCH;
                    
                    ----------------------------------------------- Data Movement
                WHEN EXEC_OFFSET =>
                    RBank_EN <= '1';    --set regbank enable '1'
                    R_RBNK_A <= '1';    --set regbank a read '1'
                    R_RBNK_B <= '1';    --set regbank b read '1'
                    LATCH_RSLT <= '0';
                    case(OPCODE) is
                        when "01010" => --MVS
                              SEL_CTRL_DATA_A <= '0' & AMA(0) & '0';
                              SEL_CTRL_DATA_B <= '0' & AMB(0) & '0';
                              SEL_DMEM_DATA_B <= '0' & AMB(0) & not AMB(0);
                              SEL_DMEM_DATA_A <= '0' & AMA(0) & not AMA(0);
                        when "01011" => --MVMI
                              SEL_CTRL_DATA_A <= "010";
                              SEL_CTRL_DATA_B <= "010";
                              SEL_DMEM_DATA_B <= "010";
                              SEL_DMEM_DATA_A <= "010";
                        when "01100" => --MSM
                              SEL_CTRL_DATA_A <= '0' & AMA(0) & '0';
                              SEL_CTRL_DATA_B <= "010";
                              SEL_DMEM_DATA_B <= "010";
                              SEL_DMEM_DATA_A <= '0' & AMA(0) & not AMA(0);
                        when "01101" => --MMS
                              SEL_CTRL_DATA_A <= '0' & AMA(0) & '0';
                              SEL_CTRL_DATA_B <= "010";
                              SEL_DMEM_DATA_B <= "010";
                              SEL_DMEM_DATA_A <= '0' & AMA(0) & not AMA(0);
                        when "00100" => --CLR
                              SEL_CTRL_DATA_A <= "100";
                              SEL_DMEM_DATA_A <= "100";
                        when others =>
                            --nothing
                    end case;
                    PC_INC <= '1';      --set increment PC to '1'
                    NEXT_STATE <= MEM_READ;
                    
                WHEN MEM_READ =>
                    PC_INC <= '0';      --set increment PC to '0'
                    R_DMEM_A <= '1';    --set dmem A read '1'
                    R_DMEM_B <= '1';    --set dmem B read '1'
                    LATCH_MEM_A <= '1';     --set Latch Reg A to '1'
                    LATCH_MEM_B <= '1';     --set Latch Reg B to '1' 
                    case OPCODE is          --set target mem select lines
--                        when "00100" =>  --CLR
--                            SEL_CTRL_DATA_A <= "100";
--                            SEL_DMEM_DATA_A <= "100";
                        when "01010" => --MVS
                            SEL_DMEM_ADDR_A <= "00";
                            R_RBNK_A <= not AMA(0);
                            R_DMEM_A <= AMA(0);
                        when "01011" => --MVMI
                            SEL_DMEM_ADDR_A <= "01";
                            SEL_DMEM_ADDR_B <= "11";
                            R_DMEM_A <= '1';
                        when "01100" => --MSM
                            R_RBNK_A <= not AMA(0);
                            SEL_DMEM_ADDR_A <= "00";    --reg bank
                            R_DMEM_A <= AMA(0);
                            SEL_DMEM_ADDR_B <= "10";    --Immed14(8 to 0)
                        when "01101" => --MMS
                            SEL_DMEM_ADDR_A <= "00";    --reg bank
                            SEL_DMEM_ADDR_B <= "10";    --Immed14(8 to 0)
                            R_DMEM_B <= '1';
                        when "01110" => 
                            --set reg 0 to 7
                            --regbankB location 0-7 read comes from decoder
                            R_RBNK_B <= '1';
                        WHEN "01111" =>
                            -- set dmem 0 to 7
                            -- dmem B location (x) to (x+7) read comes from decoder
                            -- x = Immediate 13 downto 0
                            R_DMEM_B <= '1';
                        when others =>                  
                    end case;
                    NEXT_STATE <= WRITE_REG;
                    
                WHEN WRITE_REG =>
                    LATCH_MEM_A <= '0';     --set Latch Reg A to '0'
                    LATCH_MEM_B <= '0';     --set Latch Reg B to '0'
                    SEL_CTRL_DATA_A <= "000";
                    SEL_CTRL_DATA_B <= "000";
                    case OPCODE is--set target mem write to '1'
--                        when "00100" =>  --CLR
--                            W_RBNK_A <= not AMA(0);
--                            W_DMEM_A <= AMA(0);
                        when "01010" => --MVS
                            W_RBNK_B <= not AMB(0);
                            W_DMEM_B <= AMB(0);
                        when "01011" => --MVMI
                            SEL_DMEM_ADDR_B <= "11";
                            W_DMEM_B <= '1';
                        when "01100" => --MSM
                            SEL_DMEM_ADDR_B <= "10";
                            W_DMEM_B <= '1';
                        when "01101" => --MSM
--                            SEL_CTRL_DATA_A <= '0' & AMA(0) & '0';
                            W_RBNK_A <= not AMB(0);
                            W_DMEM_A <= AMB(0);
                        when "01110" =>
                             SEL_DMEM_ADDR_B <= "10";
                             W_DMEM_B <= '1';
                             IMM14TEMP <= IMM14TEMP + "00000000000001";
                        when "01111" => 
                             INC_RB_B <= '1';
                             W_RBNK_B <= '1';
                             SEL_REG_B <= "01";
                        when others =>
                    end case;
--                    INC_RB_A <= AMA(1) and am_A_en(0);
--                    INC_RB_B <= AMB(1) and am_B_en(0);
                    NEXT_STATE <= FETCH;
                
                WHEN SPECIAL =>             -- For Control Opcodes
                        case OPCODE is -- control instructions case
                            when "00000" =>
                                --disable interrupts
                                pc_inc <= '0';
                                NEXT_STATE <= SPECIAL;
                            when "00001" =>
                                pc_inc <= '0';
                                NEXT_STATE <= SPECIAL;
                            when "11111" =>
                                LATCH_OPCODE <= '1';
                                PC_INC <= '1';
                                NEXT_STATE <= FETCH;
                            when "00010" => --Reset, test tomorrow
                                LATCH_OPCODE <= '1'; --needs to be accounted for all registers. Talk to Alex. 
                                PC_INC <= '0';
                                RBank_EN <= '0';    --set regbank enable '10'
                                R_RBNK_A <= '0';    --set regbank a read '0'
                                R_RBNK_B <= '0';    --set regbank b read '0'
                                R_DMEM_A <= '0';    --set dmem A read '0'
                                R_DMEM_B <= '0';    --set dmem B read '0'
                                LATCH_A <= '0';     --set Latch Reg A to '0'
                                LATCH_B <= '0';     --set Latch Reg B to '0'
                                NEXT_STATE <= FETCH;
                                --disable interrupts
                            when "11100" => --4/23 CHANGES BR MASK
                                --if mask = Flags, go to PC+OFFSET
                                if(MASK = FLAGS) then --POSSIBLY MORE CONTROLS TO SET
                                    PC_INC <= '0';
                                    SEL_PMEM_ADDR <= "100";
                                    PC_LOAD_EN <= '1';
                                    NEXT_STATE <= SPECIAL;
                                else
                                    PC_INC <= '1';
                                    NEXT_STATE <= FETCH;
                                end if;
                            when "11101" => --INTTL
                            --interrupts
                            --CALL USE OF INTTL COMPONENT
                            --push
                            SEL_Stack <= '0';
                            W_STACK <= '1';
                            SEL_PMEM_ADDR <= "100";
                            PC_INC <= '1';
                            NEXT_STATE <= FETCH;
                            
                            when "11110" => --RTI 
                            R_STACK <= '1';
                            SEL_PMEM_ADDR <= "011";
                            PC_LOAD_EN <= '1';
                            SEL_Stack <= '0';
                            R_STACK <= '1';
                            SEL_PMEM_ADDR <= "100";
                            PC_INC <= '1';
                            --pop return address from stack and store into pc
                            --restore registers r0-r7 and status register
                            -- add instructions to flags to restore from previous
                            -- 3 registers in the flags unit? one for original, one for interrupts,
                            -- one for restore?
                            --this should be easier than INTTL
                            NEXT_STATE <= FETCH;
                            when others =>
                        end case;
                WHEN JUMP => 
                        CASE OPCODE IS
                            WHEN "11001" => --JMPI ADDR
                                SEL_PMEM_ADDR <= "001"; -- 4/23 Change GOTO statement
                                PC_INC <= '0';
                                NEXT_STATE <= FETCH;
                            WHEN "11010" => --JSR ADDR
                                W_STACK <= '1';
                                SEL_STACK <= '0';
                                PC_INC <= '0';
                                STACK_EN <= '1';
                                R_STACK <= '1';
                                NEXT_STATE <= FETCH;
                            WHEN "11011" => --RSR
                                R_STACK <= '1';
                                SEL_PMEM_ADDR <= "011";
                                SEL_STACK <= '0';
                                STACK_EN <= '0';
                                PC_LOAD_EN <= '1';
                                NEXT_STATE <= FETCH;
                            WHEN OTHERS =>
                       END CASE;
               WHEN BLOCKMM =>
                      CASE OPCODE IS 
                            WHEN "00011" =>
                                   --increment 
                                   --INC_RB_B <= '1';
                                   IF(ZERO /= TO_INTEGER(UNSIGNED(SRCB))) THEN
                                       PC_INC <= '0';
                                       ZERO <= ZERO + 1;
                                       INC_RB_A <= '1';
                                       SEL_DMEM_ADDR_A <= "00";
                                       NEXT_STATE <= EXEC_OFFSET;
                                   ELSE
                                       NEXT_STATE <= FETCH;
                                       PC_INC <= '1';
                                   END IF;
                               WHEN "01110" =>
                                   -- anything here ?
                                   IF(ZERO1 = 7) then
                                       PC_INC <= '0';
                                       ZERO1 <= ZERO1 + 1;
                                       --INCREMENT SOME REGISTER,IMMEDIATE,DMEM SELECT, 
                                       NEXT_STATE <= EXEC_OFFSET;
                                   ELSE
                                       NEXT_STATE <= FETCH;
                                       PC_INC <= '1';
                                    END IF;
                               WHEN "01111" =>
                                   -- anything here ?
                                   IF(ZERO2 = 7) THEN
                                       PC_INC <= '0'; 
                                       ZERO2 <= ZERO2 + 1;
                                       --INCREMENT SOME REGISTER,IMMEDIATE,DMEM SELECT, 
                                       NEXT_STATE <= EXEC_OFFSET;
                                   ELSE
                                       NEXT_STATE <= FETCH;
                                       PC_INC <= '1';
                                   END IF;
                               WHEN OTHERS =>
                           END CASE;

                WHEN OTHERS => 
                    NEXT_STATE <= FETCH;

            END CASE;
        END PROCESS FSM;

        -- Pprocess to hold synchronous elements (flip-flops)
        SYNCH: PROCESS(CLK)
        BEGIN
            IF (CLK'EVENT AND CLK = '1') THEN  
                IF (RST = '1') THEN
                    CURRENT_STATE <= FETCH; 
                else
                    CURRENT_STATE <= NEXT_STATE;
                end if;
            END IF;
        END PROCESS SYNCH;

end Behavioral;
