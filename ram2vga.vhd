----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:36:00 11/18/2016 
-- Design Name: 
-- Module Name:    ram2vga - Behavioral 
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

entity ram2vga is
    Port ( rst : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           vs : out  STD_LOGIC;
           hs : out  STD_LOGIC;
			  requestaddr : out  STD_LOGIC_VECTOR (17 downto 0);
			  getr : in  STD_LOGIC_VECTOR (2 downto 0);
           getg : in  STD_LOGIC_VECTOR (2 downto 0);
           getb : in  STD_LOGIC_VECTOR (2 downto 0);
           r : out  STD_LOGIC_VECTOR (2 downto 0);
           g : out  STD_LOGIC_VECTOR (2 downto 0);
           b : out  STD_LOGIC_VECTOR (2 downto 0));
end ram2vga;

architecture Behavioral of ram2vga is
signal x : std_logic_vector (9 downto 0);
signal y : std_logic_vector (9 downto 0);
signal tmpr : std_logic_vector (2 downto 0);
signal tmpg : std_logic_vector (2 downto 0);
signal tmpb : std_logic_vector (2 downto 0);
signal vst : STD_LOGIC;
signal addr : STD_LOGIC_VECTOR (17 downto 0);
signal hst : STD_LOGIC;
begin
--	process (rst, clk)
--	begin
--		if (rst = '0') then
--			x <= "0000000000";
--			y <= "0000000000";
--			addr <= "000000000000000000";
--		elsif (clk'event and clk = '1') then
--			if (x = "1100011111") then
--				if (y = "1000001100") then
--					x <= "0000000000";
--					y <= "0000000000";
--					addr <= "000000000000000000";
--				else
--					y <= y + "0000000001";
--					x <= "0000000000";
--				end if;
--			else
--				if ((y >= "0000000000") and (y <= "0111011111") and (x >= "0000000000") and (x <= "1001111110")) then
--					x <= x + "0000000001";
--					addr <= addr + "000000000000000001";
--				else
--					x <= x + "0000000001";
--				end if;
--			end if;
--		end if;
--	end process;
	
	process (clk, rst)	--行区间像素数（含消隐区）
	begin
		if rst = '0' then
			x <= (others => '0');
		elsif CLK'event and CLK = '1' then
			if x = 799 then
				x <= (others => '0');
			else
				x <= x + 1;
			end if;
		end if;
	end process;

  -----------------------------------------------------------------------
	 process (clk, rst)	--场区间行数（含消隐区）
	 begin
	  	if rst = '0' then
	   		y <= (others => '0');
	  	elsif CLK'event and CLK = '1' then
	   		if x = 799 then
	    		if y = 524 then
	     			y <= (others => '0');
	    		else
	     			y <= y + 1;
	    		end if;
	   		end if;
	  	end if;
	 end process;

	process (clk, rst)
	variable count : integer := 0;
	begin
		if (rst = '0') then
			addr <= "000000000000000000";
			count := 0;
		elsif (clk'event and clk = '1') then
			if (x >= 0) and (x < 280) and (y >= 0) and (y < 280) then
--				if (x = 0) then
--					if ((y >= 0) and (y < 10)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 10) and (y < 20)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 20) and (y < 30)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 30) and (y < 40)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 40) and (y < 50)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 50) and (y < 60)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 60) and (y < 70)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 70) and (y < 80)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 80) and (y < 90)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 90) and (y < 100)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 100) and (y < 110)) then
--						addr <= "000000000000000000";
--					elsif ((y >= 110) and (y < 120)) then
--					elsif ((y >= 120) and (y < 130)) then
--					elsif ((y >= 130) and (y < 140)) then
--					elsif ((y >= 140) and (y < 150)) then
--					elsif ((y >= 150) and (y < 160)) then
--					elsif ((y >= 160) and (y < 170)) then
--					elsif ((y >= 170) and (y < 180)) then
--					elsif ((y >= 180) and (y < 190)) then
--					elsif ((y >= 190) and (y < 200)) then
--					elsif ((y >= 200) and (y < 210)) then
--					elsif ((y >= 210) and (y < 220)) then
--					elsif ((y >= 220) and (y < 230)) then
--					elsif ((y >= 230) and (y < 240)) then
--					elsif ((y >= 240) and (y < 250)) then
--					elsif ((y >= 250) and (y < 260)) then
--					elsif ((y >= 260) and (y < 270)) then
--					else
--					end if;
--				else
--					if (count = 10) then
--						addr <= addr + "000000000000000001";
--						count := 0;
--					else
--						count := count + 1;
--					end if;
--				end if;
				if (x = 0) and (y = 0) then
					addr <= "000000000000000000";
				else
					addr <= addr + "000000000000000001";
				end if;
			end if;	
		end if;
	end process;
	
	requestaddr <= addr;
	
	process (clk, rst)
	begin
		if (rst = '0') then
			hst <= '1';
		elsif (clk'event and clk = '1') then
			if (x >= 656) and (x < 752) then
				hst <= '0';
			else
				hst <= '1';
			end if;
		end if;
	end process;
	
	process (clk, rst)
	begin
		if (rst = '0') then
			vst <= '1';
		elsif (clk'event and clk = '1') then
			if (y >= 490) and (y < 492) then
				vst <= '0';
			else
				vst <= '1';
			end if;
		end if;
	end process;
	
	process (clk, rst)
	begin
		if (rst = '0') then 
			vs <= '0';
		elsif (clk'event and clk = '1') then
			vs <= vst;
		end if;
	end process;
	
	process (clk, rst)
	begin
		if (rst = '0') then
			hs <= '0';
		elsif (clk'event and clk = '1') then
			hs <= hst;
		end if;
	end process;
	
	process (clk, rst)
	begin
		if (rst = '0') then
			tmpr <= "000";
			tmpg <= "000";
			tmpb <= "000";
		elsif (clk'event and clk = '1') then
			if (x >= 0) and (x < 280) and (y >= 0) and (y < 280) then
				tmpr <= getr;
				tmpg <= getg;
				tmpb <= getb;
			else
				tmpr <= "000";
				tmpg <= "000";
				tmpb <= "000";
			end if;
		end if;
	end process;
	
	process (hst, vst, tmpr, tmpg, tmpb)
	begin
		if (hst = '1') and (vst = '1') then
			r <= tmpr;
			g <= tmpg;
			b <= tmpb;
		else
			r <= "000";
			g <= "000";
			b <= "000";
		end if;
	end process;
end Behavioral;

