----------------------------------------------------------------------------------
-- Company: 
-- Engineer: ATAKAN CAKIR
-- 
-- Create Date: 19.01.2023 21:54:56
-- Design Name: 
-- Module Name: FFT_64 - Behavioral
-- Project Name: Fast Fourier Transform 
-- Target Devices: 
-- Tool Versions: 
-- Description:  (RADIX-2 )(64 POINT) 
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FFT_64 is
 Port (
        clk : in std_logic
       
       );
end FFT_64;

architecture Behavioral of FFT_64 is




  -------- 32 bit (real ) + 32 bit (imag)-----

type INPUT_TYPE is array (0 to 63 ) of std_logic_vector(63 downto 0);
signal fft_in      : INPUT_TYPE := (
"0011111110100001001000110111011100111111110011111100001111110110",
"1011111110111110111110111001011000111111110100111010011000000000",
"0011111100000111100010010010111110111111110011100000111100101111",
"1011111101100010110100010101110100111110010000000000011011010110",
"0011111111101010001111100101011000111111111011100000010111011111",
"1011111110101111010011010101011100111111111100001111000110001001",
"0011111111101010000100011100100110111101011011111001101011111010",
"0011111110011001101111100101110110111111101101110101101010101100",
"1011111010100000001110111001111100111111110101001101101101001001",
"0011111110010101100111000011001100111111111010110100001010010111",
"0011111100011111011110100111110110111111111011011011011100110011",
"0011111110110010110000010001010000111111110111100011010001011101",
"0011111100110111000001100101100100111111100000111111011010000100",
"0011111101111000111101111011100010111110110111001011100000010101",
"0011111100011111001101011001100110111111101010000101101000111000",
"0011111101010010111111011011111110111111111011111011001110011011",
"1011111101100100011011100100110110111111111010000101110000111001",
"1011111111001110010001001011111000111111101001011001110001000100",
"0011111101000111100000010010100010111111001110110100101001000110",
"0011111111100110100000111000000110111111111011100101110100010101",
"1011111001111010111001110011001010111110111100101001000101111011",
"0011111110000111111100011101000100111111100101110010010001110001",
"1011111110100000010100100011110010111101001001111011001100111100",
"1011111001011110111000010000000100111111000101011101001100010100",
"0011111101010110011000111011110000111111100000100110011001001011",
"1011111101100101010110011010111100111111001110000000001111111011",
"0011111100011110110100100000001110111111101011001011111000101000",
"1011111111000011000100101011110010111011110101100110110101001110",
"0011111111101011011000111000111110111111001000110111000111101101",
"0011111010101110101000001101110010111111100011010110100010000101",
"0011111110000000101001100001001110111111011110101100100001011001",
"0011110011000011001100110101111100111111010010111101101011000101",
"0011111111001000001001000111100100111111111010110010100000111111",
"0011111001000001011001010001001010111111101110010000011000111000",
"1011111110110011100011111011110010111111011110000100111111000010",
"0011111110101110011100100111111010111111011110111001110101110100",
"0011111110100000111010011111000110111111100000110101000010110010",
"0011111111011011110010000111000110111111000110011001110111011011",
"1011111110011011010101111101111010111111011111101110001111100000",
"0011111011101101101010001101010110111101110110101101000101011000",
"1011111100010111111001101001001000111111101010010110001001011111",
"0011111010101110100111101111000100111110010010111010101011111011",
"0011111111010101100110100110100010111111010110110100110100000100",
"0011111110000011101011111100000000111111100000011110100011001000",
"1011111011110100110110001100111100111110100010101110011000010011",
"1011111111011001001010011010000010111111111001000110000010100110",
"0011110111111100010010110010011000111111100011101110111100000010",
"0011111111011110001101101010011010111111101111010111110011101111",
"0011111010001100111100110110101110111101111110101100000001111010",
"1011111111111001111001111111100110111111001001101100100101010010",
"1011111110101100111101100111000100111111100101101010110001110111",
"1011111101000001010100001101100000111101111010011011111001010010",
"1011111110101011001100000001011100111110110100001101101111101000",
"1011111101110010101101111010100000111111000111011100011011101001",
"0011111101000001110000010111001000111111011111100001101101110011",
"1011111001001010100101001110010110111111110101010001010101011101",
"1011111110001010110000111000100000111111110100111010000011110100",
"1011111110110001111110111000001000111111101001101101000101111100",
"0011111000011101000011001111010100111111111111100000010101011111",
"1011111111010111111110010110000110111110011010101100101000110001",
"1011111111001001011001001100111100111111111011000111110111101000",
"1011111111111101101000001001010100111111100011001100000100010000",
"0011111110100010011101011001000100111111101111001100010110001101",
"1011111111010100110001001101001110111110110011010011111011000001");

                                
                                  
signal fft_out     : INPUT_TYPE := (Others =>(Others => '0'));
signal tmp_stage_0 : INPUT_TYPE := (Others =>(Others => '0'));
signal tmp_stage_1 : INPUT_TYPE := (Others =>(Others => '0'));
signal tmp_stage_2 : INPUT_TYPE := (Others =>(Others => '0'));
signal tmp_stage_3 : INPUT_TYPE := (Others =>(Others => '0'));
signal tmp_stage_4 : INPUT_TYPE := (Others =>(Others => '0'));

---------------------------------------------
-----------TWIDDLE twiddle_factor = exp(-1i*2*pi*5/64); (MATLAB)) -------------
type tw_64_type is array (0 to 44) of std_logic_vector (63 downto 0);
type tw_16_type is array (0 to 8) of std_logic_vector (63 downto 0);
signal TW_64 : tw_64_type                   :=(
  "0011111101111110110001000110110110111101110010001011110100110110",
  "0011111101111011000101001011111010111110010001111100010111000010",
  "0011111101110100111110100000101110111110100101001010000000110001",
  "0011111101101100100000110101111010111110110000111110111100010101",
  "0011111101100001110001011001100010111110111100010101101011101010",
  "0011111101010100110110110011000110111111000011100011100111011010",
  "0011111101000101111001000000001110111111001000100110011110011001",
  "0011111100110101000001001111001110111111001101010000010011110011",
  "0011111100100010011001111001100110111111010001011110010000000011",
  "0011111100001110001110011101101010111111010101001101101100110001",
  "0011111011110001010110101110101010111111011000011100010110011000",
  "0011111011000011111011110001010110111111011011001000001101011110",
  "0011111010010100101000000011000110111111011101001111101000001011",
  "0011111001000111110001011100001010111111011110110001010010111110",
  "0011110111001000101111010011011010111111011111101100010001101101",
  "0010010010001101001100010011001010111111100000000000000000000000",
  "1011110111001000101111010011011010111111011111101100010001101101",
  "1011111001000111110001011100001010111111011110110001010010111110",
  "1011111010010100101000000011000110111111011101001111101000001011",
  "1011111011000011111011110001010110111111011011001000001101011110",
  "1011111011110001010110101110101010111111011000011100010110011000",
  "1011111100001110001110011101101010111111010101001101101100110001",
  "1011111100100010011001111001100110111111010001011110010000000011",
  "1011111100110101000001001111001110111111001101010000010011110011",
  "1011111101000101111001000000001110111111001000100110011110011001",
  "1011111101010100110110110011000110111111000011100011100111011010",
  "1011111101100001110001011001100010111110111100010101101011101010",
  "1011111101101100100000110101111010111110110000111110111100010101",
  "1011111101110100111110100000101110111110100101001010000000110001",
  "1011111101111011000101001011111010111110010001111100010111000010",
  "1011111101111110110001000110110110111101110010001011110100110110",
  "1011111110000000000000000000000010100101000011010011000100110010",
  "1011111101111110110001000110110100111101110010001011110100110110",
  "1011111101111011000101001011111000111110010001111100010111000010",
  "1011111101110100111110100000101100111110100101001010000000110001",
  "1011111101101100100000110101111000111110110000111110111100010101",
  "1011111101100001110001011001100000111110111100010101101011101010",
  "1011111101010100110110110011000100111111000011100011100111011010",
  "1011111101000101111001000000001100111111001000100110011110011001",
  "1011111100110101000001001111001100111111001101010000010011110011",
  "1011111100100010011001111001100100111111010001011110010000000011",
  "1011111100001110001110011101101000111111010101001101101100110001",
  "1011111011110001010110101110101000111111011000011100010110011000",
  "1011111011000011111011110001010100111111011011001000001101011110",
  "1011111010010100101000000011000100111111011101001111101000001011");
-----------TWIDDLE twiddle_factor = exp(-1i*2*pi*5/16); (MATLAB)) -------------

signal TW_16 :tw_16_type         := 
("0011111101101100100000110101111010111110110000111110111100010101",
"0011111100110101000001001111001110111111001101010000010011110011",
"0011111011000011111011110001010110111111011011001000001101011110",
"0010010010001101001100010011001010111111100000000000000000000000",
"1011111011000011111011110001010110111111011011001000001101011110",
"1011111100110101000001001111001110111111001101010000010011110011",
"1011111101101100100000110101111010111110110000111110111100010101",
"1011111110000000000000000000000010100101000011010011000100110010",
"1011111101101100100000110101111000111110110000111110111100010101");
--------------------------- END TWIDDLE -------------------------





-------------- component MUL -----------------------

component complex_process is
     Port ( 
           ar_0 : in std_logic_vector(31 downto 0); 
           ai_0 : in std_logic_vector(31 downto 0);
           tr : in std_logic_vector(31 downto 0); 
           ti : in std_logic_vector(31 downto 0); 
           ar_1 : in std_logic_vector(31 downto 0);
           ai_1 : in std_logic_vector(31 downto 0); 
           neg_byte : in integer;
           ----- OUTPUTS ---
           out_R : out std_logic_vector(31 downto 0);
           out_i : out std_logic_vector(31 downto 0)    );
    
end component;


-------------- component ADDER -----------------------

component COMPLEX_ADDER is
    port(
        z1_im     :  in std_logic_vector(31 downto 0);
        z2_im     : in std_logic_vector(31 downto 0) ;
        z1_re     : in std_logic_vector(31 downto 0);
        z2_re     : in std_logic_vector(31 downto 0);
        neg_byte     : in integer;
        result_re : out std_logic_vector(31 downto 0);
        result_im : out std_logic_vector(31 downto 0)
    
    );
end component;

-----------------END COMPONENT ----------------------

----------------COMPONENT SIGNALS ----------------------
       ----------- six generate ----------------
type six_type is array ( 0 to 7 ) of std_logic_vector(31 downto 0);
type add_type is array ( 0 to 7 ) of std_logic_vector(31 downto 0);
type ones is array ( 0 to 63 ) of std_logic;
type neg_type is array ( 0 to 7 ) of integer;

signal  a_z1_im      : add_type:=(others=>(others=>'0'));
signal  a_z2_im      : add_type:=(others=>(others=>'0'));
signal  a_z1_re      : add_type:=(others=>(others=>'0'));
signal  a_z2_re      : add_type:=(others=>(others=>'0'));
signal  neg_Byte,neg_Byte_j     : neg_type;

signal  a_result_re  : add_type ;
signal  a_result_im  : add_type ;
signal ar_0,ai_0,tr,ti,ar_1,ai_1 : six_type:=(others=>(others=>'0'));
signal out_r,out_i : six_type;

-------------------------   -j Multiplier --------------

component c_multiplier is
port(
        z1_im     : in std_logic_vector(31 downto 0);
        z2_im     : in std_logic_vector(31 downto 0) ;
        z1_re     : in std_logic_vector(31 downto 0);
        z2_re     : in std_logic_vector(31 downto 0);
        result_re : out std_logic_vector(31 downto 0);
        result_im : out std_logic_vector(31 downto 0)
    
    );
end component;





-------------------------   END COMPONENT --------------



----------------end COMPONENT SIGNALS ----------------------
signal state_ct : integer := 0;
------------------------------------------------------------
type stage_0_a_type   is array ( 0 to 47 ) of integer;
type stage_0_j_type   is array ( 0 to 15 ) of integer;

------------------------------------------------------------


type stage_1_type_a is array ( 0 to 18 ) of integer;
type stage_1_type_m is array ( 0 to 44 ) of integer;
type stage_3_type_a is array ( 0 to 27 ) of integer;
type stage_3_type_m is array ( 0 to 35 ) of integer;
type stage_result_type is array (0 to 63) of integer;

--------------------GENERAL NEG--------------------
type neg_type_stage is array (0 to 63) of integer;
signal neg_0 : neg_type_stage :=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
signal neg_1 : neg_type_stage :=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
signal neg_2 : neg_type_stage :=(0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1);
signal neg_3 : neg_type_stage :=(0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1);
signal neg_4 : neg_type_stage :=(0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1);
signal neg_5 : neg_type_stage :=(0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1);
signal neg_j :std_logic_vector(63 downto 0 ):=x"00000000bf800000";





----STAGE 0 ----

signal stg0_a_0 : stage_0_a_type   :=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47);
signal stg0_a_1 : stage_0_a_type   :=(32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
signal stg0_j_0 : stage_0_j_type   :=(48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63);
signal stg0_j_1 : stage_0_j_type   :=(16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31);
signal stg_0_ct_a        : integer := 0;
signal stg_0_ct_a_write  : integer := 0;
signal stg_0_ct_j        : integer := 0;
signal stg_0_ct_j_write  : integer := 0;

----STAGE 1 ----
signal stage1_0_a :stage_1_type_a  :=  (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,32,48); 
signal stage1_1_a :stage_1_type_a  :=  (16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0,48,32); 
signal stage1_0_m  :stage_1_type_m :=  (17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63);                                      
signal stage1_1_m  :stage_1_type_m :=  (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47);                                      
signal stage1_tw   :stage_1_type_m :=  (1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,2,5,8,11,14,17,20,23,26,29,32,35,38,41,44);                                
signal stg_1_ct_a        : integer := 0;
signal stg_1_ct_a_write  : integer := 0;
signal stg_1_ct_j        : integer := 0;
signal stg_1_ct_j_write  : integer := 0;

-- STAGE 2 
signal stg2_a_0 : stage_0_a_type   := (0,1,2,3,4,5,6,7,8,9,10,11,16,17,18,19,20,21,22,23,24,25,26,27,32,33,34,35,36,37,38,39,40,41,42,43,48,49,50,51,52,53,54,55,56,57,58,59);
signal stg2_a_1 : stage_0_a_type   := (8,9,10,11,12,13,14,15,0,1,2,3,24,25,26,27,28,29,30,31,16,17,18,19,40,41,42,43,44,45,46,47,32,33,34,35,56,57,58,59,60,61,62,63,48,49,50,51);
signal stg2_j_0 : stage_0_j_type   := (12,13,14,15,28,29,30,31,44,45,46,47,60,61,62,63);
signal stg2_j_1 : stage_0_j_type   := (4,5,6,7,20,21,22,23,36,37,38,39,52,53,54,55);
signal stg_2_ct_a        : integer := 0;
signal stg_2_ct_a_write  : integer := 0;
signal stg_2_ct_j        : integer := 0;
signal stg_2_ct_j_write  : integer := 0;

--// // STAGE 3  // // 

signal stage3_0_a :stage_3_type_a  := (0,1,2,3,4,8,12,16,17,18,19,20,24,28,32,33,34,35,36,40,44,48,49,50,51,52,56,60);
signal stage3_1_a :stage_3_type_a  := (4,5,6,7,0,12,8,20,21,22,23,16,28,24,36,37,38,39,32,44,40,52,53,54,55,48,60,56);
signal stage3_0_m  :stage_3_type_m := (5,6,7,9,10,11,13,14,15,21,22,23,25,26,27,29,30,31,37,38,39,41,42,43,45,46,47,53,54,55,57,58,59,61,62,63);
signal stage3_1_m  :stage_3_type_m := (1,2,3,13,14,15,9,10,11,17,18,19,29,30,31,25,26,27,33,34,35,45,46,47,41,42,43,49,50,51,61,62,63,57,58,59);
signal stage3_tw   :stage_3_type_m := (1,3,5,0,1,2,2,5,8,1,3,5,0,1,2,2,5,8,1,3,5,0,1,2,2,5,8,1,3,5,0,1,2,2,5,8);
signal stg_3_ct_a        : integer := 0;
signal stg_3_ct_a_write  : integer := 0;
signal stg_3_ct_j        : integer := 0;
signal stg_3_ct_j_write  : integer := 0;

--// // STAGE 4  // // 

signal stg4_a_0 : stage_0_a_type  := (0,1,2,4,5,6,8,9,10,12,13,14,16,17,18,20,21,22,24,25,26,28,29,30,32,33,34,36,37,38,40,41,42,44,45,46,48,49,50,52,53,54,56,57,58,60,61,62); 
signal stg4_a_1 : stage_0_a_type  := (2,3,0,6,7,4,10,11,8,14,15,12,18,19,16,22,23,20,26,27,24,30,31,28,34,35,32,38,39,36,42,43,40,46,47,44,50,51,48,54,55,52,58,59,56,62,63,60); 
signal stg4_j_0 : stage_0_j_type  := (3,7,11,15,19,23,27,31,35,39,43,47,51,55,59,63); 
signal stg4_j_1 : stage_0_j_type  := (1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61);  
signal stg_4_ct_a        : integer := 0 ;
signal stg_4_ct_a_write  : integer := 0 ;
signal stg_4_ct_j        : integer := 0 ;
signal stg_4_ct_j_write  : integer := 0 ;

--// // STAGE RESULT  // // 
signal stg5_a_0 : stage_result_type := (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63);
signal stg5_a_1 : stage_result_type := (1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14,17,16,19,18,21,20,23,22,25,24,27,26,29,28,31,30,33,32,35,34,37,36,39,38,41,40,43,42,45,44,47,46,49,48,51,50,53,52,55,54,57,56,59,58,61,60,63,62);
signal stg_5_ct_a        : integer := 0 ;
signal stg_5_ct_a_write  : integer := 0 ;
signal stg5_step :stage_result_type := (0,32,16,48,8,40,24,56,4,36,20,52,12,44,28,60,2,34,18,50,10,42,26,58,6,38,22,54,14,46,30,62,1,33,17,49,9,41,25,57,5,37,21,53,13,45,29,61,3,35,19,51,11,43,27,59,7,39,23,55,15,47,31,63);



begin
   
   MULTIPLIER_GEN   : for i in 0 to 7 generate   
   comp : complex_process   port map(
                                       ar_0  => ar_0(i),
                                       ai_0  => ai_0(i),
                                       tr    => tr(i),
                                       ti    => ti(i),
                                neg_Byte=>      neg_Byte_j(i),
                                       ar_1  => ar_1(i),
                                       ai_1  => ai_1(i),
                                       --out-
                                       out_R => out_r(i),
                                       out_i => out_i(i) ); end generate;

                                    
   SUBS_GEN   : for x in 0 to 7 generate                                    
   ADD_BLOCK : COMPLEX_ADDER  port map(
                                       z1_im     => a_z1_im(x)    ,  
                                       z2_im     => a_z2_im(x)    ,  
                                       z1_re     => a_z1_re(x)    ,  
                                       z2_re     => a_z2_re(x)    ,  
                                       neg_byte  => neg_Byte(x)   ,
                                       result_re => a_result_re(x),  
                                       result_im => a_result_im(x) );  end generate;  
    

   
   

                                                    

                              
    process(clk)

    begin
       
            if (rising_edge(clk)  and state_ct <6 ) then 
                  
              if (state_ct = 0) then
                     -----------STAGE 0 // 0-47 // ---------------
                      if   stg_0_ct_a < 48 then
                        for i in 0 to 7 loop
                                a_z1_im(i) <= fft_in(stg0_a_1(i + stg_0_ct_a))(31 downto  0);      
                                a_z2_im(i) <= fft_in(stg0_a_0(i + stg_0_ct_a))(31 downto  0);        
                                a_z1_re(i) <= fft_in(stg0_a_1(i + stg_0_ct_a))(63 downto 32);   
                                a_z2_re(i) <= fft_in(stg0_a_0(i + stg_0_ct_a))(63 downto 32);        
                               neg_Byte(i) <=  neg_0(stg0_a_0(i + stg_0_ct_a));
                               
                         end loop; stg_0_ct_a <= stg_0_ct_a + 8;

                        
                      
                      
                      end if;
                      
                      if  stg_0_ct_a /= 0 and stg_0_ct_a_write < 48 then
                         for i in 0 to 7 loop       
                             tmp_stage_0(stg0_a_0(i + stg_0_ct_a_write ))  <=  a_result_re(i) &   a_result_im(i);                       
                         end loop;
                         stg_0_ct_a_write <= stg_0_ct_a_write + 8;
                         
                      end if ;
                      
                      -----------STAGE 0 -J // 48-63 // ---------------
                      if   stg_0_ct_j < 16 then
                                
                             for i in 0 to 7 loop
                                  ar_0(i)       <= fft_in(stg0_j_0(i + stg_0_ct_j))(63 downto  32);    
                                  ai_0(i)       <= fft_in(stg0_j_0(i + stg_0_ct_j))(31 downto  0);   
                                    tr(i)       <= neg_j(63 downto  32);
                                    ti(i)       <= neg_j(31 downto 0);
                                  neg_Byte_j(i)   <=neg_0(stg0_j_0(i + stg_0_ct_j));
                                  ar_1(i)       <= fft_in(stg0_j_1(i + stg_0_ct_j))(63 downto  32);  
                                  ai_1(i)       <= fft_in(stg0_j_1(i + stg_0_ct_j))(31 downto  0); 
                                  
                              end loop; stg_0_ct_j <= stg_0_ct_j + 8;
                            
                              
                     end if ;
                     
                     if  stg_0_ct_j /= 0 and stg_0_ct_j_write < 16 then
                         for i in 0 to 7 loop       
                             tmp_stage_0(stg0_j_0(i + stg_0_ct_j_write))  <=  out_r(i) &   out_i(i);                       
                         end loop;
                         stg_0_ct_j_write <= stg_0_ct_j_write + 8;      end if ;
                         
                        if (stg_0_ct_a = 48 ) then state_ct <= 1; end if;
                     
                     
                        

                    
                        
               
              elsif(state_ct = 1) then
                        
                  
                        ------------ STAGE 1 ADD --------------------
                        if   stg_1_ct_a < 16 then
                            for i in 0 to 7 loop
                                a_z1_im(i) <= tmp_stage_0(stage1_1_a(i + stg_1_ct_a))(31 downto  0);      
                                a_z2_im(i) <= tmp_stage_0(stage1_0_a(i + stg_1_ct_a))(31 downto  0);        
                                a_z1_re(i) <= tmp_stage_0(stage1_1_a(i + stg_1_ct_a))(63 downto 32);   
                                a_z2_re(i) <= tmp_stage_0(stage1_0_a(i + stg_1_ct_a))(63 downto 32);        
                               neg_Byte(i) <= neg_1(stage1_0_a(i + stg_1_ct_a));

                            end loop;  stg_1_ct_a <= stg_1_ct_a + 8;

                           
                            
                       
                            
                      elsif(stg_1_ct_a = 16) then
                            for i in 0 to 2 loop
                                a_z1_im(i) <= tmp_stage_0(stage1_1_a(i + stg_1_ct_a ))(31 downto  0);      
                                a_z2_im(i) <= tmp_stage_0(stage1_0_a(i + stg_1_ct_a ))(31 downto  0);        
                                a_z1_re(i) <= tmp_stage_0(stage1_1_a(i + stg_1_ct_a ))(63 downto 32);   
                                a_z2_re(i) <= tmp_stage_0(stage1_0_a(i + stg_1_ct_a ))(63 downto 32);        
                               neg_Byte(i) <= neg_1(stage1_0_a(i + stg_1_ct_a));

                            end loop;    end if;
                  
                      
                      if  stg_1_ct_a /= 0 and stg_1_ct_a_write < 16 then
                         for i in 0 to 7 loop       
                             tmp_stage_1(stage1_0_a(i + stg_1_ct_a_write))  <=  a_result_re(i) &   a_result_im(i);     
                             stg_1_ct_a_write <= stg_1_ct_a_write + 8;   end loop;               
    
                         
                      elsif (stg_1_ct_a_write = 16) then
                       
                          for i in 0 to 2 loop   
                               tmp_stage_1(stage1_0_a(i + stg_1_ct_a_write ))  <=  a_result_re(i) &   a_result_im(i); end loop; end if ;
                         
                        ------   STAGE 1 MUL --------           
                        
                         if   stg_1_ct_j < 40 then
                                
                             for i in 0 to 7 loop
                                  ar_1(i)       <= tmp_stage_0(stage1_1_m(i + stg_1_ct_j))(63 downto 32);   
                                  ai_1(i)       <= tmp_stage_0(stage1_1_m(i + stg_1_ct_j))(31 downto 0);                                     
                                  ar_0(i)       <= tmp_stage_0(stage1_0_m(i + stg_1_ct_j))(63 downto 32); 
                                  ai_0(i)       <= tmp_stage_0(stage1_0_m(i + stg_1_ct_j))(31 downto 0); 
                                  tr(i)         <=        TW_64(stage1_tw(i + stg_1_ct_j))(63 downto 32);
                                  ti(i)         <=        TW_64(stage1_tw(i + stg_1_ct_j))(31 downto 0);
                                  neg_Byte_j(i) <=       neg_1(stage1_0_m(i + stg_1_ct_j));
                                 
                                  
                              end loop;  stg_1_ct_j <= stg_1_ct_j + 8;
                              
                        elsif (stg_1_ct_j = 40) then
                            for i in 0 to 4 loop
                                  ar_1(i)       <= tmp_stage_0(stage1_1_m(i + stg_1_ct_j))(63 downto 32);   
                                  ai_1(i)       <= tmp_stage_0(stage1_1_m(i + stg_1_ct_j))(31 downto 0);                                     
                                  ar_0(i)       <= tmp_stage_0(stage1_0_m(i + stg_1_ct_j))(63 downto 32); 
                                  ai_0(i)       <= tmp_stage_0(stage1_0_m(i + stg_1_ct_j))(31 downto 0); 
                                  tr(i)         <=        TW_64(stage1_tw(i + stg_1_ct_j ))(63 downto 32);
                                  ti(i)         <=        TW_64(stage1_tw(i + stg_1_ct_j ))(31 downto 0);
                                  neg_Byte_j(i) <=       neg_1(stage1_0_m(i + stg_1_ct_j));  end loop; 
                        
                        end if;    
                              
                     
                     
                     if  stg_1_ct_j /= 0 and stg_1_ct_j_write < 40 then
                         for i in 0 to 7 loop       
                             tmp_stage_1(stage1_0_m(i + stg_1_ct_j_write))  <=  out_r(i) &   out_i(i);
                                                      
                         end loop;
                         stg_1_ct_j_write <= stg_1_ct_j_write + 8;
                     elsif (stg_1_ct_j_write = 40) then
                        for i in 0 to 4 loop
                             tmp_stage_1(stage1_0_m(i + stg_1_ct_j_write))  <=  out_r(i) &   out_i(i); end loop;  end if ;
                     
                       if (stg_1_ct_j = 40 and stg_1_ct_j_write = 40) then
                            state_ct <= 2; end if;
                         
               
              elsif(state_ct = 2) then        
              
                          -----------STAGE 2 // ADD // ---------------
                      if   stg_2_ct_a < 48 then
                        for i in 0 to 7 loop
                                a_z1_im(i) <= tmp_stage_1(stg2_a_1(i + stg_2_ct_a))(31 downto  0);      
                                a_z2_im(i) <= tmp_stage_1(stg2_a_0(i + stg_2_ct_a))(31 downto  0);        
                                a_z1_re(i) <= tmp_stage_1(stg2_a_1(i + stg_2_ct_a))(63 downto 32);   
                                a_z2_re(i) <= tmp_stage_1(stg2_a_0(i + stg_2_ct_a))(63 downto 32);        
                               neg_Byte(i) <=  neg_2(stg2_a_0(i + stg_2_ct_a));
                               
                         end loop; stg_2_ct_a <= stg_2_ct_a + 8;

                        
                      
                      
                      end if;
                      
                      if  stg_2_ct_a /= 0 and stg_2_ct_a_write < 48 then
                         for i in 0 to 7 loop       
                             tmp_stage_2(stg2_a_0(i + stg_2_ct_a_write ))  <=  a_result_re(i) &   a_result_im(i);                       
                         end loop;
                         stg_2_ct_a_write <= stg_2_ct_a_write + 8;
                         
                      end if ;
                      
                      -----------STAGE 2 -J // // ---------------
                      if   stg_2_ct_j < 16 then
                                
                             for i in 0 to 7 loop
                                  ar_0(i)       <= tmp_stage_1(stg2_j_0(i + stg_2_ct_j))(63 downto  32);    
                                  ai_0(i)       <= tmp_stage_1(stg2_j_0(i + stg_2_ct_j))(31 downto  0);   
                                  neg_Byte_j(i)   <=neg_2(stg2_j_0(i + stg_2_ct_j));
                                  ar_1(i)       <= tmp_stage_1(stg2_j_1(i + stg_2_ct_j))(63 downto  32);  
                                  ai_1(i)       <= tmp_stage_1(stg2_j_1(i + stg_2_ct_j))(31 downto  0); 
                                  tr(i)       <= neg_j(63 downto  32);
                                  ti(i)       <= neg_j(31 downto 0);
                                  
                              end loop; stg_2_ct_j <= stg_2_ct_j + 8;
                            
                              
                     end if ;
                     
                     if  stg_2_ct_j /= 0 and stg_2_ct_j_write < 16 then
                         for i in 0 to 7 loop       
                             tmp_stage_2(stg2_j_0(i + stg_2_ct_j_write))  <=  out_r(i) &   out_i(i);                       
                         end loop;
                         stg_2_ct_j_write <= stg_2_ct_j_write + 8;      end if ;
                         
                        if (stg_2_ct_a = 48 ) then state_ct <= 3; end if;
                                  
                elsif(state_ct = 3) then    
                                
                             ------------ STAGE 3 ADD --------------------
                        if   stg_3_ct_a < 24 then
                            for i in 0 to 7 loop
                                a_z1_im(i) <= tmp_stage_2(stage3_1_a(i + stg_3_ct_a))(31 downto  0);      
                                a_z2_im(i) <= tmp_stage_2(stage3_0_a(i + stg_3_ct_a))(31 downto  0);        
                                a_z1_re(i) <= tmp_stage_2(stage3_1_a(i + stg_3_ct_a))(63 downto 32);   
                                a_z2_re(i) <= tmp_stage_2(stage3_0_a(i + stg_3_ct_a))(63 downto 32);        
                               neg_Byte(i) <= neg_3(stage3_0_a(i + stg_3_ct_a));

                            end loop;  stg_3_ct_a <= stg_3_ct_a + 8;

                           
                            
                       
                            
                      elsif(stg_3_ct_a = 24) then
                            for i in 0 to 3 loop
                                a_z1_im(i) <= tmp_stage_2(stage3_1_a(i + stg_3_ct_a ))(31 downto  0);      
                                a_z2_im(i) <= tmp_stage_2(stage3_0_a(i + stg_3_ct_a ))(31 downto  0);        
                                a_z1_re(i) <= tmp_stage_2(stage3_1_a(i + stg_3_ct_a ))(63 downto 32);   
                                a_z2_re(i) <= tmp_stage_2(stage3_0_a(i + stg_3_ct_a ))(63 downto 32);        
                               neg_Byte(i) <= neg_3(stage3_0_a(i + stg_3_ct_a));

                            end loop;    end if;
                  
                      
                      if  stg_3_ct_a /= 0 and stg_3_ct_a_write < 24 then
                         for i in 0 to 7 loop       
                             tmp_stage_3(stage3_0_a(i + stg_3_ct_a_write))  <=  a_result_re(i) &   a_result_im(i);     
                             stg_3_ct_a_write <= stg_3_ct_a_write + 8;   end loop;               
    
                         
                      elsif (stg_3_ct_a_write = 24) then
                       
                          for i in 0 to 3 loop   
                               tmp_stage_3(stage3_0_a(i + stg_3_ct_a_write ))  <=  a_result_re(i) &   a_result_im(i); end loop; end if ;
                         
                        ------   STAGE 3 MUL --------           
                        
                         if   stg_3_ct_j < 32 then
                                
                             for i in 0 to 7 loop
                                  ar_1(i)       <= tmp_stage_2(stage3_1_m(i + stg_3_ct_j))(63 downto 32);   
                                  ai_1(i)       <= tmp_stage_2(stage3_1_m(i + stg_3_ct_j))(31 downto 0);                                     
                                  ar_0(i)       <= tmp_stage_2(stage3_0_m(i + stg_3_ct_j))(63 downto 32); 
                                  ai_0(i)       <= tmp_stage_2(stage3_0_m(i + stg_3_ct_j))(31 downto 0); 
                                  tr(i)         <=        TW_16(stage3_tw(i + stg_3_ct_j))(63 downto 32);
                                  ti(i)         <=        TW_16(stage3_tw(i + stg_3_ct_j))(31 downto 0);
                                  neg_Byte_j(i) <=       neg_3(stage3_0_m(i + stg_3_ct_j));
                                 
                                  
                              end loop;  stg_3_ct_j <= stg_3_ct_j + 8;
                              
                        elsif (stg_3_ct_j = 32) then
                            for i in 0 to 3 loop
                                  ar_1(i)       <= tmp_stage_2(stage3_1_m(i + stg_3_ct_j))(63 downto 32);   
                                  ai_1(i)       <= tmp_stage_2(stage3_1_m(i + stg_3_ct_j))(31 downto 0);                                     
                                  ar_0(i)       <= tmp_stage_2(stage3_0_m(i + stg_3_ct_j))(63 downto 32); 
                                  ai_0(i)       <= tmp_stage_2(stage3_0_m(i + stg_3_ct_j))(31 downto 0); 
                                  tr(i)         <=        TW_16(stage3_tw(i + stg_3_ct_j ))(63 downto 32);
                                  ti(i)         <=        TW_16(stage3_tw(i + stg_3_ct_j ))(31 downto 0);
                                  neg_Byte_j(i) <=       neg_3(stage3_0_m(i + stg_3_ct_j));  end loop; 
                        
                        end if;    
                              
                     
                     
                     if  stg_3_ct_j /= 0 and stg_3_ct_j_write < 32 then
                         for i in 0 to 7 loop       
                             tmp_stage_3(stage3_0_m(i + stg_3_ct_j_write))  <=  out_r(i) &   out_i(i);
                                                      
                         end loop;
                         stg_3_ct_j_write <= stg_3_ct_j_write + 8;
                     elsif (stg_3_ct_j_write = 32) then
                        for i in 0 to 3 loop
                             tmp_stage_3(stage3_0_m(i + stg_3_ct_j_write))  <=  out_r(i) &   out_i(i); end loop;  end if ;
                     
                       if (stg_3_ct_j = 32 and stg_3_ct_j_write = 32) then
                            state_ct <= 4; end if;
                            
              elsif (state_ct = 4 ) then
              
                                -----------STAGE 4 // ADD // ---------------
                      if   stg_4_ct_a < 48 then
                        for i in 0 to 7 loop
                                a_z1_im(i) <= tmp_stage_3(stg4_a_1(i + stg_4_ct_a))(31 downto  0);      
                                a_z2_im(i) <= tmp_stage_3(stg4_a_0(i + stg_4_ct_a))(31 downto  0);        
                                a_z1_re(i) <= tmp_stage_3(stg4_a_1(i + stg_4_ct_a))(63 downto 32);   
                                a_z2_re(i) <= tmp_stage_3(stg4_a_0(i + stg_4_ct_a))(63 downto 32);        
                               neg_Byte(i) <=  neg_4(stg4_a_0(i + stg_4_ct_a));
                               
                         end loop; stg_4_ct_a <= stg_4_ct_a + 8;

                        
                      
                      
                      end if;
                      
                      if  stg_4_ct_a /= 0 and stg_4_ct_a_write < 48 then
                         for i in 0 to 7 loop       
                             tmp_stage_4(stg4_a_0(i + stg_4_ct_a_write ))  <=  a_result_re(i) &   a_result_im(i);                       
                         end loop;
                         stg_4_ct_a_write <= stg_4_ct_a_write + 8;
                         
                      end if ;
                      
                      -----------STAGE 4 -J // // ---------------
                      if   stg_4_ct_j < 16 then
                                
                             for i in 0 to 7 loop
                                  ar_0(i)       <= tmp_stage_3(stg4_j_0(i + stg_4_ct_j))(63 downto  32);    
                                  ai_0(i)       <= tmp_stage_3(stg4_j_0(i + stg_4_ct_j))(31 downto  0);   
                                  neg_Byte_j(i)   <=neg_4(stg4_j_0(i + stg_4_ct_j));
                                  ar_1(i)       <= tmp_stage_3(stg4_j_1(i + stg_4_ct_j))(63 downto  32);  
                                  ai_1(i)       <= tmp_stage_3(stg4_j_1(i + stg_4_ct_j))(31 downto  0); 
                                  tr(i)       <= neg_j(63 downto  32);
                                  ti(i)       <= neg_j(31 downto 0);
                                  
                              end loop; stg_4_ct_j <= stg_4_ct_j + 8;
                            
                              
                     end if ;
                     
                     if  stg_4_ct_j /= 0 and stg_4_ct_j_write < 16 then
                         for i in 0 to 7 loop       
                             tmp_stage_4(stg4_j_0(i + stg_4_ct_j_write))  <=  out_r(i) &   out_i(i);                       
                         end loop;
                         stg_4_ct_j_write <= stg_4_ct_j_write + 8;      end if ;
                         
                        if (stg_4_ct_a = 48 ) then state_ct <= 5; end if;
              
              
             elsif (state_ct = 5 ) then
                                        --//////// RESULT STAGE /////////--
                        -----------STAGE 0 // 0-47 // ---------------
                      if   stg_5_ct_a < 64 then
                        for i in 0 to 7 loop
                                a_z1_im(i) <= tmp_stage_4(stg5_a_1(i + stg_5_ct_a))(31 downto  0);      
                                a_z2_im(i) <= tmp_stage_4(stg5_a_0(i + stg_5_ct_a))(31 downto  0);        
                                a_z1_re(i) <= tmp_stage_4(stg5_a_1(i + stg_5_ct_a))(63 downto 32);   
                                a_z2_re(i) <= tmp_stage_4(stg5_a_0(i + stg_5_ct_a))(63 downto 32);        
                               neg_Byte(i) <=  neg_5(stg5_a_0(i + stg_5_ct_a));
                               
                         end loop; stg_5_ct_a <= stg_5_ct_a + 8;

                        
                      
                      
                      end if;
                      
                      if  stg_5_ct_a /= 0 and stg_5_ct_a_write < 64 then
                         for i in 0 to 7 loop       
                             FFT_OUT(stg5_step(i + stg_5_ct_a_write ))  <=  a_result_re(i) &   a_result_im(i);                       
                         end loop;
                         stg_5_ct_a_write <= stg_5_ct_a_write + 8;
                         
                      end if ;
                                      
              
              
                       
                            
              end if ;
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
            
            
            end if ;  
         
        
    
 
end process;
end Behavioral;


