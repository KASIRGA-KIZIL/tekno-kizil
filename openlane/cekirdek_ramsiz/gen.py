#!/usr/bin/env python3
import os
import shutil
import subprocess

DESIGN_NAME = 'cekirdek_ramsiz'
MAIN_SRC_PATH = "../verilog-tasarimi"
OPENLANE_HOME = os.environ['OPENLANE_HOME']
OPENLANE_DESIGN = OPENLANE_HOME + "/designs" + f"/{DESIGN_NAME}"
TARGET_SRC_PATH = OPENLANE_DESIGN+'/src'

# create design folder
if not os.path.exists(OPENLANE_DESIGN):
    os.makedirs(OPENLANE_DESIGN)
    os.makedirs(TARGET_SRC_PATH)

# copy all verilog files
for root, dirs, files in os.walk(MAIN_SRC_PATH):
   for file in files:
      path_file = os.path.join(root,file)
      shutil.copy2(path_file,TARGET_SRC_PATH)


shutil.copy2(f"./{DESIGN_NAME}/pin_order.cfg",OPENLANE_DESIGN)
shutil.copy2(f"./{DESIGN_NAME}/config.json",OPENLANE_DESIGN)
