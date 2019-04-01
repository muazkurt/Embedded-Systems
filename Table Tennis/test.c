/**
	This is a template C code for the implementation of Table Tenis Game on Logisim.
	Muaz Kurt - 151044062
	muazkurt@gmail.com
*/
int main(void)
{
	int[32][32] table;
	int[32] 	U1 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} // 0 -> Top, 31 -> Bottom
	int[32] 	U2 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} // ######################
	int 		risk_left 	= 0, 
				risk_right 	= 0;
	int[3]		direction 	= {0, 0, 0};
	int[2] 		js_left_x 	= {0, 0},		
		 		js_left_y 	= {0, 0},		
				js_right_x	= {0, 0}
				js_right_y	= {0, 0};
	int	 		fin			= 0;
	int	 		start		= 0;
	int			upper_bound	= 0,
				lower_bound = 0;
	do
	{
S0:		direction = {0, 0, 0};
		U1[16] = U1[17] = 1;
		U2[16] = U1[17] = 1;
		table[16][0] = 1;
		while(start);
		while(!fin)
		{
			if(start) goto S0;
			for(int i = 0; i < 32; ++i)
			{
				risk_left |= table[31][i];
				risk_right |= table[0][i];
			}

			if(risk_left)
			{
				int handle = 0;
				for(int i = 0; i < 32; ++i)
					handle |= table[i][0] & U1[i]
				if(!handle)
				{
				
					while( !direction[0] 
						&& !direction[1]
						&& !direction[2]
						&& (
							!js_left_x[1] || 
							(!js_left_x[0] && js_left_x[1] && js_left_y[1] && !js_left_y[0]))
						);

					if(js_left_x[1] & !js_left_x[0])
					{
						if(js_left_y[0] & !js_left_y[1] & !U1[0])
						{
							for(i = 1; i < 31; ++i)
							{
								U1[i - 1] = U1[i];
								table[i - 1][0] = table[i][0];
							}
							U1[31] = 0;
							table[31][0] = 0;
						}
						else if(js_left_y[0] & js_left_y[1] & !U1[31])
						{
							for(i = 31; i > 0; --i)
							{
								U1[i] = U1[i - 1];
								table[i][0] = table[i - 1][0];
							}
							U1[0] = 0;
							table[0][0] = 0;
						}
					}
					else
					{
						direction[2] = !direction[2];
						if(	(js_left_y[1] && !js_left_y[0] && js_left_x[1] && !js_left_x[0]) ||
							!js_left_x[1]);
						else if(js_left_x[0] & js_left_x[1] & js_left_y[0] & !js_left_y[1])
						{
							direction[0] = 1;
							direction[1] = 0;
						}
						else if(js_left_x[0] & js_left_x[1] & !js_left_y[0] & js_left_y[1])
						{
							direction[0] = 1;
							direction[1] = 1;
						}
						else if(js_left_x[0] & js_left_x[1] & js_left_y[0] & js_left_y[1])
						{
							direction[0] = 0;
							direction[1] = 1;	
						}
					}
				}
				else 
					fin = 1;
			}
			else if(risk_right)
			{
				int handle = 0;
				for(int i = 0; i < 32; ++i)
					handle |= table[i][31] & U1[i]
				if(!handle)
				{
					while( !direction[0] 
						&& !direction[1]
						&& !direction[2]
						&& (
							 (js_right_x[0] & js_right_x[1]) || 
							(!js_right_x[0] &&
							  js_right_x[1] &&
							  js_right_y[1] && 
							 !js_right_y[0]))
						);
					if(js_right_x[1] & !js_right_x[0])
					{
						if(js_right_y[0] & !js_right_y[1] & !U2[0])
						{
							for(i = 1; i < 31; ++i)
							{
								U2[i - 1] = U2[i];
								table[i - 1][31] = table[i][31];
							}
							U1[31] = 0;
							table[31][31] = 0;
						}
						else if(js_right_y[0] & js_right_y[1] & !U2[31])
						{
							for(i = 31; i < 0; ++i)
							{
								U2[i] = U2[i - 1];
								table[i][31] = table[i - 1][31];
							}
							U2[0] = 0;
							table[0][31] = 0;
						}
					}
					else
					{
						direction[2] != direction[2];
						if(	(js_right_y[1] && !js_right_y[0] && js_right_x[1] && !js_right_x[0]) ||
							(js_right_x[1] & js_right_x[1]));
						else if(!js_right_x[1] & js_left_y[0] & !js_right_y[1])
						{
							direction[0] = 1;
							direction[1] = 0;
						}
						else if(!js_right_x[1] & !js_right_y[0] & js_right_y[1])
						{
							direction[0] = 1;
							direction[1] = 1;
						}
						else if(!js_right_x[1] & js_right_y[0] & js_right_y[1])
						{
							direction[0] = 0;
							direction[1] = 1;	
						}
					}
				}
				else 
					fin = 1;
			}
			upper_bound = lower_bound = 0;
			for(int i = 0; i < 32; ++i)
			{
				upper_bound |= table[0][i];
				lower_bound |= table[31][i];
			}
			if(upper_bound || lower_bound)
			{
				int temp = direction[0];
				direction[0] = direction[1];
				direction[1] = temp;
			}
			if(direction[2])
				if(direction[1])
					if(direction[0])			// <<<<<<<<<<<<<<<<<<<-		111
						for(int i = 0; i < 32; ++i)
							for(int y = 0; y < 32; ++y)
								if(y == 31)
									table[i][y] = 0
								else
									table[i][y] = table[i][y + 1];
					else						// ///////////////////-		110
						for(int i = 0; i < 32; ++i)
							for(int y = 0; y < 32; ++y)
								if(i == 0 || y == 31)
									table[i][y] = 0;
								else
									table[i][y] = table[i - 1][y + 1];
				else
					if(direction[0])			// \\\\\\\\\\\\\\\\\\\-		101
						for(int i = 0; i < 32; ++i)
							for(int y = 0; y < 32; ++y)
								if(i == 31 || y == 31)
									table[i][y] = 0;
								else
									table[i][y] = table[i + 1][y + 1];
			else
				if(direction[1])
					if(direction[0])			// ->>>>>>>>>>>>>>>>>>		011
						for(int i = 0; i < 32; ++i)
							for(int y = 0; y < 32; ++y)
								if(y == 0)
									table[i][y] = 0
								else
									table[i][y] = table[i][y - 1];
					else						// -\\\\\\\\\\\\\\\\\\ 		010
						for(int i = 0; i < 32; ++i)
							for(int y = 0; y < 32; ++y)
								if(i == 0 || y == 0)
									table[i][y] = 0;
								else
									table[i][y] = table[i - 1][y - 1];
				else
					if(direction[0])			// -//////////////////		001
						for(int i = 0; i < 32; ++i)
							for(int y = 0; y < 32; ++y)
								if(i == 31 || y == 0)
									table[i][y] = 0;
								else
									table[i][y] = table[i + 1][y - 1];
			if (js_right_x[1] & !js_right_x[0])
			{
				if(js_right_y[0])
				{
					if(js_right_y[1])		// U2 >> 1
						for(int i = 0; i < 32; ++i)
							if(i == 31)
								U2[i] = U2[i];
							else
								U2[i] = U2[i - 1];
					else					// U2 << 1
						for(int i = 0; i < 32; ++i)
							if(i == 0)
								U2[i] = U2[i];
							else
								U2[i] = U2[i + 1]
				}
			}
			if (js_left_x[1] & !js_left_x[0])
			{
				if(js_left_x[0])
				{
					if(js_left_x[1])
						for(int i = 0; i < 32; ++i)
							if(i == 31)
								U1[i] = U1[i];
							else
								U1[i] = U1[i - 1];
					else
						for(int i = 0; i < 32; ++i)
							if(i == 0)
								U1[i] = U1[i];
							else
								U1[i] = U1[i + 1]
				}
			}
		}
		while(!start);
	} while(true);
}