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
def read_tests():
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
                elif ('<end_signature>:' in line):
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
                    line     = all_lines[i-3]
                    end_sign_adr = int(line.split(':')[0].replace(' ', ''), 16)
                    random_tests[path.stem]["end_sign_adr"] = end_sign_adr


    for index, path in enumerate(TESTS_FOLDER.rglob('*.hex')):
        with open(path, 'r') as f:
            random_tests[path.stem]["buyruklar"] = [line.rstrip('\n') for line in f]

async def compare_logs(OUTPUT_FOLDER):
    failed = []
    for index, path in enumerate(TESTS_FOLDER.rglob('*.log')):
        with open(path, 'r') as f:
            reference = f.readlines()

        with open(str(OUTPUT_FOLDER) + path.stem + '.log', 'r') as f:
            target = f.readlines()

        for i, ref_line in enumerate(reference):
            if (i == len(reference) - 3):
                failed.append(0)
                break
            if (ref_line != target[i]):
                failed.append({"path":path, "idx":i})
                break

    for i, fail in enumerate(failed):
        if(fail != 0):
            path = fail["path"]
            idx  = fail["idx"]
            print(f"[ERROR] Difference in the log line {idx} path: {path}")
            assert 0
            return -1

    if(0 == len(failed)):
        print(f"[ERROR] Can not file any log file in OUTPUT_FOLDER: {OUTPUT_FOLDER}")
        print(f"[ERROR] Can not file any log file in TESTS_FOLDER:  {TESTS_FOLDER}")
        assert 0
        return -1

    print(f"[PASS] No difference in the logs")
    return 0


async def compare_signs(OUTPUT_FOLDER):
    failed = []
    for index, path in enumerate(TESTS_FOLDER.rglob('*.sign')):
        with open(path, 'r') as f:
            reference = f.readlines()

        with open(str(OUTPUT_FOLDER) + path.stem + '.sign', 'r') as f:
            target = f.readlines()

        for i, ref_line in enumerate(reference):
            if (i == len(reference) - 3):
                failed.append(0)
                break
            if (ref_line != target[i]):
                failed.append({"path":path, "idx":i})
                break

    for i, fail in enumerate(failed):
        if(fail != 0):
            path = fail["path"]
            idx  = fail["idx"]
            print(f"[ERROR] Difference in the signature. Line {idx}, Path: {path}")
            assert 0
            return -1

    if(0 == len(failed)):
        print(f"[ERROR] Can not file any sign file in OUTPUT_FOLDER: {OUTPUT_FOLDER}")
        print(f"[ERROR] Can not file any sign file in TESTS_FOLDER:  {TESTS_FOLDER}")
        assert 0
        return -1

    print(f"[PASS] No difference in the signatures")
    return 0

read_tests()

