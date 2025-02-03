              ORG 0100H

JMP start

newline                 EQU 0AH  ; /n
cret                    EQU 0DH  ; /n
bcksp                   EQU 08H  ; /b


;
; Hard-coded string:
;                                           
hardcoded_string        DB      'sifrelenmis mesaj !!!', cret, newline, '$'

input_string            DB      259 dup ('$')

;
;gotten yemis ui tasarýmým
;
hosgeldin_mesazi   DB  newline, 'Caesar sifreleme sistemine hosgeldiniz!!! ', cret, newline
                   DB  'lutfen bekle su alýp gelicem
                   DB  '1 metin girin (max 256)', cret, newline
                   DB  '2 hard-coded kullan', cret, newline, '$'
                   
                   
                   
                   
                
message_using      DB      '===========================', cret, newline
                   DB      'gir' cret, newline
                   DB      '===========================', cret, newline, '$' 
                   
                   
                   
                    
                    
                    
   
                