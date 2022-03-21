# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.cache/wt [current_project]
set_property parent.project_path C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/RF.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/UC.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/MEM.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/ExecutionUnit.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/IDecode.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/IFetch.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/SSD.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/MPG.vhd
  C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/MIPS.srcs/sources_1/new/MIPS.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/cons.xdc
set_property used_in_implementation false [get_files C:/Users/olivi/OneDrive/Desktop/faculta/an2/sem2/ac/lab/MIPS/cons.xdc]


synth_design -top MIPS -part xc7a35tcpg236-1


write_checkpoint -force -noxdef MIPS.dcp

catch { report_utilization -file MIPS_utilization_synth.rpt -pb MIPS_utilization_synth.pb }
