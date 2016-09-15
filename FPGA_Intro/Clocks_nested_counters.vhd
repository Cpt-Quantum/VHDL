----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.08.2016 14:48:09
-- Design Name: 
-- Module Name: Switches_LEDS - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( switches_1   : in STD_LOGIC_VECTOR(7 downto 0);
           switches_2   : in STD_LOGIC_VECTOR(3 downto 0);
           LEDS_1       : out STD_LOGIC_VECTOR(7 downto 0);
           LEDS_2       : out STD_LOGIC_VECTOR(3 downto 0);
           clk          : in STD_LOGIC
          );
end counter;

architecture Behavioral of counter is
   
    signal counter_1  : STD_LOGIC_VECTOR(6 downto 0);
    signal counter_2  : STD_LOGIC_VECTOR(9 downto 0);
    signal counter_3  : STD_LOGIC_VECTOR(9 downto 0);

    signal LED_state : STD_LOGIC_VECTOR(3 downto 0);
    
    -- Reset signals
    signal reset    : STD_LOGIC;
begin
    
    --Reset block
    
    reset_proc: process(clk)
        begin
            if rising_edge(clk) then
                if switches_2(0) = '1' then
                    reset <= '1';
                else
                    reset <= '0';
                end if;
            end if;
        end process;
    
    --End of reset block
        
    --Counter block
    counter_1_proc: process(clk)
        begin
            if rising_edge(clk) and reset = '0' then
                counter_1 <= counter_1+1;
                if counter_1 = STD_LOGIC_VECTOR(to_unsigned(100,7)) or reset = '1' then
                    counter_1 <= (others=>'0');
                end if;
            end if;
        end process;
    counter_2_proc: process(clk)
        begin
            if rising_edge(clk) then      
                if counter_1 = STD_LOGIC_VECTOR(to_unsigned(100,7)) then
                    counter_2 <= counter_2 + 1;
                end if;
                if counter_2 = STD_LOGIC_VECTOR(to_unsigned(1000,10)) or reset = '1' then
                    counter_2 <= (others=>'0');
                end if;
            end if;
        end process;
    counter_3_proc: process(clk)
        begin
            if rising_edge(clk)
                if counter_2 = STD_LOGIC_VECTOR(to_unsigned(1000,10)) then
                    counter_3 <= counter_3 + 1;
                end if;
                if counter_3 = STD_LOGIC_VECTOR(to_unsigned(1000,10)) or reset = '1'then
                    counter_3 <= (others =>'0')
                end if;
            end if;
        end process;
    --End of counter block
  
    
    --Display 1 second on each LED
    LED_proc: process(clk)
        begin
            if rising_edge(clk) then
                if reset=  '1' then 
                    LED_state <= "1000";
                end if;
                if counter_3 = STD_LOGIC_VECTOR(to_unsigned(1000,10)) then
                    --Assign LEDds to internal LED state
                    LEDS_1(7 downto 4) <= LED_state(3 downto 0);
                    
                    -- Shift register to move along LED chain
                    LED_state(3 downto 0) <= LED_state(0) & LED_state(3 downto 1);
                end if;
                --Set lower bits for counter as this is all the counter will reach
                LEDS_1(3 downto 0) <= counter_3(5 downto 2);
            end if;        
        end process;
    
    --Switch off LEDS on board, comment if you want to use these LEDs elesewhere
    LEDS_2 <= (others=>'0');
    
end Behavioral;
