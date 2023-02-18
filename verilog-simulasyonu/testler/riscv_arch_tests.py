import glob


# auipc add addi and andi or ori sll slli slt slti sltiu sra srai srl srli sub xori xor
TESTS_FOLDER = "../testler/riscv-arch-test/work/rv32i_m/I"

# mul div mulh mulhsu mulhu rem remu
# TESTS_FOLDER = "../testler/riscv-arch-test/work/rv32i_m/M"

insttestlist = ["xor"]
riscv_tests = {}

for each in insttestlist:
  ecallfail = False
  ecallpass = False
  fail_adr = 0
  pass_adr = 0
  filename = glob.glob(TESTS_FOLDER + '/' + each + '-*.objdump')[0] #'./data/rv32ui-p-sb.dump'
  with open(filename, 'r') as f:
    for line in f:
      if '<fail>:' in line:
          ecallfail = True
      elif '<rvtest_code_end>:' in line:
          ecallpass = True

      if ecallfail and 'ecall' in line:
          ecallfail = False
          fail_adr = int(line.split(':')[0].replace(' ', ''), 16)
      elif ecallpass and 'jal' in line:
          ecallpass = False
          pass_adr = int(line.split(':')[0].replace(' ', ''), 16)
  riscv_tests[each] = {
    "TEST_FILE": glob.glob(TESTS_FOLDER + '/' + each + '-*.hex')[0], #'./data/rv32ui-p-sb.dump'
    "fail_adr": fail_adr,
    "pass_adr": pass_adr,
    "buyruklar": []
  }