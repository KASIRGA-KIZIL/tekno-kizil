
import serial
import time

def main():
    with serial.Serial('/dev/ttyUSB2', 9600, timeout=1) as ser:
        while(1):
            line = ser.readline()
            print(line)
main()

#  line = ser.readline()
