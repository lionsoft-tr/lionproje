import zlib
import base64
import signal
import sys

def obfuscate_yap(script):
    compressed_encoded_script = base64.b64encode(zlib.compress(script.encode())).decode()
    reversed_script = compressed_encoded_script[::-1]
    obfuscated_script = f'_ = lambda __ : __import__("zlib").decompress(__import__("base64").b64decode(__[::-1]));exec((_)(b"{reversed_script}"))'
    return obfuscated_script

def scripti_oku(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.read()

def scripti_yaz(file_path, script):
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(script)

def signal_handler(sig, frame):
    print('Ctrl+C basıldı. Program kapatılıyor...')
    sys.exit(0)

if __name__ == "__main__":
    import argparse

    signal.signal(signal.SIGINT, signal_handler)

    parser = argparse.ArgumentParser(description="Python scriptini obfuscate et")
    parser.add_argument("input_file", help="Şifrelemek istediğiniz dosyanın ismi & yolu")
    parser.add_argument("output_file", help="Çıktınının yolu & ismi")

    args = parser.parse_args()

    original_script = scripti_oku(args.input_file)
    obfuscated_script = obfuscate_yap(original_script)
    scripti_yaz(args.output_file, obfuscated_script)