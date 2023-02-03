# Data array size bit sayisi
total_size = 16384

# Data word bit size
word_size = 32

# Number of words per line
words_per_line = 1

# Address port size
address_size = 11

# Number of ways
num_ways = 1

# Replacement policy
replacement_policy = None

# Write policy
write_policy = "write-through"

# Output file name
output_name = "buyruk_onbellegi"

return_type = "Word"

has_flush =False

# For simulation
simulate = True

# For synthesis
synthesize = True
# To keep the results
keep_temp = True

run_openram = True

num_threads = 8

data_hazard = True

read_only = True

openram_options = {
    "tech_name": "sky130",
    "nominal_corner_only": True,
    "netlist_only": False
}