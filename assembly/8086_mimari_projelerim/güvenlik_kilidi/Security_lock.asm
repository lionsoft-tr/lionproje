include emu8086.inc
.MODEL SMALL
.DATA   
        ;I    DB 0d
        SIZE EQU 10
        HEAD DB '________________Guvenlik Kilidi________________','$'
        MSG1 DB 13, 10, 'Id giriniz:$'
        MSG2 DB 13, 10, 'sifrenizi giriniz:$'
        MSG3 DB 13, 10, 'ERROR Id bulunamadı!$'
        MSG4 DB 13, 10, 'Yanlıs sifre! Giris basarısız$'
        MSG5 DB 13, 10, 'Dogru! sisteme hosgeldiniz$'
        MSG6 DB 13, 10, 'Sifre cok uzun amk!$'
        TEMP_ID DW 1 DUP(?),0
        TEMP_Pass DB 1 DUP(?)
        IDSize = $-TEMP_ID                    
        PassSize = $-Temp_Pass
        ID  DW        'A11', 'said', 'yufus', 'emir', 'CppBey',  
        Sifre  DB      '1,       2,  yufus3,  emir4, saidsakso',
    
.CODE
MAIN        PROC
            MOV AX,@DATA
            MOV DS,AX
            MOV AX,0000H
            

Title:      LEA DX,HEAD
            MOV AH,09H
            INT 21H

Id_Girisi:  LEA DX,MSG1
            MOV AH,09H
            INT 21H
            
            
Input:   MOV BX,0
            MOV DX,0
            LEA DI,TEMP_ID
            MOV DX,IDSize
            CALL get_string
            

Kontrol:    MOV BL,0
            MOV SI,0

Tekrar:      MOV AX,ID[SI] 
            MOV DX,TEMP_ID
            CMP DX,AX
            JE  Sifre_Girisi
            INC BL
            ADD SI,4
            CMP BL,SIZE
            JB  Tekrar
            
HATAMSJ:   LEA DX,MSG3
            MOV AH,09H
            INT 21H
            JMP Id_Girisi
             
            
Sifre_Girisi:LEA DX,MSG2
            MOV AH,09H
            INT 21H
            
Pass_INPUT: CALL   scan_num
            CMP    CL,0FH
            JAE    TooLong
            MOV    BH,00H
            MOV    DL,Sifre[BX]
            CMP    CL,DL
            JE     CORRECT 

            
INCORRECT:  LEA DX,MSG4
            MOV AH,09H
            INT 21H
            JMP Id_Girisi
            
CORRECT:    LEA DX,MSG5
            MOV AH,09H
            INT 21H
            JMP Terminate

TooLong:    LEA DX,MSG6
            MOV AH,09H
            INT 21H
            JMP Sifre_Girisi
            

DEFINE_SCAN_NUM
DEFINE_GET_STRING
Terminate:        
END MAIN        
        
    
     