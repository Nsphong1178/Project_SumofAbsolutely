
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use work.myLib.all;
ENTITY Controller IS
   port (
        Clock, Reset, Start : in std_logic;
        RE_A, RE_B : out std_logic;
	WE_A, WE_B : out std_logic;
        LD_i,En_i, EN_Sum : out std_logic;
        test_i : in std_logic;
 	Done : OUT STD_LOGIC 
    );
   END Controller ;
ARCHITECTURE Behavior OF Controller IS
  SIGNAL State : STD_LOGIC_VECTOR(3 DOWNTO 0) ;

BEGIN
-- State transitions 
  PROCESS ( Reset, Clock )
    BEGIN
      
      IF Reset = '1' THEN
	       STATE <= "0000" ; -- STATE 0
      ELSIF (Clock'EVENT AND Clock = '1') THEN
        CASE STATE IS
           WHEN "0000" =>
               STATE <= "0001"; -- STATE 1
           WHEN "0001" =>    
               IF START = '1' THEN
	               STATE <= "0010"; -- STATE 2
	             ELSE
	               STATE <= "0000"; -- STATE 1
               END IF ;
            WHEN "0010" =>
		IF test_i = '0' THEN
	               STATE <= "0011"; -- STATE 3
	             ELSE
	               STATE <= "0110"; -- STATE 6
               END IF ;
            WHEN "0011" =>
               STATE <= "0100"; -- STATE 4
            WHEN "0100" => 
                STATE <= "0101"; -- STATE 5
	    WHEN "0101" => 
                STATE <= "0010"; -- STATE 2

            WHEN "0110" => --6
                STATE <= "0111"; -- STATE 7                  
            WHEN OTHERs =>
                STATE <= "0000"; -- STATE 0
          END CASE ;
  END IF ;


  END PROCESS ;

  LD_i <= '1' WHEN STATE = "0000" ELSE '0' ;

  EN_i <= '1' WHEN STATE = "0100" ELSE '0' ; --4

  Re_A <= '1'  WHEN STATE = "0011" ELSE '0'; --3
  Re_B <= '1'  WHEN STATE = "0011" ELSE '0'; --3

  EN_sum <= '1' WHEN STATE = "0101" ELSE '0' ; --5
   
  Done <= '1' 	WHEN STATE = "0110" ELSE '0'; --6	
  --Start <= '0' 	WHEN STATE = "0110" ELSE '0'; --6	

	 
		    	     	    	     	    	     
END Behavior;   