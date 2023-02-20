import glob
from pathlib import Path

TESTS_FOLDER = Path("../testler/aapg/build/")


random_tests = {}
"""
random_test = {'random_test_name':{
    "begin_sign_adr": 0x40000060,
    "end_sign_adr": 0x40010060,
    "buyruklar": []
}}
"""

for index, path in enumerate(TESTS_FOLDER.rglob('*.dump')):
    with open(path, 'r') as f:
        all_lines=f.readlines()
        random_tests[path.stem] = {}
    with open(path, 'r') as f:
        label_line = False
        begin_sign = False
        end_sign   = False
        for i, line in enumerate(f):
            if ('<label>:' in line):
                label_line = True
                continue
            elif ('<begin_signature>:' in line):
                begin_sign = True
                continue
            elif ('<tohost>:' in line):
                end_sign = True
                continue

            if label_line:
                label_line = False
                finish_adr = int(line.split(':')[0].replace(' ', ''), 16)
                random_tests[path.stem]["finish_adr"] = finish_adr

            if begin_sign:
                begin_sign     = False
                begin_sign_adr = int(line.split(':')[0].replace(' ', ''), 16)
                random_tests[path.stem]["begin_sign_adr"] = begin_sign_adr

            if end_sign:
                end_sign = False
                line     = all_lines[i-5]
                end_sign_adr = int(line.split(':')[0].replace(' ', ''), 16)
                random_tests[path.stem]["end_sign_adr"] = end_sign_adr


for index, path in enumerate(TESTS_FOLDER.rglob('*.hex')):
    with open(path, 'r') as f:
        random_tests[path.stem]["buyruklar"] = [line.rstrip('\n') for line in f]
