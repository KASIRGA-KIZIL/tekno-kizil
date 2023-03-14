#!/usr/bin/env python3
import os
import shutil
import subprocess

DESIGN_NAME = 'buyruk_onbellegi'
MAIN_SRC_PATH = "../verilog-tasarimi"
OPENLANE_HOME = os.environ['OPENLANE_HOME']
OPENLANE_DESIGN = OPENLANE_HOME + "/designs" + f"/{DESIGN_NAME}"
TARGET_SRC_PATH = OPENLANE_DESIGN+'/src'

# open_pdks <from openlane commit>
# e6f9c8876da77220403014b116761b0b2d79aab4

# openlane <latest commit, not the hash but the tag>
# 2023.03.12

# export FORCE_ACCEPT_SIZE=1

# ./dffram.py -b sky130A:sky130_fd_sc_hd:ram -s 256x8 -j 8

# ./dffram.py -b sky130A:sky130_fd_sc_hd:ram -s 512x16 -j 8



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
