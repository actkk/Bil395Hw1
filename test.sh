#!/usr/bin/env bash

if [ ! -f calculator.l ]; then
  echo "[HATA] 'calculator.l' bulunamadı!"
  exit 1
fi

if [ ! -f calculator.y ]; then
  echo "[HATA] 'calculator.y' bulunamadı!"
  exit 1
fi

echo "[INFO] Bison ile parser kodu üretiliyor..."
bison -d -o calculator.tab.c calculator.y
if [ $? -ne 0 ]; then
  echo "[HATA] Bison derlemesinde hata oluştu."
  exit 1
fi

echo "[INFO] Flex ile lexer kodu üretiliyor..."
flex -o lex.yy.c calculator.l
if [ $? -ne 0 ]; then
  echo "[HATA] Flex derlemesinde hata oluştu."
  exit 1
fi

echo "[INFO] GCC ile derleniyor -> ./calculator"
gcc lex.yy.c calculator.tab.c -o calculator -lm
if [ $? -ne 0 ]; then
  echo "[HATA] gcc derlemesinde hata oluştu."
  exit 1
fi

echo "[INFO] Derleme başarıyla tamamlandı!"
echo ""


TEST_CASES=(
  "3 + 5:Toplama işlemi"
  "(1 + 2) * 4:Parantez ve çarpma testi"
  "10 / 2:Bölme işlemi"
  "10 / 0:Division by zero hatası testi"
  "(3 + 5) * (2 - 1) / 4:Birden fazla işlem, parantez, bölme"
  "2 ^ 3:Üs alma işlemi"
  "2 ^ 3 ^ 2:Right-associative exponent testi"
  "2.5 * 2:Ondalık çarpma testi"
  "2.5 + 3.5:Ondalık toplama testi"
  "(1 + (2 * 3)):İç içe parantez"
  "garbage:Geçersiz ifade - syntax error testi"
  "3 +++ 4:Geçersiz kullanım (operator hatası) testi"
  "2 / (3 - 3):Sıfıra bölme (ifade içinde) testi"
  "3.14 * 2.5:Ondalıklar arası çarpma testi"
  "6 - 10:Negatif sonuç testi"
  "42:(Sadece sayı) Tek operand testi"
  "(((1+2))):Ekstra parantez yığını"
)

echo "========================================"
echo "            Test Senaryolari"
echo "========================================"

for tc in "${TEST_CASES[@]}"; do
  
  IFS=':' read -r ifade aciklama <<< "$tc"
  
  echo ""
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo "Test Edilen Durum: $aciklama"
  echo "Girdi: $ifade"
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  
  echo "$ifade" | ./calculator
done

echo ""
echo "========================================"
echo "     TÜM TESTLER TAMAMLANDI"
echo "========================================"
rm -f calculator.tab.c calculator.tab.h lex.yy.c calculator

