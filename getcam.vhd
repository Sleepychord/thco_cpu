----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:27:02 11/18/2016 
-- Design Name: 
-- Module Name:    getcam - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity getcam is
    Port ( fromcamclk : in  STD_LOGIC;
           vsync : in  STD_LOGIC;
           href : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (7 downto 0);
			  addr : out STD_LOGIC_VECTOR (17 downto 0);
			  dout : out  STD_LOGIC_VECTOR (7 downto 0);
			  en : out STD_LOGIC;
			  ready : out STD_LOGIC);
end getcam;

architecture Behavioral of getcam is
begin
	process (fromcamclk)
	variable pixready : std_logic;
	variable vx : integer;
	variable vy : integer;
	variable lyxaddr : STD_LOGIC_VECTOR (17 downto 0);
	variable nextaddr : std_logic_vector (17 downto 0);
	begin
		if (fromcamclk'event and fromcamclk = '1') then
			if (vsync = '1') then
				lyxaddr := "000000000000000000";
				nextaddr := "000000000000000000";
				vx := 0;
				vy := 0;
				en <= '0';
			elsif ((vsync = '0') and (href = '0')) then
				if (vx > 0) then
					vx := 0;
					vy := vy + 1;
				end if;
				pixready := '1';
				en <= '0';
			else
				if (pixready = '0') then
					dout <= d;
					pixready := '1';
					if (vx >= 200) and (vx < 480) and (vy >= 100) and (vy < 380) then
						vx := vx + 1;
						en <= '1';
						nextaddr := nextaddr + "000000000000000001";
					else
						vx := vx + 1;
						en <= '0';
					end if;
				else
					lyxaddr := nextaddr;
					pixready := '0';
				end if;
			end if;
		end if;
		addr <= lyxaddr;
		ready <= pixready;
	end process;

end Behavioral;

