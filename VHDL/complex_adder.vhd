----------------------------------------------------------------------------------
-- Company: 
-- Engineer: ATAKAN CAKIR
-- 
-- Create Date: 02.12.2022 17:44:41
-- Design Name: 
-- Module Name: c_adder - arch
-- Project Name: Fast Fourier Transform 
-- Target Devices: 
-- Tool Versions: 
-- Description: (RADIX-2 )(64 POINT) 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


Library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COMPLEX_ADDER is
    port(
        z1_im : in std_logic_vector(31 downto 0);
        z2_im: in std_logic_vector(31 downto 0) ;
        z1_re : in std_logic_vector(31 downto 0);
        z2_re : in std_logic_vector(31 downto 0);
        neg_Byte : in integer  ;
        result_re : out std_logic_vector(31 downto 0);
        result_im : out std_logic_vector(31 downto 0)
    
    );
end COMPLEX_ADDER;

architecture arch of COMPLEX_ADDER is

component FP_Adder is
  Port (
  a   : in  std_logic_vector (31 downto 0);
  b   : in  std_logic_vector (31 downto 0);
  s   : out  std_logic_vector (31 downto 0)                                     
 
  );
end component;

signal neg_r :std_logic_vector(31 downto 0);
signal neg_i :std_logic_vector(31 downto 0);
signal tmp_r :std_logic_vector(31 downto 0);
signal tmp_i :std_logic_vector(31 downto 0);
begin
    
     neg_r(31) <= not z2_re(31) when neg_byte = 1 else
                      z2_re(31);
     neg_r(30 downto 0) <= z2_re(30 downto 0);
    
     neg_i(31) <= not z2_im(31) when neg_byte = 1 else
                      z2_im(31);
     neg_i(30 downto 0) <= z2_im(30 downto 0);
    
    
    
    
    re_add : FP_Adder port map( --re add calculator
                        a=> z1_re,
                        b=> neg_r,
                        s=>result_re );
      
    im_add : FP_Adder port map( --im add calculator
                        a=> z1_im,
                        b=> neg_i,
                        s=>result_im );  
 
 

end architecture;
