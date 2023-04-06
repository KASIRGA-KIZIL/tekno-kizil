import glob


insttestlist = ["auipc","jal","jalr","lui","andi","ori","xori","addi","slli","slti","sltiu","and","sll","xor","or","srl","sra","slt","sltu","srli","srai","sub","bgeu","bltu","blt","bne","beq","bge","add","mul","mulh","mulhu","mulhsu","div","divu","rem","remu","lw","lh","lb","lbu","lhu","sw","sb","sh", 'hmdst', 'rvrs', 'pkg', 'sladd', 'cntz', 'cntp','conv']


TESTS_FOLDER = "../testler/riscv-tests/isa"
riscv_tests = {}
for each in insttestlist:
  ecallfail = False
  ecallpass = False
  fail_adr = 0
  pass_adr = 0
  filename = glob.glob(TESTS_FOLDER + '/*-' + each + '.dump')[0] #'./data/rv32ui-p-sb.dump'
  with open(filename, 'r') as f:
    for line in f:
      if '<fail>:' in line:
          ecallfail = True
      elif '<pass>:' in line:
          ecallpass = True

      if ecallfail and 'ecall' in line:
          ecallfail = False
          fail_adr = int(line.split(':')[0].replace(' ', ''), 16)
      elif ecallpass and 'ecall' in line:
          ecallpass = False
          pass_adr = int(line.split(':')[0].replace(' ', ''), 16)
  riscv_tests[each] = {
    "TEST_FILE": glob.glob(TESTS_FOLDER + '/*-' + each + '_static.hex')[0], #"./data/rv32ui-p-sb_static.hex",
    "fail_adr": fail_adr,
    "pass_adr": pass_adr,
    "buyruklar": []
  }
