library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity vga is
	port (
	--VGA Side
		hs,vs	: out std_logic;		--��ͬ������ͬ���ź�
		oRed	: out std_logic_vector (2 downto 0);
		oGreen	: out std_logic_vector (2 downto 0);
		oBlue	: out std_logic_vector (2 downto 0);
	--RAM side
--		R,G,B	: in  std_logic_vector (9 downto 0);
--		addr	: out std_logic_vector (18 downto 0);
	--Control Signals
		reset	: in  std_logic;
		CLK_in	: in  std_logic			--100Mʱ������
	);		
end entity vga;

architecture behave of vga is

--VGA
	signal CLK,CLK_2: std_logic;
	signal rt,gt,bt	: std_logic_vector (2 downto 0);
	signal hst,vst	: std_logic;
	signal x		: std_logic_vector (9 downto 0);		--X����
	signal y		: std_logic_vector (9 downto 0);		--Y����

begin
--reset<=not reset_in;

--	VGA_CLK	<= CLK;
CLK<=CLK_2;
 -----------------------------------------------------------------------
	process (CLK_in)
	begin
		if CLK_in'event and CLK_in = '1' then	--��100M�����źŶ���Ƶ
			CLK_2 <= not CLK_2;
		end if;
	end process;
	

 -----------------------------------------------------------------------
	process (CLK, reset)	--������������������������
	begin
		if reset = '0' then
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
	 process (CLK, reset)	--����������������������
	 begin
	  	if reset = '0' then
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
 
  -----------------------------------------------------------------------
	 process (CLK, reset)	--��ͬ���źŲ�����ͬ������96��ǰ��16��
	 begin
		  if reset = '0' then
		   hst <= '1';
		  elsif CLK'event and CLK = '1' then
		   	if x >= 656 and x < 752 then
		    	hst <= '0';
		   	else
		    	hst <= '1';
		   	end if;
		  end if;
	 end process;
 
 -----------------------------------------------------------------------
	 process (CLK, reset)	--��ͬ���źŲ�����ͬ������2��ǰ��10��
	 begin
	  	if reset = '0' then
	   		vst <= '1';
	  	elsif CLK'event and CLK = '1' then
	   		if y >= 490 and y< 492 then
	    		vst <= '0';
	   		else
	    		vst <= '1';
	   		end if;
	  	end if;
	 end process;
 -----------------------------------------------------------------------
	 process (CLK, reset)	--��ͬ���ź����
	 begin
	  	if reset = '0' then
	   		hs <= '0';
	  	elsif CLK'event and CLK = '1' then
	   		hs <=  hst;
	  	end if;
	 end process;

 -----------------------------------------------------------------------
	 process (CLK, reset)	--��ͬ���ź����
	 begin
	  	if reset = '0' then
	   		vs <= '0';
	  	elsif CLK'event and CLK='1' then
	   		vs <=  vst;
	  	end if;
	 end process;

------------------------------------------------------------------------
--	process (CLK, reset) -- XY���궨λ����
--	begin	  	
--		if reset = '1' then
--			rt		<=	(others => '0');
--			gt		<=	(others => '0');
--			bt		<=	(others => '0');
--			addr	<=	(others => '0');
--	  	elsif CLK'event and CLK='1' then
--			addr	<=	x&y;
--			rt		<=	R;
--			gt		<=	G;
--			bt		<=	B;
--	  	end if;
--	end process;
-----------------------------------------------------------------------	
-----------------------------------------------------------------------
-----------------------------------------------------------------------
	process(reset,clk,x,y) -- XY���궨λ����
	begin  
		if reset='0' then
			        rt   <= "000";
					gt	<= "000";
					bt	<= "000";	
		elsif(clk'event and clk='1')then 
		    
			if y<400 and y > 100 and x > 200 and x < 500 then				-- Y������ƣ���Ϊ2��
			    gt <="111";
				 bt <= "111";
				 rt <= "111";
			else
			    gt <= "000";
				 bt <= "000";
				 rt <= "000";
			end if;		
		end if;		 
	    end process;	

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
	process (hst, vst, rt, gt, bt)	--ɫ�����
	begin
		if hst = '1' and vst = '1' then
			oRed	<= rt;           
			oGreen	<= gt;
			oBlue	<= bt;
		else
			oRed	<= (others => '0');
			oGreen	<= (others => '0');
			oBlue	<= (others => '0');
		end if;
	end process;

end behave;