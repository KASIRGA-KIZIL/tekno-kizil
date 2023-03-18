# HOW
Change the commits so they match with the openlane
* open_pdks <from openlane commit>
    * e6f9c8876da77220403014b116761b0b2d79aab4
* openlane <latest commit, not the hash but the tag>
    * 2023.03.12

We need 8 or 16 bits so:
* export FORCE_ACCEPT_SIZE=1

Commands:
* ```./dffram.py -b sky130A:sky130_fd_sc_hd:ram -s 256x8 -j 8```
* ```./dffram.py -b sky130A:sky130_fd_sc_hd:ram -s 512x16 -j 8```

