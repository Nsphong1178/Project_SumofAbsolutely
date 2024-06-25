
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all ;
use std.textio.all;

package lib is


-------------------------------------------
component dpmem 
   generic (
     DATA_WIDTH        :     integer   := 8;     -- Word Width
     ADDR_WIDTH        :     integer   := 3    -- Address width
     );
 
   port (
     -- Writing
     Clk              : in  std_logic;          -- clock
     nReset             : in  std_logic; -- Reset input
     addr              : in  std_logic_vector(2**ADDR_WIDTH -1 downto 0);   --  Address
     -- Writing Port
     Wen               : in  std_logic;          -- Write Enable
     Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');   -- Input Data
     -- Reading Port
     
     Ren               : in  std_logic;          -- Read Enable
     Dataout           : out std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data
     
     );
  
  end component;

----------------------------------------------
COMPONENT counter_n 
    GENERIC (N : Integer := 8);
		PORT (clk:  IN std_logic;
			  reset: IN std_logic;
			  enable: IN std_logic;
			  Load : IN std_logic;
			  Din  : IN std_logic_vector(N-1 downto 0);
			  count:  OUT std_logic_vector(N-1 downto 0));
END COMPONENT;
---------------------------------------------------
COMPONENT Controller 

   port (
        Clock, Reset, Start : in std_logic;
        RE_A, RE_B : out std_logic;
	WE_A, WE_B : out std_logic;
        LD_i,En_i, EN_Sum : out std_logic;
        test_i : in std_logic;
 	Done : OUT STD_LOGIC 
    );
   END COMPONENT ;

---------------------------------------------------
COMPONENT Regn
	GENERIC (N : Integer := 8);
	PORT (
          D : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;
   	  Reset, Clock, En : IN STD_LOGIC ;
	  Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	    );
	END COMPONENT;

----------------------------------
COMPONENT Datapath 

   GENERIC (
            DATA_WIDTH        :     integer   := 8;     -- Word Width
            ADDR_WIDTH        :     integer   := 3     -- Address width
           
    );
    port (
        Clock, Reset, Start : in std_logic;
	WE_A, WE_B : in std_logic;
        RE_A, RE_B : in std_logic;
        LD_i,En_i, EN_Sum : in std_logic;
        dataA, dataB : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        addrIn_A, addrIn_B : IN STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
        test_i : out std_logic;
	Sum_out : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );

   END COMPONENT;

-----------------------------------------
COMPONENT SAD 
   GENERIC (
      DATA_WIDTH : integer := 8;     -- Word Width
      ADDR_WIDTH : integer := 2      -- Address width
   );
   PORT (
      Clock, Reset : IN STD_LOGIC;
      Start : IN STD_LOGIC;
      WE_A, WE_B : IN STD_LOGIC;
      RE_A, RE_B : IN STD_LOGIC;
      data_A, data_B : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
      addrIn_A, addrIn_B : IN std_logic_vector(ADDR_WIDTH - 1 downto 0);
      Done : OUT STD_LOGIC;
      Sum_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)
   );
END COMPONENT;
end lib;

PACKAGE BODY lib IS
	-- package body declarations

END PACKAGE BODY lib;