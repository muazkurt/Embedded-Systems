transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Projects/EMBEDDED/HW/Led\ Game/Led\ Game/Modules {D:/Projects/EMBEDDED/HW/Led Game/Led Game/Modules/Status.v}
vlog -vlog01compat -work work +incdir+D:/Projects/EMBEDDED/HW/Led\ Game/Led\ Game/Modules {D:/Projects/EMBEDDED/HW/Led Game/Led Game/Modules/Segmenter.v}

