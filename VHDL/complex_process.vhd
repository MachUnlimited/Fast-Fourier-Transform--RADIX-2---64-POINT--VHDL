----------------------------------------------------------------------------------
-- Company: 
-- Engineer: ATAKAN CAKIR
-- 
-- Create Date: 22.01.2023 20:39:27
-- Design Name: 
-- Module Name: complex_process - Behavioral
-- Project Name: Fast Fourier Transform (RADIX-2 )(64 POINT) 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity complex_process is
     Port ( 
           ar_0 : in std_logic_vector(31 downto 0);
           ai_0 : in std_logic_vector(31 downto 0);
           tr : in std_logic_vector(31 downto 0)  ;
           ti : in std_logic_vector(31 downto 0)  ;
           ar_1 : in std_logic_vector(31 downto 0);
           ai_1 : in std_logic_vector(31 downto 0);
           neg_byte : in integer ;
           ----- OUTPUTS ---
           out_R : out std_logic_vector(31 downto 0);
           out_i : out std_logic_vector(31 downto 0)    );
        
           
           
           
          
           
           
           
        
end complex_process;

architecture Behavioral of complex_process is


-------------- component MUL -----------------------

component c_multiplier is
port(
        z1_im : in std_logic_vector(31 downto 0);
        z2_im: in std_logic_vector(31 downto 0) ;
        z1_re : in std_logic_vector(31 downto 0);
        z2_re : in std_logic_vector(31 downto 0);
        result_re : out std_logic_vector(31 downto 0);
        result_im : out std_logic_vector(31 downto 0)
    
    );
end component;

-------------- component ADDER -----------------------

component COMPLEX_ADDER is
    port(
        z1_im     :  in std_logic_vector(31 downto 0);
        z2_im     : in std_logic_vector(31 downto 0) ;
        z1_re     : in std_logic_vector(31 downto 0);
        z2_re     : in std_logic_vector(31 downto 0);
        neg_Byte  : in integer;
        result_re : out std_logic_vector(31 downto 0);
        result_im : out std_logic_vector(31 downto 0)
    
    );
end component;

-----------------END COMPONENT ----------------------


signal tmp_R : std_logic_vector(31 downto 0);
signal tmp_i : std_logic_vector(31 downto 0);

begin
    
  
    BLOCK_ADD :COMPLEX_ADDER port map (
                                       z1_im      => ai_1  ,
                                       z2_im      => ai_0  ,
                                       z1_re      => ar_1  ,
                                       z2_re      => ar_0  ,
                                       neg_Byte   => neg_Byte,
                                       result_re  => tmp_R  ,
                                       result_im  => tmp_i   );
                                       
           
                        
    BLOCK_MUL :c_multiplier  port map (
                                       z2_im     => ti,
                                       z1_im     => tmp_i,
                                       z2_re     => tr,
                                       z1_re     => tmp_R ,
                                       result_re => out_R ,
                                       result_im => out_i  );
  


end Behavioral;
