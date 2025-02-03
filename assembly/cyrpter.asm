
ORG 0100H

JMP start

newline                EQU 0AH   ; \n
cret                   EQU 0DH   ; \r
bcksp                  EQU 08H   ; \b


; 
; Hard-coded string:
;
hardcoded_string       DB      'Selam! Bu sifrelenmis bi mesajdir', cret, newline, '$'


input_string           DB      259 dup ('$')               
                                                  
 
;                                                 
; uideki gosterilecek seyler:
;
message_welcome        DB      newline, 'Monoalfabetik sifreleme sistemine hosgeldinieeeaaaz! ', cret, newline
                       DB      'lutfen nasil islenicegini sec:', cret, newline
                       DB      '1- input string (max: 256 chars)', cret, newline
                       DB      '2- hard string kullan xd', cret, newline, '$'

message_using_hc       DB      '===============================', cret, newline
                       DB      'USING YOUR HARDCODED STRING' , cret, newline
                       DB      '===============================', cret, newline, '$'
                       
message_using_input    DB      '===============================', cret, newline
                       DB      'asag�ya stringini gir la' , cret, newline
                       DB      '===============================', cret, newline, '$'
                       
message_try_again      DB      cret, newline, 'bir denemeye daha nedersin? (y/n)', cret, newline, '$'

message_press_key      DB      'herhangi bir tusa basarak c�k�s yap...$'                      

message_display_org    DB      cret, newline, 'Orjinal stringin: $'                       
message_display_enc    DB      cret, 'sifrelenmis mesaj: $'
message_display_dec    DB      cret, 'decrypted mesajj: $'
message_encrypting     DB      'encrypt ediliyuuu...$'
message_decrypting     DB      'decleniyuuuu...$'
                       


; Just for reference --------------------->  'abcdefghijklmnopqrstuvwxyz'
encryption_table_lower DB      97 dup (' '), 'qwertyuiopasdfghjklzxcvbnm'  
decryption_table_lower DB      97 dup (' '), 'kxvmcnophqrszyijadlegwbuft'  
; We leave 97(61H) blank spaces before the start of the table
; as the ASCII value of 'a' = 61H
                                   
encryption_table_upper DB      65 dup (' '), 'QWERTYUIOPASDFGHJKLZXCVBNM'  
decryption_table_upper DB      65 dup (' '), 'KXVMCNOPHQRSZYIJADLEGWBUFT'
; We leave 65(41H) blank spaces before the start of the table
; as the ASCII value of 'A' = 41H


start:                 
  
                       LEA     DX, message_welcome
                       MOV     AH, 09
                       INT     21H                    
                       MOV     AH, 0
                       INT     16H
                       CMP     AL, '2'        
                       JE      use_hc
                       CMP     AL, '1'        
                       JNE     start
                       CALL    get_input
                       JMP     start_process
                       
use_hc:                LEA     DX, message_using_hc
                       MOV     AH, 09
                       INT     21H
                       LEA     SI, hardcoded_string 
                       
                                                                                        
start_process:

; Display original string
                       LEA     DX, message_display_org
                       MOV     AH, 09         
                       INT     21H             
                       LEA     DX, SI
                       MOV     AH, 09          
                       INT     21H             
                       
                                                                                                                      
; Encrypt:             
                       LEA     DX, message_encrypting   ; Display message
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 1           ; value of AH is adjusted as operation of encrypt_decrypt depends on its value
                       CALL    encrypt_decrypt ; AH = 1 means monoalphabetic encryption, 0 means monoalphabetic decryption, else do nothing

; Display result on the screen:
                       LEA     DX, message_display_enc
                       MOV     AH, 09          ; value of AH is adjusted as operation of int 21H depends on its value
                       INT     21H             ; at AH = 09, int 21H outputs string at DS:DX             
                       LEA     DX, SI
                       MOV     AH, 09          
                       INT     21H             

; Decrypt:
                       LEA     DX, message_decrypting    ; Display message
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 0           ; AH = 0 means monoalphabetic decryption
                       CALL    encrypt_decrypt 
                    
; Display result on the screen:
                       LEA     DX, message_display_dec
                       MOV     AH, 09          ; value of AH is adjusted as operation of int 21H depends on its value
                       INT     21H             ; at AH = 09, int 21H outputs string at DS:DX             
                       LEA     DX, SI
                       MOV     AH, 09          
                       INT     21H

;Display try again dialogue
try_again:             LEA     DX, message_try_again    
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 0
                       INT     16H
                       CMP     AL, 'y'
                       JE      start
                       CMP     AL, 'n'
                       JNE     try_again
                       
                    
; Wait for any key...
                       LEA     DX, message_press_key
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 0           ; value of AH is adjusted as operation of int 16H depends on its value
                       INT     16H             ; at AH = 00, int 16H waits for keystroke from the keyboard (no echo)       
                    
                       RET   
   
   
;   si - address of string to encrypt
encrypt_decrypt        PROC    NEAR
                       PUSH    SI
next_char:             MOV     AL, [SI]
                	   CMP     AL, '$'         ; End of string?
                	   JE      end_of_string
                	   	 
                	   CMP     AL, ' '         ;<--- Beginning of space check
        	           JNE     cont            ; Since this was a college assignment, One of my requirements was to omit spaces in my result so
	                   CALL    omit_space      ; you can just remove these 4 lines and the omit_space subroutine if you do not wish to do that.       	           
                       JMP     next_char       ;<--- End of space check
                       	
cont:                  CALL    enc_dec_char
    	               INC     SI	
            	       JMP     next_char
end_of_string:         POP     SI
                       RET            
encrypt_decrypt        ENDP


      
;
; Subroutine to send space to the end of the string (after '$')
; You can delete this subroutine if you do not need it
;
omit_space             PROC    NEAR    
                       PUSH    SI              ; The reason I send the space after the '$'
	                                           ; is to handle several consecutive spaces without
omit_space_loop:       MOV     AL, [SI+1]      ; entering an inifnite loop as opposed to just swapping
                       MOV     [SI+1], ' '     ; the ' ' character with the character after it 
                       MOV     [SI], AL
                       INC     SI
                       CMP     [SI-1], '$'                      
                       JNE     omit_space_loop
                       POP     SI  
                       RET
omit_space             ENDP    
                   
                   
                   
; Subroutine to convert character with the
; appropriate table (encrypt/decrypt)(uppercase/lowercase)
enc_dec_char           PROC    NEAR
                       PUSH    BX    
                       CMP     AL, 'a'       
                       JB      check_upper_char
                       CMP     AL, 'z'
                       JA      skip_char
                       CMP     AH, 1          ; AH = 1 means monoalphabetic encryption, since we are working with lower case, we use encryption_table_lower
                       JE      encrypt_lower_char
                       CMP     AH, 0          ; AH = 0 means monoalphabetic decryption, since we are working with lower case, we use decryption_table_lower
                       JNE     skip_char
                       LEA     BX, decryption_table_lower
                       JMP     translate_char                     
encrypt_lower_char:	   LEA     BX, encryption_table_lower 
                	   JMP     translate_char                	
check_upper_char:      CMP     AL, 'A'
                       JB      skip_char
                       CMP     AL, 'Z'
                       JA      skip_char
                       CMP     AH, 1          ; AH = 1 means monoalphabetic encryption, since we are working with upper case, we use encryption_table_upper
                	   JE      encrypt_upper_char
                	   CMP     AH, 0          ; AH = 0 means monoalphabetic decryption, since we are working with upper case, we use decryption_table_upper
                       JNE     skip_char
                       LEA     BX, decryption_table_upper
                       JMP     translate_char 
encrypt_upper_char:    LEA     BX, encryption_table_upper	
translate_char:        XLATB
	                   MOV     [SI], AL	                		
skip_char:             POP     BX
                       RET
enc_dec_char           ENDP



; Subroutine to take input string from the user
; The subroutine handles if the user presses backspace: delete char + inc CX
; The subroutine allows the user to enter a maximum of 256 chars 
get_input              PROC    NEAR
                       LEA     DX, message_using_input
                       MOV     AH, 09
                       INT     21H
                       LEA     SI, input_string
                       MOV     AH, 1
                       MOV     CX, 255        ; To set a cap for string input to 256 chars            
                       JMP     input_loop
backspace_entered:     INC     CX             ; Increment CX in case user presses backspace as a character is deleted
input_loop:            INT     21H                                                      
                       MOV     [SI], AL
                       CMP     AL, bcksp
                       JNE     cont_input                     
                       CMP     SI, offset input_string  
                       JE      input_loop     ;If the string is empty just loop again without affecting SI and without incrementing CX                    
                       MOV     [SI], ' '
                       CALL    omit_space
                       DEC     SI                      
                       JMP     backspace_entered                                            
cont_input:            INC     SI
                       CMP     AL, cret
                       JE      terminate_string                   
                       LOOP    input_loop     ; LOOP instead of JMP to incorporate (CX != 0000H) as a jump condition                                              
terminate_string:      MOV     [SI-1], cret
                       MOV     [SI], newline
                       MOV     [SI+1], '$'
                       LEA     SI, input_string
                       RET
get_input              ENDP
        
end
       