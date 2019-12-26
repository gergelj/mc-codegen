//RETURN: 30

int main(){

	unsigned a;
	unsigned i;
	int s;
	unsigned j;
	a = 6u;
	s = 0;
	
	for(i=0u; i < a; i++)
		for(j=0u; j < 8u - 3u; j++)
			s = s + 1;
		
	return s;
}
