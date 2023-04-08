#!/usr/bin/env python3
import os
import shutil
import subprocess

DESIGN_NAME = 'user_processor'
MAIN_SRC_PATH = "../../verilog-tasarimi"
TARGET_SRC_PATH = f"./{DESIGN_NAME}"+'/src'

# create design folder
if not os.path.exists(DESIGN_NAME):
    os.makedirs(f"./{DESIGN_NAME}")
    os.makedirs(TARGET_SRC_PATH)
else:
   print("[ERROR] Folder exists.")

# copy all verilog files
for root, dirs, files in os.walk(MAIN_SRC_PATH):
   for file in files:
      path_file = os.path.join(root,file)
      shutil.copy2(path_file,TARGET_SRC_PATH)


shutil.copy2(f"./pin_order.cfg",f"./{DESIGN_NAME}")
shutil.copy2(f"./config.json",f"./{DESIGN_NAME}")
