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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Switches_LEDS is
    Port ( Switch : in STD_LOGIC_VECTOR(7 downto 0);
           LEDS_1    : out STD_LOGIC_VECTOR(7 downto 0);
           LEDS_2    : out STD_LOGIC_VECTOR(3 downto 0);
           clk    : in STD_LOGIC
          );
end Switches_LEDS;

architecture Behavioral of Switches_LEDS is
   
    signal counter  : STD_LOGIC_VECTOR(29 downto 0);
    
begin
    
    --Counter block
    counter_proc: process(clk)
        begin
            if rising_edge(clk) then
                counter <= counter+1;
            end if;
        end process;
    
    LEDS_1 <= counter(29 downto 22);
    
end Behavioral;
