//RETURN: 88

int main(){

	int state;
	int s;
	int b;
	state = 10;
	b = 0;
	
	switch (state) {
		case 10: { s = 1; } break;
		case 20: s = 2;
	} 
	
	switch (s) {
		case 0: { s = 1; } break;
		case 2: s = 2;
		default: s = 66;
	}
	
	switch (s) {
		case 55: { s = 1; } break;
		case 66: s = 2;
		case 70: {if(b > 0)
					s = -6;
				else
					s = 88;} break;
		default: s = 0;
	} 
	
	return s;
}
