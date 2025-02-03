# -*- coding: UTF-8 -*-

# Date    : 17-07-2024



#============================ İMPORT ============================#

import os, base64, sys, time;from pprint import pformat;import webbrowser

#============================ FONKSİYONLAR & DEĞERLER ============================#

def clearat():
    os.system("clear")

def seceneksifir():
    sprint(bilgi+"Programdan çıkılıyor, kendine cici bak <33")
    time.sleep(1)
    exit()

alfabe = [
    "\U0001f600",
    "\U0001f603",
    "\U0001f604",
    "\U0001f601",
    "\U0001f605",
    "\U0001f923",
    "\U0001f602",
    "\U0001f609",
    "\U0001f60A",
    "\U0001f61b",
]

MAX_STR_LEN = 70
OFFSET = 10

black="\033[0;30m"
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"  
blue="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
white="\033[0;37m"

soru = green + '\n[' + white + '?' + green + '] '+ yellow
basarili = green + '\n[' + white + '√' + green + '] '
hata = red + '\n[' + white + '!' + red + '] '
bilgi= yellow + '\n[' + white + '+' + yellow + '] '+ cyan

pwd=os.getcwd()

baner=f'''
{blue}   ███████╗    ██╗    ██╗     █████╗    
{white}   ██╔════╝    ██║    ██║    ██╔══██╗  
{red}   █████╗      ██║ █╗ ██║    ███████║
{white}   ██╔══╝      ██║███╗██║    ██╔══██║
{blue}   ███████╗    ╚███╔███╔╝    ██║  ██║
{white}   ╚══════╝     ╚══╝╚══╝     ╚═╝  ╚═╝ 
{cyan}                                   [Geliştirici ~ eware0]
''' 

def sprint(sentence, second=0.05):
    for word in sentence + '\n':
        sys.stdout.write(word)
        sys.stdout.flush()
        time.sleep(second)

def hakkimda():
    clearat()
    sprint(baner, 0.1)
    print(f"{cyan}[Tool_İsmi] {purple} :[E-fuscater]")
    print(f"{cyan}[Version]   {purple} :[1.0]")
    print(f"{cyan}[Author]    {purple} :[eware0]")
    print(f"{cyan}[Github]    {purple} :[https://github.com/softwarEWA]")
    print(f"{cyan}[Telegram]  {purple} :[https://t.me/eware0]")
    print(f"{cyan}[İnstagram] {purple} :[https://instagram.com/eware0]\n")
    ret=input(soru+"menüye gitmek için 1, çıkmak için 0 > "+green)
    if ret=="1":
        main()
    else: 
        seceneksifir()


#============================  ÇIKTININ YOLUNU SEC HELELEL  ============================#
def mover(cıktı_dosyası):
    move= input(soru+"Çıktıyı farklı biryere kayıt etmek istermisin ? (e/h) > "+green)
    if move=="e":
        mpath=input(soru+"Yolu giriniz > "+ green)
        if os.path.exists(mpath):
            os.system(f'''move "{cıktı_dosyası}" "{mpath}"''')
            sprint(f"{basarili}{cıktı_dosyası} dosyası {mpath}'ına taşındı\n")
        else:
            sprint(hata+"Öyle bir yol yok ?!\n")
            print("ANA MENÜYE DÖNÜLÜYOR")
            return
    else:
        print("\n")
    exit()

#============================  SENİ BAGLAMAYAN İŞLEMLER  ============================#
def obfuscate(DEGİSKEN_İ, file_content):
    b64_content = base64.b64encode(file_content.encode()).decode()
    index = 0
    code = f'{DEGİSKEN_İ} = ""\n'
    for _ in range(int(len(b64_content) / OFFSET) + 1):
        _str = ''
        for char in b64_content[index:index + OFFSET]:
            byte = str(hex(ord(char)))[2:]
            if len(byte) < 2:
                byte = '0' + byte
            _str += '\\x' + str(byte)
        code += f'{DEGİSKEN_İ} += "{_str}"\n'
        index += OFFSET
    code += f'exec(__import__("\\x62\\x61\\x73\\x65\\x36\\x34").b64decode({DEGİSKEN_İ}.encode("\\x75\\x74\\x66\\x2d\\x38")).decode("\\x75\\x74\\x66\\x2d\\x38"))'
    return code
def chunk_string(in_s, n):
    """String'i maksimum n uzunluğunda parçalara ayır"""
    return "\n".join(
        "{}\\".format(in_s[i : i + n]) for i in range(0, len(in_s), n)
    ).rstrip("\\")
def encode_string(in_s, alfabe):
    d1 = dict(enumerate(alfabe))
    d2 = {v: k for k, v in d1.items()}
    return (
        'exec("".join(map(chr,[int("".join(str({}[i]) for i in x.split())) for x in\n'
        '"{}"\n.split("  ")])))\n'.format(
            pformat(d2),
            chunk_string(
                "  ".join(" ".join(d1[int(i)] for i in str(ord(c))) for c in in_s),
                MAX_STR_LEN,
            ),
        )
    )

#============================  PYTHON KODUNU BENİM SİKKO SCRİPT İLE ŞİFRELEYEN CART CURT ANASINI SİKEYİM BÖYLE İŞİN 
def obfspyc():

    dosyaadisikis = input(soru + "Dosya adını uzantısı ile beraber girin > "+cyan)

    if not os.path.exists(dosyaadisikis):

        sprint(hata+'Dosya bulunamadı ?')

        clearat()

        obfspyc()

    os.system("python pythonobfuscate.py " + dosyaadisikis+" obfuscated.py")

    cıktı_dosyası= input(soru + "Çıktı ismini uzantısı ile beraber giriniz  > " + green)   

    with open("obfuscated.py",'r') as temp_f, open(cıktı_dosyası,'w') as out_f:

        filedata = temp_f.read() 

        out_f.write("# Encrypted by E-fuscater\n# Github- https://github.com/softwarEWA\n\n"+filedata)

    os.remove("obfuscated.py")

    sprint(f"{basarili}{cıktı_dosyası}'projesi başarı ile {pwd} konumuna kayıt edildi")

    mover(cıktı_dosyası)

    main()

#============================ BAT DOSYASI ŞİFRELEME ============================#
def obfbc():

    input_filename = input("Şifrelemek istediğiniz Batch dosyasının adını yazın: ")

    if not os.path.exists(input_filename):

        print("Hata: Belirttiğiniz dosya bulunamadı!")
        clearat()

        obfbc()

    os.system(f'bash bat.sh {input_filename} obfuscated.bat')
    print(f"Başarılı: {input_filename} dosyası başarıyla kaydedildi.")
    main()

# Encrypting python file into base64 variable, easily decryptable  # K-FUSCATER PROJESİNDEN ALINTI !!!!!
def encryptvar():
    var= input(soru + "Kullanılacak kelimeyi yazınız{red}(GEREKLİ)  > " + green)
    if (var==""):
        sprint(hata + "Kelimeyi yazmadınız")
        time.sleep(3)
        encryptvar()
    if (var.find(" ")!= -1):
        sprint(hata+"Sadece 1 kelime girin lütfen")
        time.sleep(3)
        encryptvar()
    iteration = input(soru + "Değişkenin tekrarlanma sayısı  > " + green)
    try:
        iteration = int(iteration)
    except Exception:
        iteration = 50
    DEGİSKEN_İ = var * iteration
    dosyaadisikis = input(soru+ "Dosya adını uzantısı ile beraber girin  > "+cyan)
    if not os.path.isfile(dosyaadisikis):
        print(hata+'Dosya bulunamadı')
        time.sleep(2)
        encryptvar()
    cıktı_dosyası = input(soru + "Çıktının adını uzantısı ile giriniz > " + green)
    with open(dosyaadisikis, 'r', encoding='utf-8', errors='ignore') as in_f,open(cıktı_dosyası, 'w') as out_f:
       file_content = in_f.read()
       obfuscated_content = obfuscate(DEGİSKEN_İ, file_content)
       out_f.write("# Encrypted by E-Fuscater\n# Github- https://github.com/softwarEWA\n\n"+obfuscated_content)
    sprint(f"{basarili}{cıktı_dosyası}'projesi başarı ile {pwd} konumuna kayıt edildi")
    mover(cıktı_dosyası)

#============================  EMOJİ İLE ŞİFRELEME  ============================#
def encryptem():
    dosyaadisikis= input(soru +"Dosya adını uzantısı ile beraber girin  > "+cyan )
    if not os.path.isfile(dosyaadisikis):
        print(hata+' Dosya bulunamadı')
        time.sleep(2)
        encryptem()
    cıktı_dosyası= input(soru + "Çıktının adını uzantısı ile giriniz > " + green)
    with open(dosyaadisikis) as in_f, open(cıktı_dosyası, "w", encoding="utf-8") as out_f:
        out_f.write("# Encrypted by E-Fuscater\n# Github- https://github.com/softwarEWA\n\n")
        out_f.write(encode_string(in_f.read(), alfabe))
        sprint(f"{basarili}{cıktı_dosyası}'projesi başarı ile {pwd} konumuna kayıt edildi")
        mover(cıktı_dosyası)





#============================ MAİN FONKSİYONU ============================#
def main():
    clearat()
    sprint(baner, 0.01)
    print(f"{green}[1]{cyan} Python kodunu{red} karmaşıklaştır (obfuscate)")
    print(f"{green}[2]{red} .bat dosyasını şifrele")
    print(f"{green}[3]{cyan} Python kodunu bir değişkenle{red} Şifrele")
    print(f"{green}[4]{yellow} Python kodunu {red}Emojiler ile{cyan} Şifrele")
    print(f"{green}[5]{yellow} Diğer toollarım")
    print(f"{green}[6]{yellow} Hakkımda")
    print(f"{green}[0]{yellow} Çıkış")
    choose = input(f"{soru}{blue}Bir seçim yap : {cyan}")
    while True:
        if choose == "1" or choose=="01":
            obfspyc()
        elif choose == "2" or choose=="02":
            obfbc()
        elif choose == "3" or choose=="03":
            encryptvar()
        elif choose == "4" or choose=="04":
            encryptem()
        elif choose == "5" or choose=="05":
            # TERMUX KULLANIYORSA 
            if os.path.exists("/data/data/com.termux/files/home"):
                os.system("xdg-open --view 'https://github.com/softwarEWA'")
            else:# YAKINDA AYNI TOOLU DİĞER SİSTEMLEREDE YAZICAM ŞİMDİLİK BUKADARI YETERLİ
                webbrowser.open('https://github.com/softwarEWA')
            main()
        elif choose == "6" or choose=="06":
            hakkimda()
        elif choose == "0":
            seceneksifir()
        else:
            sprint(hata+'Yanlış seçim !!')
            time.sleep(2)
            main()



if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        sprint(bilgi+"yapma gadasım etme gadasım az bekle bitsin islemin yahu amma inatcısın")
        exit()
    except Exception as e:
        sprint(hata+str(e))