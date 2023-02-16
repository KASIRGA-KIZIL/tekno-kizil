import argparse

parser = argparse.ArgumentParser(description='Get static hex code from riscv binary file.')

parser.add_argument('--binfile' , '-bf', default='coremark_baremetal.bin', help='specify riscv binary file that is obtained by gcc objcopy')

args = parser.parse_args()
binFile = args.binfile

with open(binFile, "rb") as f:
	binData = f.read()

	maxlimit = 1000000

	assert len(binData) < 4*maxlimit

	hexFileName = binFile[:-4] + "_static.hex"
	hexFile = open(hexFileName, 'w')

	for i in range(maxlimit):
		if i < len(binData) // 4:
			w = binData[4*i : 4*i+4]
			hexFile.write("%02x%02x%02x%02x" % (w[3], w[2], w[1], w[0]))
			hexFile.write("\n")

	f.close()
	hexFile.close()

