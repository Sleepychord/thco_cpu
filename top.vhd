----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:20:37 11/14/2016 
-- Design Name: 
-- Module Name:    top - Behavioral 
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
use work.HEADER.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk_raw : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           output : out  INT16;--LED LIGHT
           ram1addr : in  STD_LOGIC_VECTOR(17 DOWNTO 0);
           ram1data : inout  INT16;
           ram1en : out  STD_LOGIC;
           ram1oe : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram2addr : in  STD_LOGIC_VECTOR(17 DOWNTO 0);
           ram2data : inout  INT16;
           ram2en : out  STD_LOGIC;
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           seri_rdn : out  STD_LOGIC;
           seri_wrn : out  STD_LOGIC;
           seri_dataready : in  STD_LOGIC;
           seri_tbre : in  STD_LOGIC;
           seri_tsre : in  STD_LOGIC;
           digits : out  STD_LOGIC_VECTOR(6 DOWNTO 0)-- DIGITAL LIGHTS
			  );
end top;

architecture Behavioral of top is
signal clk : STD_LOGIC;
begin
	process (clk_raw)
	begin
		-- divide frequency
	end process;
	
end Behavioral;

