----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:25:25 11/23/2016 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topmodule is
    Port ( Reste : out  STD_LOGIC;
			  pwdn : out STD_LOGIC;
			  tocamclk : out  STD_LOGIC;
           clk50m : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  switch : in STD_LOGIC;
           camclk : in  STD_LOGIC;
			  vsync : in STD_LOGIC;
			  href : in STD_LOGIC;
			  din : in STD_LOGIC_VECTOR (7 downto 0);
           r : out  STD_LOGIC_VECTOR (2 downto 0);
           g : out  STD_LOGIC_VECTOR (2 downto 0);
           b : out  STD_LOGIC_VECTOR (2 downto 0);
           hs : out  STD_LOGIC;
			  Oe : out STD_LOGIC;
			  En : out STD_LOGIC;
			  We : out STD_LOGIC;
			  watch : out STD_LOGIC_VECTOR (2 downto 0);
			  Addr : out  STD_LOGIC_VECTOR (17 downto 0);
			  Data : inout STD_LOGIC_VECTOR (15 downto 0);
           vs : out  STD_LOGIC);
end topmodule;

architecture Behavioral of topmodule is
	component cam2ram
		Port ( addr : in  STD_LOGIC_VECTOR (17 downto 0);
           requestaddr : in STD_LOGIC_VECTOR (17 downto 0);
           d : in  STD_LOGIC_VECTOR (7 downto 0);
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
           ram2Data : inout  STD_LOGIC_VECTOR (15 downto 0);
			  look : out std_logic;
			  wat : out std_logic);
	end component;
	component getcam
		    Port ( fromcamclk : in STD_LOGIC;
           vsync : in  STD_LOGIC;
           href : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (7 downto 0);
			  addr : out STD_LOGIC_VECTOR (17 downto 0);
			  dout : out  STD_LOGIC_VECTOR (7 downto 0);
			  ready : out STD_LOGIC);
	end component;
	component ram2vga
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
	end component;
	component frediv
		Port (clk50m : in STD_LOGIC;
				clk25m : out STD_LOGIC);
	end component;
	component vga
		port (
		--VGA Side
			hs,vs	: out std_logic;		--行同步、场同步信号
			oRed	: out std_logic_vector (2 downto 0);
			oGreen	: out std_logic_vector (2 downto 0);
			oBlue	: out std_logic_vector (2 downto 0);
		--RAM side
	--		R,G,B	: in  std_logic_vector (9 downto 0);
	--		addr	: out std_logic_vector (18 downto 0);
		--Control Signals
			reset	: in  std_logic;
			CLK_in	: in  std_logic			--100M时钟输入
		);	
	end component;
	signal readyWire: std_logic;
	signal readAddrWire, addrWire: std_logic_vector (17 downto 0);
	signal dwire: std_logic_vector (7 downto 0);
	signal cclk : std_logic;
	signal rWire, gWire, bWire: std_logic_vector (2 downto 0);
	signal ww, www: std_logic;
begin
	u0: frediv Port map(clk50m=>clk50m, clk25m=>cclk);
	u1: getcam Port map(fromcamclk=>camclk, vsync=>vsync, href=>href, d=>din, addr=>addrWire, dout=>dwire, ready=>readyWire);
	u2: cam2ram Port map(addr=>addrWire, requestaddr=>readAddrWire, d=>dwire, pclk=>camclk, rst=>rst, switch=>switch, pixready=>readyWire, outr=>rWire, outg=>gWIre, outb=>bWire, ram2Oe=>Oe, ram2En=>En, ram2We=>We, ram2Addr=>Addr, ram2Data=>Data, look=>ww, wat=>www);
	u3: ram2vga Port map(rst=>rst, clk=>cclk, vs=>vs, hs=>hs, requestaddr=>readAddrWire, getr=>rWire, getg=>gWire, getb=>bWire, r=>r, g=>g, b=>b);
	watch <= "00" & ww;
	Reste <= '1';
	pwdn <= '0';
	tocamclk <= cclk;
end Behavioral;

