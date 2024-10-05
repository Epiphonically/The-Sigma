//show_debug_message("HI");
switch (phase) {
	case 0:
		switch (other.operation) {
			case "+":
				hpbar1 += other.value;
			break;
			
			case "-":
				hpbar1 -= other.value;
			break;
			
			case "*":
				hpbar1 *= other.value;
			break;
			
			case "\\":
				if (other.value == 0) {
					hpbar1 = 0;	
				} else {
					hpbar1 /= other.value;
				}
			break;
		}
		
	break;
		
	case 1:
		switch (other.operation) {
			case "+":
				hpbar2 += other.value;
			break;
			
			case "-":
				hpbar2 -= other.value;
			break;
			
			case "*":
				hpbar2 *= other.value;
			break;
			
			case "\\":
				if (other.value == 0) {
					hpbar2 = 0;	
				} else {
					hpbar2 /= other.value;
				}
			break;
		}
	break;
	
	case 2:
		switch (other.operation) {
			case "+":
				hpbar3 += other.value;
			break;
			
			case "-":
				hpbar3 -= other.value;
			break;
			
			case "*":
				hpbar3 *= other.value;
			break;
			
			case "\\":
				if (other.value == 0) {
					hpbar3 = 0;	
				} else {
					hpbar3 /= other.value;
				}
			break;
		}
	break;
}

with (other) {
	instance_destroy();	
}