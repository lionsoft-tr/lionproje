#!/bin/bash


if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Kullanım: $(basename "$0") input_file output_file"
  exit 1
fi


if [ ! -f "$1" ]; then
  echo "Giriş dosyası bulunamadı: $1"
  exit 1
fi


output_file="$2"
if [[ "$output_file" != *.* ]]; then
  echo "Çıkış dosyası için bir uzantı belirtmelisiniz: $(basename "$0") input_file output_file"
  exit 1
fi

valid_extensions=("bat" "cmd")
file_ext="${1##*.}"
valid=false

for ext in "${valid_extensions[@]}"; do
  if [[ "$file_ext" == "$ext" ]]; then
    valid=true
    break
  fi
done

if [ "$valid" != true ]; then
  echo "Geçersiz dosya uzantısı: $1"
  echo "Desteklenen uzantılar: ${valid_extensions[*]}"
  exit 1
fi


if ! command -v base64 &>/dev/null; then
  echo "base64 komutu bulunamadı."
  exit 1
fi


echo "//4mY2xzDQo=" > temp.~b64
base64 -d temp.~b64 > "$output_file"
rm -f temp.~b64

echo "Dosya başarıyla oluşturuldu: $output_file"
exit 0
