----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:05 11/18/2016 
-- Design Name: 
-- Module Name:    cam2ram - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cam2ram is
    Port ( addr : in  STD_LOGIC_VECTOR (17 downto 0);
           requestaddr : in STD_LOGIC_VECTOR (17 downto 0);
           d : in  STD_LOGIC_VECTOR (7 downto 0);
           en : in std_logic;
			  mnistdata : out std_logic;
           mnistaddr : in STD_LOGIC_VECTOR (9 downto 0);
			  pclk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  switch : in STD_LOGIC;
			  pixready : in STD_LOGIC;
			  outr : out STD_LOGIC_VECTOR (2 downto 0);
			  outg : out STD_LOGIC_VECTOR (2 downto 0);
			  outb : out STD_LOGIC_VECTOR (2 downto 0);
           ram2Oe : out  STD_LOGIC;
           ram2En : out  STD_LOGIC;
           ram2We : out  STD_LOGIC;
           ram2Addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2Data : inout  STD_LOGIC_VECTOR (15 downto 0)
			  );
end cam2ram;

architecture Behavioral of cam2ram is
signal waiting : std_logic;
subtype int16 is STD_LOGIC_VECTOR(15 DOWNTO 0);
type matrix28 is array (783 downto 0) of int16;
signal ele : matrix28;
signal tmp : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal yx : std_logic;
begin
	process (rst, pclk)
    variable yxuan : integer;
	variable rw : integer;
    variable count1 : integer;
    variable count2 : integer;
    variable count3 : integer;
    variable rank : integer;
    variable baserank : integer;
	begin
		if (rst = '0') then
			ram2Oe <= '1';
			ram2En <= '0';
			ram2We <= '1';
			rw := 0;
			outr <= "111";
			outg <= "111";
			outb <= "111";
			yx <= '0';
			count1 := 0;
         count2 := 0;
         count3 := 0;
			rank := 0;
         baserank := 0;
			yxuan := 0;
		elsif (pclk'event and pclk = '0') then
            if (rw = 0) then
					 if ((waiting = '1') and (addr = "000000000000000000")) then 
                    rw := 2;
                elsif (pixready = '1') then
						  ram2Addr <= addr;
                    ram2Data <= "00000000" & d;
                    ram2We <= '1';
                    if (yxuan = 0) then
                        ele(rank) <= "00000000" & d;
                    elsif (yxuan = 1) then
								yx <= '1';
                        ele(rank) <= ele(rank) + ("00000000" & d);
                    end if;
                else
                    if (addr = "000000000000000000") then
								count1 := 0;
                        count2 := 0;
                        count3 := 0;
                        rank := 0;
                        baserank := 0;
                        yxuan := 0;
                    elsif (en = '0') then
								yxuan := 2;
						  else
                        if (count3 = 9) then
                            if (count2 = 279) then
                                if (count1 = 2799) then
                                    count1 := 0;
                                    count2 := 0;
                                    count3 := 0;
                                    baserank := baserank + 28;
                                    rank := rank + 1;
                                    yxuan := 0;
                                else
                                    count1 := count1 + 1;
                                    count2 := 0;
                                    count3 := 0;
                                    rank := baserank;
                                    yxuan := 1;
                                end if;
                            else
                                rank := rank + 1;
                                if (count1 = count2) then
                                    count1 := count1 + 1;
                                    count2 := count2 + 1;
                                    yxuan := 0;
                                else
                                    count1 := count1 + 1;
                                    count2 := count2 + 1;
                                    yxuan := 1;
                                end if;
                                count3 := 0;
                            end if;
                        else
                            count1 := count1 + 1;
                            count2 := count2 + 1;
                            count3 := count3 + 1;
                            yxuan := 1;
                        end if;
                    end if;
                    ram2We <= '0';
                end if;
            elsif (rw = 1) then
                outr <= ram2Data(7 downto 5);
                outg <= ram2Data(7 downto 5);
                outb <= ram2Data(7 downto 5);
					 ram2Addr <= requestaddr;
				else
					 ram2Data <= "ZZZZZZZZZZZZZZZZ";
                ram2Oe <= '0';
                ram2We <= '1';
					 rw := 1;
            end if;
        end if;
	end process;
	
	process (rst, switch)
	begin
		if (rst = '0') then
			waiting <= '0';
		elsif (switch'event and switch = '1') then
			waiting <= '1';
		end if;
	end process;
   mnistdata <= '1' when mnistaddr = "1100010000" else '1' when ele(conv_integer(mnistaddr)) < "0000110000000000" else '0';
end Behavioral;
