#include<SPI.h>

volatile boolean geldi;

volatile byte gelen_veri;


void setup()


{

  Serial.begin(115200);

  pinMode(MISO,OUTPUT);                   //Sets MISO as OUTPUT (Have to Send data to Master IN 


  SPCR |= _BV(SPE);                       //Turn on SPI in Slave Mode

  geldi = false;

  SPI.attachInterrupt();                  //Interuupt ON is set for SPI commnucation
}


ISR (SPI_STC_vect)                        //Inerrrput routine function 

{

  gelen_veri = SPDR;         // Value received from master if store in variable slavereceived

  geldi = true;                        //Sets received as True 

  Serial.println(gelen_veri,HEX);
}


void loop()

{
  delay(10);
}
