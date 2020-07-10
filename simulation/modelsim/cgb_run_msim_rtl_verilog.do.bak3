transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Source/cgb {C:/Source/cgb/DE0_Nano.v}
vlog -vlog01compat -work work +incdir+C:/Source/cgb {C:/Source/cgb/SM83.v}
vlog -vlog01compat -work work +incdir+C:/Source/cgb {C:/Source/cgb/sram.v}

