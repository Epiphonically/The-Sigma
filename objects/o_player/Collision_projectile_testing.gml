if (other.death == false && !dashing){
	
	hp = hp - 1;
	with(other){
		if (!death){
			repeat(random_range(0,5)){
				instance_create_layer(x,y,"Instances",o_module);
			}
			death = true;
		}
	
	}
}

