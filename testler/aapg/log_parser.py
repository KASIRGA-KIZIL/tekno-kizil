import argparse

parser = argparse.ArgumentParser("Extract PC and instruction address from spike log. The output is printed. Use commandline pipe to write to a file")

parser.add_argument('-i', type=str, required=True, help="Path to spike log file")


args = parser.parse_args()



file = args.i

def get_instruction_order():
    time_step = 0
    with open(file, "r") as log_file:
        for line in log_file:
            if(">>>>" in line):
                continue
            # Split the line into fields
            fields = line.split()

            # Extract the address and instruction fields
            address = fields[2]
            instruction = fields[3]

            # index is negative if the adr is less than 0x40000000
            index = (int(address,16)-int("0x40000000",16)) // 4

            address = "{0:#0{1}x}".format(int(address,16),10)

            if(index >= 0):
                print(time_step," ", address," ", (instruction[1:])[:-1])
            else:
                time_step = -1

            time_step = time_step + 1

get_instruction_order()
