#!/usr/bin/env python3
import os
import shutil
import subprocess

DESIGN_NAME = 'user_processor'
TARGET_SRC_PATH = f"./{DESIGN_NAME}"+'/src'

def copy_verilogs():
   MAIN_SRC_PATH = "../../verilog-tasarimi"

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

def copy_gates():
   src_folder = '../'
   dest_folder = TARGET_SRC_PATH

   v_files = [file for file in os.listdir(src_folder) if file.endswith('.v')]
   for file in v_files:
      src_file = os.path.join(src_folder, file)
      dest_file = os.path.join(dest_folder, file)
      shutil.copy(src_file, dest_file)

copy_verilogs()
copy_gates()
shutil.copy2(f"./config.json",f"./{DESIGN_NAME}")
