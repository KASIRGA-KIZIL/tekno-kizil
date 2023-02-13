
import serial
import time

FILE = "../verilog-simulasyonu/data/basit_dongu.hex"
def main():
    with serial.Serial('/dev/ttyUSB0', 9600, timeout=1) as ser:
        ser.write(b'TEKNOFEST')
        with open(FILE,'r') as f:
            for count, line in enumerate(f):
                pass
        ser.write(count.to_bytes(4,'little'))
        line = ser.read(9)
        print(line)
        line = ser.read(4)
        print(line)
        with open(FILE,'r') as f:
            for line in f:
                ser.write(int(line,16).to_bytes(4,'little'))
                line = ser.read(4)
                print(line)
main()

#  line = ser.readline()
