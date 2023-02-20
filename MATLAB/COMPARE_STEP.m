clc ,clear all , close all ;


for x = 1:64
    if x < 33 
        neg_0(x) = 0;
    else
        neg_0(x) = 1;
    end
end

for x = 1:64
    if x < 17 
        neg_1(x) = 0;

    elseif x < 33 
        neg_1(x) = 1;
        
    elseif x < 49 
        neg_1(x) = 0;
     
    elseif x < 65 
        neg_1(x) = 1;

    end
end

for x = 1:64
    if x < 9 
        neg_2(x) = 0;

    elseif x < 17 
        neg_2(x) = 1;
        
    elseif x < 25 
        neg_2(x) = 0;
     
    elseif x < 33 
        neg_2(x) = 1;

    elseif x < 41 
       neg_2(x) =  0;
     
    elseif x < 49
     
        neg_2(x) = 1;

    elseif x < 57
        neg_2(x) = 0;
    
    elseif x < 65
        neg_2(x) = 1;    

    end
end

for x = 1:64
    if x < 5 
        neg_3(x) = 0;

    elseif x < 9 
        neg_3(x) = 1;
        
    elseif x < 13 
        neg_3(x) = 0;
     
    elseif x < 17 
        neg_3(x) = 1;

    elseif x < 21 
       neg_3(x) =  0;
     
    elseif x < 25
     
        neg_3(x) = 1;

    elseif x < 29
        neg_3(x) = 0;
    
    elseif x < 33
        neg_3(x) = 1;   
    
     elseif x < 37
        neg_3(x) = 0;     

     elseif x < 41
        neg_3(x) = 1;   

     elseif x < 45
        neg_3(x) = 0;  

     elseif x < 49
        neg_3(x) = 1;  

     elseif x < 53
        neg_3(x) = 0; 

      elseif x < 57
        neg_3(x) = 1;   

      elseif x < 61
        neg_3(x) = 0;   

      elseif x < 65
        neg_3(x) = 1;   

    end
end

for x = 1:64
    if x < 3 
        neg_4(x) = 0;

    elseif x < 5 
        neg_4(x) = 1;
        
    elseif x < 7 
        neg_4(x) = 0;
     
    elseif x < 9 
        neg_4(x) = 1;

    elseif x < 11 
       neg_4(x) =  0;
     
    elseif x < 13
     
        neg_4(x) = 1;

    elseif x < 15
        neg_4(x) = 0;
    
    elseif x < 17
        neg_4(x) = 1;   
    
     elseif x < 19
        neg_4(x) = 0;     

     elseif x < 21
        neg_4(x) = 1;   

     elseif x < 23
        neg_4(x) = 0;  

     elseif x < 25
        neg_4(x) = 1;  

     elseif x < 27
        neg_4(x) = 0; 

      elseif x < 29
        neg_4(x) = 1;   

      elseif x < 31
        neg_4(x) = 0;   

      elseif x < 33
        neg_4(x) = 1;   

       elseif x < 35
        neg_4(x) = 0;  

     elseif x < 37
        neg_4(x) = 1; 

      elseif x < 39
        neg_4(x) = 0;   

      elseif x < 41
        neg_4(x) = 1;   

      elseif x < 43
        neg_4(x) = 0;   


      elseif x < 45
        neg_4(x) = 1;  

     elseif x < 47
        neg_4(x) = 0; 

      elseif x < 49
        neg_4(x) = 1;   

      elseif x < 51
        neg_4(x) = 0;   

      elseif x < 53
        neg_4(x) = 1;

      elseif x < 55
        neg_4(x) = 0;  

     elseif x < 57
        neg_4(x) = 1; 

      elseif x < 59
        neg_4(x) = 0;   

      elseif x < 61
        neg_4(x) = 1;   

      elseif x < 63
        neg_4(x) = 0;

      elseif x < 65
        neg_4(x) = 1; 

    end
end
    for x = 1:64 

        if mod(x,2) == 0

            neg_5(x) = 1;
        else
            neg_5(x) = 0;
        end
    end

    fid = fopen('/Users/atakancakir/Desktop/ilkokul derslerim/fft/random_numbers.txt','r');

t = 0:1/32:0.49;

vhdl_out = zeros(16,1);


        for a = 1:64
        line_ex = fgetl(fid);  % read line excluding newline character
        
        real_part = typecast(uint32(bin2dec(line_ex)),'single');

        line_ex = fgetl(fid);  % read line excluding newline character
        
        imag_part = typecast(uint32(bin2dec(line_ex)),'single');
        
         vhdl_out(a,1) = complex(real_part,imag_part); 
         in_real(a,1) = real(vhdl_out(a,1));
         in_imag(a,1) = imag(vhdl_out(a,1));
        end
%% STG0
        stage0_0   =   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63];
        stage0_1   =   [32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];
%% STG 1                                     
        stage1_0_m =   [17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63];
        stage_1_1_m=   [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47];

        stage_1_tw =   [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45]; 
                        
        stage1_0_a =   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,32,48,]; 
        stage1_1_a =   [16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,0,48,32]; 
 %% STG 2
        stage2_1_a = [8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7,24,25,26,27,28,29,30,31,16,17,18,19,20,21,22,23,40,41,42,43,44,45,46,47,32,33,34,35,36,37,38,39,56,57,58,59,60,61,62,63,48,49,50,51,52,53,54,55]; 
        stage2_neg = [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1];
%% STG 3        
        stage3_0_a = [0,1,2,3,4,8,12,16,17,18,19,20,24,28,32,33,34,35,36,40,44,48,49,50,51,52,56,60];
        stage3_1_a = [4,5,6,7,0,12,8,20,21,22,23,16,28,24,36,37,38,39,32,44,40,52,53,54,55,48,60,56];

        stage3_0_m = [5,6,7,9,10,11,13,14,15,21,22,23,25,26,27,29,30,31,37,38,39,41,42,43,45,46,47,53,54,55,57,58,59,61,62,63];
        stage3_1_m = [1,2,3,13,14,15,9,10,11,17,18,19,29,30,31,25,26,27,33,34,35,45,46,47,41,42,43,49,50,51,61,62,63,57,58,59];

        stage3_tw  = [2,4,6,1,2,3,3,6,9,2,4,6,1,2,3,3,6,9,2,4,6,1,2,3,3,6,9,2,4,6,1,2,3,3,6,9]; 
%% STG 4

        stage4_a_1 = [2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13,18,19,16,17,22,23,20,21,26,27,24,25,30,31,28,29,34,35,32,33,38,39,36,37,42,43,40,41,46,47,44,45,50,51,48,49,54,55,52,53,58,59,56,57,62,63,60,61];
        stage4_neg = [0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1];
 %% STG 5       
        stage5_a_1 = [1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14,17,16,19,18,21,20,23,22,25,24,27,26,29,28,31,30,33,32,35,34,37,36,39,38,41,40,43,42,45,44,47,46,49,48,51,50,53,52,55,54,57,56,59,58,61,60,63,62]
        fft_res_que= [0,32,16,48,8,40,24,56,4,36,20,52,12,44,28,60,2,34,18,50,10,42,26,58,6,38,22,54,14,46,30,62,1,33,17,49,9,41,25,57,5,37,21,53,13,45,29,61,3,35,19,51,11,43,27,59,7,39,23,55,15,47,31,63];
        
        neg_i = 0.0000 - 1.0000i;
        all_neg = zeros(64,1);
        
        for x = 1:64

            fft_res_que(x) = fft_res_que(x) + 1;
            stage0_0(x) = stage0_0(x) + 1;
            stage0_1(x) = stage0_1(x) + 1;
            stage2_1_a(x) =  stage2_1_a(x) + 1;
            stage4_a_1(x) =  stage4_a_1(x) + 1;
            stage5_a_1(x) = stage5_a_1(x) + 1;

            
        end 

        for x = 1:19

            stage1_0_a(x) =  stage1_0_a(x)  + 1;
            stage1_1_a(x) =  stage1_1_a(x)  + 1;
        end

        for x = 1:45

            stage1_0_m(x) =  stage1_0_m(x)  + 1;
            stage_1_1_m(x) =  stage_1_1_m(x)  + 1;
        end

        for x = 1:28

            stage3_0_a(x) =  stage3_0_a(x)  + 1;
            stage3_1_a(x) =  stage3_1_a(x)  + 1;
        end

        for x = 1:36

            stage3_0_m(x) =  stage3_0_m(x)  + 1;
            stage3_1_m(x) =  stage3_1_m(x)  + 1;
        end


    
                              
 %%%%%%%%%%%%%   %%%%%%%%%%%%%% STAGE 0 %%%%%%%%%%%%%%   %%%%%%%%%%%%%%
       
        for n = 1:64 
        if n < 49
            if neg_0(n) == 0
                stg_0(stage0_0(n),1) = (vhdl_out(stage0_1(n))) + vhdl_out(stage0_0(n));
            else
                stg_0(stage0_0(n),1) = (vhdl_out(stage0_1(n))) - vhdl_out(stage0_0(n));
            end
        else
            if neg_0(n) == 0
                stg_0(stage0_0(n),1) = (neg_i) * ((vhdl_out(stage0_1(n))) + vhdl_out(stage0_0(n)))  ;
            else
                stg_0(stage0_0(n),1) = (neg_i) * ((vhdl_out(stage0_1(n))) - vhdl_out(stage0_0(n)))   ;
            end
        end
        end

           
      
        
    ct = 0;
%%%%%%%%%%%%%% %%%%%%%%%%%%%% STAGE 1 %%%%%%%%%%%%%% %%%%%%%%%%%%%%
        for ii = 1:45
            if neg_1(stage1_0_m(ii)) == 0
            stg_1(stage1_0_m(ii),1) = (exp(-1i*2*pi*stage_1_tw(ii)/64)) * (( stg_0(stage_1_1_m(ii))) + stg_0(stage1_0_m(ii))  );
            
            else
            stg_1(stage1_0_m(ii),1) = (exp(-1i*2*pi*stage_1_tw(ii)/64)) * (( stg_0(stage_1_1_m(ii))) - stg_0(stage1_0_m(ii))  );
            
            
            end
            
        end

        for ii = 1:19
             if neg_1(stage1_0_a(ii)) == 0
                stg_1(stage1_0_a(ii),1) = (stg_0(stage1_1_a(ii))) + (stg_0(stage1_0_a(ii)));
               
             else
                stg_1(stage1_0_a(ii),1) = (stg_0(stage1_1_a(ii))) - (stg_0(stage1_0_a(ii)));
                
             end
             
            
           
            
            
            
        end

        
 %%%%%%%%%%%%%% %%%%%%%%%%%%%%  STAGE 2    %%%%%%%%%%%%%% %%%%%%%%%%%%%%
        for ii = 1:64 
          if stage2_neg(ii) == 0
                 if neg_2(ii) == 0
                    stg_2(stage0_0(ii),1) = (stg_1(stage2_1_a(ii)))  + (stg_1(stage0_0(ii)));
                    
                  
                 else
                    stg_2(stage0_0(ii),1) = (stg_1(stage2_1_a(ii)))  - (stg_1(stage0_0(ii)));
                    
                 end
                 
          else
                 if neg_2(ii) == 0
                    stg_2(stage0_0(ii),1) = (neg_i) *  ((stg_1(stage2_1_a(ii))) + (stg_1(stage0_0(ii))))  ;
                    
                    

                 else
                    stg_2(stage0_0(ii),1) = (neg_i) *  ((stg_1(stage2_1_a(ii)))  - (stg_1(stage0_0(ii))))  ;
                    
                 end
          end 
         
        end
       
%%%%%%%%%%%%%% %%%%%%%%%%%%%% STAGE 3 %%%%%%%%%%%%%% %%%%%%%%%%%%%%
        for ii = 1:36
             if neg_3(stage3_0_m(ii)) == 0
             stg_3(stage3_0_m(ii),1) = (exp(-1i*2*pi*stage3_tw(ii)/16))  * (( stg_2(stage3_1_m(ii))) + stg_2(stage3_0_m(ii)) );
             
             else
             stg_3(stage3_0_m(ii),1) = (exp(-1i*2*pi*stage3_tw(ii)/16))  * (( stg_2(stage3_1_m(ii))) - stg_2(stage3_0_m(ii)) );
             
             end
            
        end 

       for ii = 1:28

           if neg_3(stage3_0_a(ii)) == 0
           stg_3(stage3_0_a(ii),1) = (stg_2(stage3_1_a(ii))) + (stg_2(stage3_0_a(ii)));
           else
           stg_3(stage3_0_a(ii),1) = (stg_2(stage3_1_a(ii))) - (stg_2(stage3_0_a(ii)));
           end
           
       end

%%%%%%%%%%%%%% %%%%%%%%%%%%%%%% STAGE 4 %%%%%%%%%%%%%% %%%%%%%%%%%%%%
       for ii = 1:64 
         if stage4_neg(ii) == 0
          
                if neg_4(ii) == 0
                   stg_4(stage0_0(ii),1) =  (stg_3(stage4_a_1(ii)))  + (stg_3(stage0_0(ii)));
               else
                   stg_4(stage0_0(ii),1) =  (stg_3(stage4_a_1(ii)))  - (stg_3(stage0_0(ii)));
               end
         else
                if neg_4(ii) == 0
                   stg_4(stage0_0(ii),1) =  (neg_i) * (stg_3(stage4_a_1(ii))  + stg_3(stage0_0(ii)))  ; %%% CONTROL
                   
               else
                   stg_4(stage0_0(ii),1) =  (neg_i) * (stg_3(stage4_a_1(ii))  - stg_3(stage0_0(ii)))  ;
               end
         
         end 
       end
%%%%%%%%%%%%%% %%%%%%%%%%%%%%%% STAGE 5 %%%%%%%%%%%%%% %%%%%%%%%%%%%%
       for ii = 1:64
           if neg_5(ii) == 0
            stg_5(fft_res_que(ii),1) = (stg_4(stage5_a_1(ii))) + (stg_4(stage0_0(ii)));
           else
            stg_5(fft_res_que(ii),1) = (stg_4(stage5_a_1(ii))) - (stg_4(stage0_0(ii)));
           end
           
       end
       
%%%%%%%%%%%% %%%%%%%%%%% COMPARE %%%%%%%%%%%% %%%%%%%%%%%%
        COMPARE = (fft(vhdl_out));
        COMPARE_US = (stg_5);

        
     %%%%%%%%%  WE CAN CHECK STEP BY STEP   %%%%%%%%%  
         for x = 1:64 
         disp("X"+num2str(x-1)+" <= """ + dec2hex(typecast(single(real(stg_5(x))),'uint32'),0)+""";" );
         end

       



