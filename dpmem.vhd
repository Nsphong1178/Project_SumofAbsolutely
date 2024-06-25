-- Author: Nguyễn Kiêm Hùng
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity dpmem is
  generic (
    DATA_WIDTH        :     integer   := 16;    
    ADDR_WIDTH        :     integer   := 16    
    );
  port (
    Clk              : in  std_logic;        
    nReset             : in  std_logic;
    addr              : in  std_logic_vector(ADDR_WIDTH -1 downto 0);   
    Wen               : in  std_logic;          -- Write Enable
    Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0'); 
    Ren               : in  std_logic;       
    Dataout           : buffer std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data 
    );
end dpmem;
 
architecture dpmem_arch of dpmem is
   
  type DATA_ARRAY is array (integer range <>) of std_logic_vector(DATA_WIDTH -1 downto 0); -- Memory Type
  signal   M       :     DATA_ARRAY(0 to (2**ADDR_WIDTH) -1) := (others => (others => '0'));  -- Memory model

begin  

  RW_Proc : process (clk, nReset)
  begin  
    if nReset = '0' then
          Dataout <= (others => '0');
          M <= (others => (others => '0')); 
    elsif (clk'event and clk = '1') then  
        if Wen = '1' then
			   M(conv_integer(addr))      <= Datain; 
        else
			   if Ren = '1' then
				    Dataout <= M(conv_integer(addr));
			   else
				   Dataout <= Dataout;
			   end if;
		   end if;
      end if;
  end process  RW_Proc;
     
end dpmem_arch;
