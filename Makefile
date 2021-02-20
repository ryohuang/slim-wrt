ALL:
	bash build.sh help_msg

showtime: clone encore
	
clone:
	bash build.sh clone_openwrt submodules

cleandist:
	bash build.sh clear_dist

clean:
	bash build.sh clear_stage clear_patches

play:
	bash build.sh create_workspace patch_openwrt patch_feeds do_custom_script prepare_stage make_it move_built

encore: clean play

	
%:
	echo $1 
	bash build.sh $@
