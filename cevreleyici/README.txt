Dosya tanımları:
  -teknofest_wrapper.v: Tasarımların konulacağı top modül
  -teknofest_ram.v: Main memory modülü. teknofest_wrapper'in içinde çağrılıyor.
  -simpleuart.v: Main memory modülünü programlamak için kullanılan basit bir uart modülü.(PICORV işlemcisinden alınmıştır.) teknofest_ram modülünün içinde çağrılıyor.
  -teknofest_wrapper.xdc: Wrapper top modülü için constraint dosyası.(Nexys A7 Board'una göre ayarlanmıştır.)

Hiyerarşi:
  -teknofest_wrapper
    --user_processor
    --teknofest_ram
      ---simpleuart

Kullanım Şekli:
  1)Kendi işlemcinizin olduğu Vivado projesine .v uzantılı doyalar source file olarak eklenir.
  2)teknofest_wrapper.xdc dosyası da constraint file olarak eklenir.
  3)İşlemcinin ismi teknofest_wrapper.v içinde çağrıldığı şekilde olmalıdır.(Veya wrapper'ın içinde çağrılan ismi kendi isminizle değiştirebilirsiniz.)
  4)Tasarım bitstream üretmek için hazır. Generate bitstream tuşuna basarak sentez, place&route yaptıktan sonra kullanılan FPGA için gereken bitstream dosyası oluşturulur.
  5)Üretilen bitstream'i FPGA'e atmak için Open Hardware Manager'a bastıktan sonra Open Target ve ürettiğimiz bitstream dosyasını seçerek Program Device yapmamaız gerekiyor.

Not: Eğer tasarımınız 100MHz'de çalışmıyorsa teknofest_wrapper'ın içinde clock_wizard IP'si eklenerek uygun hızda çalıştırılır.

Programlama:
-Gerçeklenen işlemciyi programlamak için iki yol var. 
  1)Donanım değişmediyse işlemci FPGA üzerinde çalışırken UART programlama pinini kullanarak programlamak.
    -Wrapper içindeki main memory'yi programlamak için USB-UART dönüşümünü sağlayan bir kablo ile FPGA ve bilgisayar arasındaki bağlantı sağlanır. 
    -Başlangıçta, program kodu olarak "TEKNOFEST" göndermek gerekiyor ve sonrasında gönderilecek toplam 32 bitlik buyruk(instruction) sayısını 32 bit olarak göndermek gerekiyor. 
    -Bundan sonra buyruklar sırasıyla bir dosyadan okunup UART üzerinden gönderilmesi gerekiyor.
    -Eğitimde gösterilen şekilde bir Python kodu yazılarak programlama işlemi yapılır. Programlama sırasında 1. LED yanacaktır ve 
    programlama bittiğinde sistem içerden kendi kendine resetlenip yeni yüklenen kod çalışmaya başlar.
    -Bu sistem FPGA hali hazırda çalışırken her yeni kod için yeni bir implementation yapmamak için oluşturulmuştur.
  2)Main Memory INIT_FILE path'e yeni kodu vererek bitstream üretmek.
    -Programlamak için python kodu yazmayanlar, wrapper'ın içindeki main memory INIT_FILE path'e yeni denemek istedikleri kodu vererek deneyebilirler.
    
