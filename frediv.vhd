----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:41:32 11/23/2016 
-- Design Name: 
-- Module Name:    frediv - Behavioral 
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

entity frediv is
    Port ( clk50m : in  STD_LOGIC;
           clk25m : out  STD_LOGIC);
end frediv;

architecture Behavioral of frediv is
signal clk : std_logic;
begin
	process (clk50m)
	variable tmp : integer := 0;
	begin
		if (clk50m'event and clk50m = '1') then
--			if (tmp = 20000000) then
				clk <= not clk;
--				tmp := 0;
--			else
--				tmp := tmp + 1;
--			end if;
		end if;
	end process;
	clk25m <= clk;
end Behavioral;

