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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Switches_LEDS is
    Port ( Switch : in STD_LOGIC_VECTOR(7 downto 0);
           LED    : out STD_LOGIC_VECTOR(7 downto 0)
          );
end Switches_LEDS;

architecture Behavioral of Switches_LEDS is
    signal number_1 : STD_LOGIC_VECTOR(3 downto 0);
    signal number_2 : STD_LOGIC_VECTOR(3 downto 0);
    signal carry    : STD_LOGIC_VECTOR(3 downto 0);
    signal result   : STD_LOGIC_VECTOR(7 downto 0);
    
begin
    
    -- Define addition operation
    result(0) <= number_1(0) XOR number_2(0);
    carry(0) <= number_1(0) AND number_2(0);
    
    result(1) <= number_1(1) XOR number_2(1) XOR carry(0);
    carry(1) <= (number_1(1) AND number_2(1)) OR (number_1(1) AND carry(0)) OR (number_2(1) AND carry(0));
    
    result(2) <= number_1(2) XOR number_2(2) XOR carry(1);
    carry(2) <= (number_1(2) AND number_2(2)) OR (number_1(2) AND carry(1)) OR (number_2(2) AND carry(1));
    
    result(3) <= number_1(3) XOR number_2(3) XOR carry(2);
    carry(3) <= (number_1(3) AND number_2(3)) OR (number_1(3) AND carry(2)) OR (number_2(3) AND carry(2));
    
    result(4) <= carry(3);
    
    -- Assign the two 4-bit numbers
    number_1 <= Switch(3 downto 0);
    number_2 <= Switch(7 downto 4);
    
    -- Fill in empty part of the result vector
    result(7 downto 5) <= "000";
   
    -- Assign the result to the LEDs    
    LED <= result(7 downto 0);
    
end Behavioral;
