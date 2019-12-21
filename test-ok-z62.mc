//RETURN: 30

int main(){

	int a;
	int i;
	int s;
	int j;
	a = 6;
	s = 0;
	
	for(i=0; i < a; i++)
		for(j=0; j < 8 - 3; j++)
			s = s + 1;
		
	return s;
}
