----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:57:13 02/05/2019 
-- Design Name: 
-- Module Name:    mms - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mms is
    Port ( a1 : in  STD_LOGIC_VECTOR (15 downto 0);
           a2_0 : in  STD_LOGIC_VECTOR (15 downto 0);
           a2_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           w2 : in  STD_LOGIC_VECTOR (15 downto 0);
           IR : out  STD_LOGIC_VECTOR (15 downto 0);
           ImR : out  STD_LOGIC_VECTOR (15 downto 0);
           Memout : out  STD_LOGIC_VECTOR (15 downto 0);
           Memsrc : in  STD_LOGIC;
           w1 : in  STD_LOGIC;
           w2 : in  STD_LOGIC;
           r1 : in  STD_LOGIC;
           r2 : in  STD_LOGIC;
           writeImR : in  STD_LOGIC);
end mms;

architecture Behavioral of mms is

begin


end Behavioral;

