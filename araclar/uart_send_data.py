import serial

port = '/dev/ttyUSB1'
baud_rate = 9600
file = "dene.hex"
program_sequence = "TEKNOFEST"
file_format = 1

if file_format == 1:
    program_data = open(file, 'r').read()
    lines = program_data.split('\n')
    
    ser = serial.Serial(port, baud_rate)
    ser.timeout = 1
    
    ser.write(program_sequence.encode('utf-8'))
    print(program_sequence)
    
    hex_str = hex(len(lines))
    print ("Number of Instruction is " + str(len(lines)) + " = " + hex_str)
    
    hex_str = int(hex_str, 16).to_bytes(4, 'big')
    ser.write(hex_str)

    for line in lines:
        if len(line) < 8:
            read_data = read_data
        else:
            read_data = int(line, 16).to_bytes(4,'big')
            ser.write(read_data)
    
        #print("{:02x}".format(read_data[0]) + \
        #"{:02x}".format(read_data[1]) + \
        #"{:02x}".format(read_data[2]) + \
        #"{:02x}".format(read_data[3]) )
    ser.write('done'.encode('utf-8'))

elif FileFormat == 2:
    program_data = open(file, 'rb').read()
    ser = serial.Serial(port, baud_rate)
    ser.timeout = 1
    
    ser.write(program_sequence.encode('utf-8'))
    print(program_sequence)
    
    hex_str = hex(len(program_data))
    print ("Number of Instruction is " + str(len(program_data)) + " = " + hex_str)
    
    hex_str = int(hex_str, 16).to_bytes(4, 'big')
    ser.write(hex_str)
    
    for i in range(0, len(program_data), 4):
        ser.write(program_data[i+3])
        ser.write(program_data[i+2])
        ser.write(program_data[i+1])
        ser.write(program_data[i])
        
        #print("{:02x}".format(program_data[i+3]) + \
        #"{:02x}".format(program_data[i+2]) + \
        #"{:02x}".format(program_data[i+1]) + \
        #"{:02x}".format(program_data[i]) )
    ser.write('done'.encode('utf-8'))

print("Done Programming")
