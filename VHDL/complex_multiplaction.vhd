----------------------------------------------------------------------------------
-- Company: 
-- Engineer: ATAKAN CAKIR
-- 
-- Create Date: 02.12.2022 17:45:02
-- Design Name: 
-- Module Name: c_multiplier - arch
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

entity c_multiplier is
port(
        z1_im : in std_logic_vector(31 downto 0);
        z2_im: in std_logic_vector(31 downto 0) ;
        z1_re : in std_logic_vector(31 downto 0);
        z2_re : in std_logic_vector(31 downto 0);
        result_re : out std_logic_vector(31 downto 0);
        result_im : out std_logic_vector(31 downto 0)
    
    );
end c_multiplier;

architecture arch of c_multiplier is

signal AC : std_logic_vector(31 downto 0);
signal BD,BD_neg : std_logic_vector(31 downto 0);
signal BC : std_logic_vector(31 downto 0);
signal AD : std_logic_vector(31 downto 0);

component FP_Adder is
  Port (
        A: IN STD_LOGIC_VECTOR(31 DOWNTO 0) ;
        B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
end component;

component multiplier is
  Port (
  x   : in  std_logic_vector (31 downto 0);
  y   : in  std_logic_vector (31 downto 0);
  z   : out  std_logic_vector (31 downto 0)                                     
 
  );
end component;

begin --(a+bi)(c+di) = (ac-bd) + i(bc+ad)

BD_Neg(30 downto 0) <= bd(30 downto 0);
BD_Neg(31)     <= not bd(31);


AC_MUL : multiplier port map (x => z1_re, y=> z2_re, z=> AC); --(A*C)
BD_MUL : multiplier port map (x => z1_im, y=> z2_im, z=> BD); --(B*D)

BC_MUL : multiplier port map (x => z1_re, y=> z2_im, z=> BC); --(B*C)
AD_MUL : multiplier port map (x => z1_im, y=> z2_re, z=> AD); --(A*D)

RE_ADD : FP_Adder port map      (a => AC, b=> BD_Neg, s=> result_re);--(AC-BD)
IM_ADD : FP_Adder port map      (a => BC, b=> AD,     s=> result_im);--(BC+AD)

 


end arch;
