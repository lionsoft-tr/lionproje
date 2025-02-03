ORG 0100H

JMP ba�la

yeni_sat�r               EQU 0AH   ; \n
geri_d�n��               EQU 0DH   ; \r
geri_al                  EQU 08H   ; \b


; 
; Sabit bir �ekilde kodlanm�� metin:
;
sabit_metin              DB      'Selam! Bu �ifrelenmi� bir mesajd�r', geri_d�n��, yeni_sat�r, '$'


girdi_metin              DB      259 dup ('$')               
                                                  
 
;                                                 
; Kullan�c�ya g�sterilecek mesajlar:
;
mesaj_ho�geldin           DB      yeni_sat�r, 'Monoalfabetik �ifreleme sistemine ho� geldiniz! ', geri_d�n��, yeni_sat�r
                          DB      'L�tfen nas�l i�lem yap�laca��n� se�in:', geri_d�n��, yeni_sat�r
                          DB      '1- Girdi metni (maksimum: 256 karakter)', geri_d�n��, yeni_sat�r
                          DB      '2- Sabit metni kullan', geri_d�n��, yeni_sat�r, '$'

mesaj_sabit_kullan�m     DB      '===============================', geri_d�n��, yeni_sat�r
                          DB      'SAB�T MET�N KULLANIYORSUNUZ' , geri_d�n��, yeni_sat�r
                          DB      '===============================', geri_d�n��, yeni_sat�r, '$'
                       
mesaj_girdi_kullan�m     DB      '===============================', geri_d�n��, yeni_sat�r
                          DB      'A�a��ya metninizi girin' , geri_d�n��, yeni_sat�r
                          DB      '===============================', geri_d�n��, yeni_sat�r, '$'
                       
mesaj_tekrar_deneyin     DB      geri_d�n��, yeni_sat�r, 'Bir denemeye daha ne dersiniz? (e/h)', geri_d�n��, yeni_sat�r, '$'

mesaj_tu�a_bas           DB      '��k�� yapmak i�in herhangi bir tu�a bas�n...$'                      

mesaj_�zg�n_metin        DB      geri_d�n��, yeni_sat�r, '�zg�n metniniz: $'                       
mesaj_�ifreli_metin      DB      geri_d�n��, '�ifrelenmi� mesaj: $'
mesaj_��z�lm��_metin     DB      geri_d�n��, '��z�lm�� mesaj: $'
mesaj_�ifreleme          DB      '�ifreleniyor...$'
mesaj_��zme              DB      '��z�l�yor...$'
                       


; Referans olarak --------------------->  'abcdefghijklmnopqrstuvwxyz'
�ifreleme_tablosu_k���k DB      97 dup (' '), 'qwertyuiopasdfghjklzxcvbnm'  
��zme_tablosu_k���k     DB      97 dup (' '), 'kxvmcnophqrszyijadlegwbuft'  
; Tablo ba�lamadan �nce 97 (61H) bo�luk b�rak�yoruz
; ��nk� 'a' karakterinin ASCII de�eri 61H
                                   
�ifreleme_tablosu_b�y�k DB      65 dup (' '), 'QWERTYUIOPASDFGHJKLZXCVBNM'  
��zme_tablosu_b�y�k     DB      65 dup (' '), 'KXVMCNOPHQRSZYIJADLEGWBUFT'
; Tablo ba�lamadan �nce 65 (41H) bo�luk b�rak�yoruz
; ��nk� 'A' karakterinin ASCII de�eri 41H


ba�la:                 
  
                       LEA     DX, mesaj_ho�geldin
                       MOV     AH, 09
                       INT     21H                    
                       MOV     AH, 0
                       INT     16H
                       CMP     AL, '2'        
                       JE      sabit_kullan
                       CMP     AL, '1'        
                       JNE     ba�la
                       CALL    girdi_al
                       JMP     i�lem_ba�lat
                       
sabit_kullan:          LEA     DX, mesaj_sabit_kullan�m
                       MOV     AH, 09
                       INT     21H
                       LEA     SI, sabit_metin 
                       
                                                                                        
i�lem_ba�lat:

; �zg�n metni g�ster
                       LEA     DX, mesaj_�zg�n_metin
                       MOV     AH, 09         
                       INT     21H             
                       LEA     DX, SI
                       MOV     AH, 09          
                       INT     21H             
                       
                                                                                                                      
; �ifreleme:             
                       LEA     DX, mesaj_�ifreleme   ; Mesaj� g�ster
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 1           ; AH de�erini ayarla ��nk� encrypt_decrypt i�lemi buna ba�l�
                       CALL    encrypt_decrypt ; AH = 1 monoalfabetik �ifreleme demektir, 0 monoalfabetik ��zme demektir, ba�ka de�erler i�lem yapmaz

; Sonucu ekranda g�ster:
                       LEA     DX, mesaj_�ifreli_metin
                       MOV     AH, 09          ; AH de�erini ayarla ��nk� int 21H i�lemi buna ba�l�
                       INT     21H             ; AH = 09 iken int 21H DS:DX'deki metni ��kart�r             
                       LEA     DX, SI
                       MOV     AH, 09          
                       INT     21H             

; ��zme:
                       LEA     DX, mesaj_��zme    ; Mesaj� g�ster
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 0           ; AH = 0 monoalfabetik ��zme demektir
                       CALL    encrypt_decrypt 
                    
; Sonucu ekranda g�ster:
                       LEA     DX, mesaj_��z�lm��_metin
                       MOV     AH, 09          ; AH de�erini ayarla ��nk� int 21H i�lemi buna ba�l�
                       INT     21H             ; AH = 09 iken int 21H DS:DX'deki metni ��kart�r             
                       LEA     DX, SI
                       MOV     AH, 09          
                       INT     21H

; Tekrar dene mesaj�n� g�ster
tekrar_dene:           LEA     DX, mesaj_tekrar_deneyin    
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 0
                       INT     16H
                       CMP     AL, 'e'
                       JE      ba�la
                       CMP     AL, 'h'
                       JNE     tekrar_dene
                       
                    
; Herhangi bir tu�a basmay� bekle...
                       LEA     DX, mesaj_tu�a_bas
                       MOV     AH, 09
                       INT     21H
                       MOV     AH, 0           ; AH de�erini ayarla ��nk� int 16H i�lemi buna ba�l�
                       INT     16H             ; AH = 00 iken int 16H klavyeden tu� vuru�unu bekler (yans�tmaz)       
                    
                       RET   
   
   
;   si - �ifrelenecek metnin adresi
encrypt_decrypt        PROC    NEAR
                       PUSH    SI
sonraki_karakter:      MOV     AL, [SI]
                	   CMP     AL, '$'         ; Metnin sonu mu?
                	   JE      metin_sonu
                	   	 
                	   CMP     AL, ' '         ;<--- Bo�luk kontrol�n�n ba�lang�c�
        	           JNE     devam_et        ; Bu bir �devdi ve gerekliliklerden biri bo�luklar� sonu�tan ��karmakt�, bu y�zden bu 4 sat�r� ve omit_space alt program�n� bo�luklar� kald�rmak istemiyorsan�z kald�rabilirsiniz.       	           
                       CALL    bo�luk_atla     
                       JMP     sonraki_karakter       ;<--- Bo�luk kontrol�n�n sonu
                       	
devam_et:              CALL    karakter_�ifrele_��z
    	               INC     SI	
            	       JMP     sonraki_karakter
metin_sonu:            POP     SI
                       RET            
encrypt_decrypt        ENDP


      
;
; Bo�luklar� metnin sonuna ( '$' sonras�) g�ndermek i�in alt program
; Bu alt program� gerek duymuyorsan�z silebilirsiniz
;
bo�luk_atla            PROC    NEAR    
                       PUSH    SI              ; Bo�lu�u '$' sonras� g�ndermemin nedeni
	                                           ; art arda gelen birka� bo�lu�u sonsuz d�ng�ye girmeden
bo�luk_atla_d�ng�:     MOV     AL, [SI+1]      ; bu karakterle de�i� toku� yaparak i�lemektir 
                       MOV     [SI+1], ' '     ; 
                       MOV     [SI], AL
                       INC     SI
                       CMP     [SI-1], '$'                      
                       JNE     bo�luk_atla_d�ng�
                       POP     SI  
                       RET
bo�luk_atla            ENDP    
                   
                   
                   
; Karakteri �ifreleme/��zme tablosu ile (b�y�k/k���k harf)
karakter_�ifrele_��z   PROC    NEAR
                       PUSH    BX    
                       CMP     AL, 'a'       
