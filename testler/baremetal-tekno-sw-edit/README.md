# BAREMETAL ORTAMI

TEKNOFEST 2023 Çip Tasarım Yarışması Sayısal İşlemci Kategorisi yarışma 
şartnamesine göre Baremetal ortamı oluşturulmuştur. 

[RISC-V Derleyici](https://safirdepo.b3lab.org/shares/public/share/MUiPBNExEF6eN94TTHr45YD6gEuNLnGP ), tasarlanması istenilen eklentiler ile birlikte oluşturulmuştur. Ubuntu işletim sisteminde kullanılabilmektedir. Windows üzerinde WSL üzerine kurulmuş Ubuntu ile birlikte de kullanılabilir. İsme tıklayarak indirebilirsiniz.

İndirdiğiniz derleyiciyi aşağıdaki adımları izleyerek kullanılabilir hale getirebilirsiniz. 

`riscv.tar.gz` dosyasını indirdiğiniz klasörde aşağıdaki komutları çalıştırınız. 

```
sudo tar -xvzf riscv.tar.gz -C /opt

export RISCV=/opt/riscv; # bu komutun .bashrc dosyasına eklenmesi sonraki terminal açılışlarında da RISCV değişkeninin tanınmasını sağlayacaktır
```

`${RISCV}` komutu ile dizinin tanımlandığını kontrol edebilirsiniz. Baremetal ortamının kullanılabilmesi için bu tanımlamanın yapılması gerekmektedir.

Derleme işlemini indirdiğiniz `baremetal-tekno-sw` klasörünün içerisinde gerçekleştirebilirsiniz.
Örnek olarak oluşturulmuş `tekno_example` uygulamasını aşağıdaki komutlarla derleyebilirsiniz. 

```
cd baremetal-tekno-sw

make software PROGRAM=tekno_example BOARD=tekno
```

Kendi test sistemlerinizi verilen örnekleri ve sürücüleri referans alarak oluşturabilirsiniz.

> **_NOT:_**  `chip/tekno/setting.mk` dosyası içerisindeki `RISCV_ARCH := rv32im` ile kriptoloji ve hızlandırıcı buyrukları kullanılabilir haldedir. Sıkıştırılmış buyrukların kullanılması için `RISCV_ARCH := rv32imc` yapılmalıdır.

> **_NOT:_**  Çıktıların arasında yer alan .hex dosyası [Wrapper](https://github.com/TUTEL-TUBITAK/TEKNOFEST_2023_Cip_Tasarim_Yarismasi/tree/main/Wrapper) klasörü altındaki `teknofest_ram.v` dosyasındaki `INIT_FILE` parametresine verilerek ilgili C kodundan üretilen komutlar ile simulasyon gerçekleştirilebilmektedir.

