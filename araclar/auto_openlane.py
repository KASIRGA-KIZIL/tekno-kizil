# Verilen dosya yolunda ve alt dosyalarinda bulunan tum bagli modulleri bulup openlane flowunu calistiran ve cikti alan kod
import subprocess
import os
import shutil

modules_path = 'verilog-tasarimi'

module_list = []

temp_design = 'temp_all'
temp_runs_path = 'designs/' + temp_design + '/runs'
temp_design_path = 'designs/' + temp_design + '/src'

for root, dirnames, filenames in os.walk(modules_path):
    for filename in filenames:
        if filename.endswith('.v'):
            module_list.append(os.path.join(root, filename))

shutil.copyfile(os.path.join(modules_path, 'tanimlamalar.vh'), os.path.join(temp_design_path, 'tanimlamalar.vh'))

def rec_module_copy(top_module):
    code_str = open(top_module).read()
    # top_module_name = top_module.rsplit('/', 1)[-1]
    #print(module_list[1].rsplit('/', 1)[-1].replace('.v', '') + ' ')
    
    bulduklari_list = [module_name.rsplit('/', 1)[-1].replace('.v', '') + ' ' in code_str for module_name in module_list]
    bulduklari_isim_list = [x for x, y in zip(module_list, bulduklari_list) if y == True]
    #print(bulduklari_list)
    if any(bulduklari_list):
        for each in bulduklari_isim_list:
            #shutil.copyfile(each, os.path.join(temp_design_path, each.rsplit('/', 1)[-1]))
            #if each.rsplit('/', 1)[-1].replace('.v', '') + ' ' in code_str:
            
                

            print(each)
        for each in bulduklari_isim_list:
            return rec_module_copy(each)
            
    else:
        return
                
def rec_module_copy2(top_module):
    code_str = open(top_module).read()
    
    bulduklari_list = [module_name.rsplit('/', 1)[-1].replace('.v', '') + ' ' in code_str for module_name in module_list]
    bulduklari_isim_list = [x for x, y in zip(module_list, bulduklari_list) if y == True]
    
    if any(bulduklari_list):
        for each in bulduklari_isim_list:
            print(each)
            rec_module_copy2(each)      

def rec_module_copy3(top_module, copied_modules):
    code_str = open(top_module).read()
    
    bulduklari_list = [module_name.rsplit('/', 1)[-1].replace('.v', '') + ' ' in code_str for module_name in module_list]
    bulduklari_isim_list = [x for x, y in zip(module_list, bulduklari_list) if y == True]
    
    if any(bulduklari_list):
        for each in bulduklari_isim_list:
            if each not in copied_modules:
                print(each)
                shutil.copyfile(each, os.path.join(temp_design_path, each.rsplit('/', 1)[-1]))
                copied_modules.append(each)
                rec_module_copy3(each, copied_modules)

out_txt = open('output_openlanes.txt', 'w')
out_txt.write('')
out_txt = open('output_openlanes.txt', 'a')

module_list2 = [ os.path.join(modules_path, 'user_processor.v') ]	
#module_list2 = [ os.path.join(modules_path + '/cekirdek/boru_hatti/yurut', 'yurut.v') ]
#module_list2 = [ os.path.join(modules_path + '/cekirdek/boru_hatti/yurut/x-buyruklari/sifreleme_birimi', 'sifreleme_birimi.v') ]
for each_module in module_list:
	print('\n\n--------------' + each_module.rsplit('/', 1)[-1] + '--------------\n\n')
	
	if os.path.isdir(temp_runs_path):
	    shutil.rmtree(temp_runs_path)
	
	for f in os.listdir(temp_design_path):
    		if not f.endswith('.v'):
        		continue
    		os.remove(os.path.join(temp_design_path, f))
    		
	conf_json = open('designs/' + temp_design + '/config.json', 'w')
	json_text = '{"DESIGN_NAME": "' + each_module.rsplit('/', 1)[-1].replace('.v', '') + '", "VERILOG_FILES": "dir::src/*.v*", "CLOCK_PORT": "clk_i", "CLOCK_NET": "clk_i", "FP_CORE_UTIL": 35, "CLOCK_PERIOD": 10}'
	json_text_clk = '{"DESIGN_NAME": "' + each_module.rsplit('/', 1)[-1].replace('.v', '') + '", "VERILOG_FILES": "dir::src/*.v*", "CLOCK_PORT": "clk", "CLOCK_NET": "clk", "FP_CORE_UTIL": 35, "CLOCK_PERIOD": 10}'
	if each_module.rsplit('/', 1)[-1] != 'user_processor.v':
	    conf_json.write(json_text)
	else:
	    conf_json.write(json_text_clk)
	conf_json.close()
    	
	shutil.copyfile(each_module, os.path.join(temp_design_path, each_module.rsplit('/', 1)[-1]))
	
	rec_module_copy3(each_module, [])
	
	output_text = subprocess.getoutput('./flow.tcl -design ' + temp_design)
	print(output_text)
	out_txt.write('\n\n-------------- ' + each_module.rsplit('/', 1)[-1] + ' --------------\n\n')
	out_txt.write(output_text)
	out_txt.write('-------------- !!!DONE!!! --------------\n\n')
	print('-------------- !!!DONE!!! --------------\n\n')

out_txt.close()
