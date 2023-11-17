module PROY_BRICKS(clk50, sync_h, sync_v, r, g, b, Dir_l_x, Dir_r_x, led_1, led_2, CHECK, clk10, Sound_OUT);
input clk50, clk10;
input Dir_l_x, Dir_r_x;
output reg [3:0]r, g, b;
output [6:0]led_1, led_2;
output reg sync_h, sync_v; 
output Sound_OUT;
output reg [9:0]CHECK;

//------VARIABLES------//
    reg [9:0]x=0,y=0,Px_1=450,Py_1=170,Px_2=550,Py_2=170,Px_3=350,Py_3=170,PB_1x=592,PB_1y=150, PB_2x=464,PB_2y=150, PB_3x=208,PB_3y=150, PB_4x=336, PB_4y=150, PB_5x=720, PB_5y=150;
    reg [9:0]l_x=400,l_y=485,ln_barra=100, BAR_OP=0, BAR_DW=0;
    reg [4:0]score=0, Sound_EN=0, VEL_BAR=4, Vel_BALL_X=2, Vel_BALL_Y=4, Vel_BALL_X_1=0, Vel_BALL_Y_1=0, Vel_BALL_X_2=0, Vel_BALL_Y_2=0, Vel_BALL_X_3=0, Vel_BALL_Y_3=0;
    reg [3:0]level=0, life=3, color=0, Aux_Time1=0;
    reg Dirx_1=0,Diry_1=0, Dirx_2=0,Diry_2=0, Dirx_3=0, Diry_3=0, out_ball=0, POWER_1=0, PB_Fall_1=0, POWER_2=0, PB_Fall_2=0, POWER_3=0, PB_Fall_3=0,  POWER_4=0, PB_Fall_4=0, POWER_5=0, PB_Fall_5=0,
    BALL_1_ON=1, BALL_2_ON=0, BALL_3_ON=0;
    reg l1_1=1,l2_1=1,l3_1=1,l4_1=1,l5_1=1, l1_2=1,l2_2=1,l3_2=1,l4_2=1,l5_2=1, l1_3=1,l2_3=1,l3_3=1,l4_3=1,l5_3=1, l1_4=1,l2_4=1,l3_4=1,l4_4=1,l5_4=1;
    wire clk25;
	reg [25:0]Aux_Time;

//------FUNCTIONS------//
    Clock25 clk_1 (clk50,clk25);
    Display_decimal d_1 (.in(level), .out(led_1));
    Display_decimal d_2 (.in(life), .out(led_2));
	Sound_Bounce s_1 (.clk10(clk10), .Sound_EN1(Sound_EN), .Sound_OUT(Sound_OUT));

//CODIGO
always @(posedge(clk25))
begin
//------RECORRIDO EN PANTALLA------//
	if(x<=799) 
	begin
		x=x+1;
	end
	else if(x>799)
		begin
			x=0;
			y=y+1;
		end
	if(y>524) 
	begin
		y=0;

//------REINICIOS------//
	//BALL_1
		if(Dirx_1==0) Px_1=Px_1+Vel_BALL_X_1;
		if(Diry_1==0) Py_1=Py_1+Vel_BALL_Y_1;
		if(Dirx_1==1) Px_1=Px_1-Vel_BALL_X_1;
		if(Diry_1==1) Py_1=Py_1-Vel_BALL_Y_1;
    //BALL_2
		if(Dirx_2==0) Px_2=Px_2+Vel_BALL_X_2;
		if(Diry_2==0) Py_2=Py_2+Vel_BALL_Y_2;
		if(Dirx_2==1) Px_2=Px_2-Vel_BALL_X_2;
		if(Diry_2==1) Py_2=Py_2-Vel_BALL_Y_2;
    //BALL_3
		if(Dirx_3==0) Px_3=Px_3+Vel_BALL_X_3;
		if(Diry_3==0) Py_3=Py_3+Vel_BALL_Y_3;
		if(Dirx_3==1) Px_3=Px_3-Vel_BALL_X_3;
		if(Diry_3==1) Py_3=Py_3-Vel_BALL_Y_3;
    //PB
        if(PB_Fall_1==1) PB_1y=PB_1y+2; //PB_1
        if(PB_Fall_2==1) PB_2y=PB_2y+2; //PB_2
        if(PB_Fall_3==1) PB_3y=PB_3y+2; //PB_3
    //DWB
        if(PB_Fall_4==1) PB_4y=PB_4y+2; //PB_4
        if(PB_Fall_5==1) PB_5y=PB_5y+2; //PB_5
	//BAR
		if(Dir_r_x==0 && l_x<(784-ln_barra)) 	l_x=l_x+VEL_BAR;
		if(Dir_l_x==0 && l_x>144) 				l_x=l_x-VEL_BAR;
	end

//------SYNC------//
    //SYNC HORIZONTAL
        if(x<96) sync_h=1;
        else sync_h=0;	
    //SYNC VERTICAL
        if(y<2) sync_v=1;
        else sync_v=0;

//------BALL POWER UP DRAW------//
    //BALL POWER DRAW 1
        if((49)>=((PB_1x-x)*(PB_1x-x))+((PB_1y-y)*(PB_1y-y)))
        begin
            if(POWER_1==1)
            begin
                r=0;g=10;b=0;
            end
            else
            begin
                r=0;g=0;b=0;
            end
        end
        else 
        begin
            r=0;g=0;b=0;
        end
        
    //BALL POWER DRAW 2
        if((49)>=((PB_2x-x)*(PB_2x-x))+((PB_2y-y)*(PB_2y-y)))
        begin
            if(POWER_2==1)
            begin
                r=0;g=10;b=0;
            end
            else
            begin
                r=0;g=0;b=0;
            end
        end
    
    //BALL POWER DRAW 3
        if((49)>=((PB_3x-x)*(PB_3x-x))+((PB_3y-y)*(PB_3y-y)))
        begin
            if(POWER_3==1)
            begin
                r=0;g=10;b=0;
            end
            else
            begin
                r=0;g=0;b=0;
            end
        end

//------BALL POWER DOWN DRAW------//   
    //BALL POWER DRAW 4
        if((49)>=((PB_4x-x)*(PB_4x-x))+((PB_4y-y)*(PB_4y-y)))
        begin
            if(POWER_4==1)
            begin
                r=10;g=0;b=0;
            end
            else
            begin
                r=0;g=0;b=0;
            end
        end
    //BALL POWER DRAW 5
        if((49)>=((PB_5x-x)*(PB_5x-x))+((PB_5y-y)*(PB_5y-y)))
        begin
            if(POWER_5==1)
            begin
                r=10;g=0;b=0;
            end
            else
            begin
                r=0;g=0;b=0;
            end
        end

//------Blocks DRAW------//
	//L1
        if(x>(144) && x<(144+((128)*(1))) && y>(35) && y<(35+((30)*(1)))) //L1_1
        begin
            if(l1_1==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(2))) && y>(35) && y<(35+((30)*(1)))) //L2_1
        begin
            if(l2_1==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(3))) && y>(35) && y<(35+((30)*(1)))) //L3_1
        begin
            if(l3_1==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(4))) && y>(35) && y<(35+((30)*(1)))) //L4_1
        begin
            if(l4_1==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(5))) && y>(35) && y<(35+((30)*(1)))) //L5_1
        begin
            if(l5_1==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
	//L2
        else if(x>(144) && x<(144+((128)*(1))) && y>(35) && y<(35+((30)*(2)))) //L1_2
        begin
            if(l1_2==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(2))) && y>(35) && y<(35+((30)*(2)))) //L2_2
        begin
            if(l2_2==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(3))) && y>(35) && y<(35+((30)*(2)))) //L3_2
        begin
            if(l3_2==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(4))) && y>(35) && y<(35+((30)*(2)))) //L4_2
        begin
            if(l4_2==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(5))) && y>(35) && y<(35+((30)*(2)))) //L5_2
        begin
            if(l5_2==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
	//L3
        else if(x>(144) && x<(144+((128)*(1))) && y>(35) && y<(35+((30)*(3)))) //L1_1
        begin
            if(l1_3==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(2))) && y>(35) && y<(35+((30)*(3)))) //L2_1
        begin
            if(l2_3==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(3))) && y>(35) && y<(35+((30)*(3)))) //L3_1
        begin
            if(l3_3==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(4))) && y>(35) && y<(35+((30)*(3)))) //L4_1
        begin
            if(l4_3==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(5))) && y>(35) && y<(35+((30)*(3)))) //L5_1
        begin
            if(l5_3==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
	//L4
        else if(x>(144) && x<(144+((128)*(1))) && y>(35) && y<(35+((30)*(4)))) //L1_2
        begin
            if(l1_4==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(2))) && y>(35) && y<(35+((30)*(4)))) //L2_2
        begin
            if(l2_4==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(3))) && y>(35) && y<(35+((30)*(4)))) //L3_2
        begin
            if(l3_4==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(4))) && y>(35) && y<(35+((30)*(4)))) //L4_2
        begin
            if(l4_4==1)
            begin
                if(color==0)
                begin
                    r=15;g=15;b=0; //Amarillo
                end
                else
                begin
                    r=15;g=15;b=15; //Blanco
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end
        else if(x>(144) && x<(144+((128)*(5))) && y>(35) && y<(35+((30)*(4)))) //L5_2
        begin
            if(l5_4==1)
            begin
                if(color==0)
                begin
                r=15;g=0;b=15; //Morado
                end
                else
                begin
                    r=0;g=15;b=15; //Cian
                end
            end
            else
            begin
                r=0;g=0;b=0; //Negro
            end
        end

//------BLOCKS COLLITION 1------//
    //Y LOW
        //L1
            if((((Py_1-10)<=(35+((30)*(1))) && (Py_1+10)>=(35+((30)*(0)))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_1==1 && Diry_1==1)) 
            begin
                Diry_1=0; l1_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(1))) && (Py_1+10)>=(35+((30)*(0)))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_1==1 && Diry_1==1)) 
            begin
                Diry_1=0; l2_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(1))) && (Py_1+10)>=(35+((30)*(0)))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_1==1 && Diry_1==1)) 
            begin
                Diry_1=0; l3_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(1))) && (Py_1+10)>=(35+((30)*(0)))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_1==1 && Diry_1==1)) 
            begin
                Diry_1=0; l4_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(1))) && (Py_1+10)>=(35+((30)*(0)))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_1==1 && Diry_1==1)) 
            begin
                Diry_1=0; l5_1=0; score=score+1; Sound_EN=1;
            end
        //L2
            if((((Py_1-10)<=(35+((30)*(2))) && (Py_1+10)>=(35+((30)*(1)))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_2==1 && Diry_1==1)) 
            begin
                Diry_1=0; l1_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(2))) && (Py_1+10)>=(35+((30)*(1)))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_2==1 && Diry_1==1)) 
            begin
                Diry_1=0; l2_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(2))) && (Py_1+10)>=(35+((30)*(1)))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_2==1 && Diry_1==1)) 
            begin
                Diry_1=0; l3_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(2))) && (Py_1+10)>=(35+((30)*(1)))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_2==1 && Diry_1==1)) 
            begin
                Diry_1=0; l4_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(2))) && (Py_1+10)>=(35+((30)*(1)))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_2==1 && Diry_1==1)) 
            begin
                Diry_1=0; l5_2=0; score=score+1; Sound_EN=1;
            end
        //L3
            if((((Py_1-10)<=(35+((30)*(3))) && (Py_1+10)>=(35+((30)*(2)))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_3==1 && Diry_1==1)) 
            begin
                Diry_1=0; l1_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(3))) && (Py_1+10)>=(35+((30)*(2)))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_3==1 && Diry_1==1)) 
            begin
                Diry_1=0; l2_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(3))) && (Py_1+10)>=(35+((30)*(2)))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_3==1 && Diry_1==1)) 
            begin
                Diry_1=0; l3_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(3))) && (Py_1+10)>=(35+((30)*(2)))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_3==1 && Diry_1==1)) 
            begin
                Diry_1=0; l4_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_1-10)<=(35+((30)*(3))) && (Py_1+10)>=(35+((30)*(2)))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_3==1 && Diry_1==1)) 
            begin
                Diry_1=0; l5_3=0; score=score+1; Sound_EN=1;
            end
        //L4
            if((((Py_1-10)<=(35+((30)*(4))) && (Py_1-10)>=(35+((30)*(3)))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_4==1 && Diry_1==1)) 
            begin
                Diry_1=0; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if((((Py_1-10)<=(35+((30)*(4))) && (Py_1-10)>=(35+((30)*(3)))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_4==1 && Diry_1==1)) 
            begin
                Diry_1=0; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if((((Py_1-10)<=(35+((30)*(4))) && (Py_1-10)>=(35+((30)*(3)))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_4==1 && Diry_1==1)) 
            begin
                Diry_1=0; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if((((Py_1-10)<=(35+((30)*(4))) && (Py_1-10)>=(35+((30)*(3)))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_4==1 && Diry_1==1)) 
            begin
                Diry_1=0; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if((((Py_1-10)<=(35+((30)*(4))) && (Py_1-10)>=(35+((30)*(3)))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_4==1 && Diry_1==1)) 
            begin
                Diry_1=0; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end
    //Y UP
        //L1
            if(((Py_1+10)>=(35+((30)*(0))) && (Py_1+10)<(35+((30)*(1))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_1==1 && Diry_1==0)) 
            begin
                Diry_1=1; l1_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(0))) && (Py_1+10)<(35+((30)*(1))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_1==1 && Diry_1==0)) 
            begin
                Diry_1=1; l2_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(0))) && (Py_1+10)<(35+((30)*(1))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_1==1 && Diry_1==0)) 
            begin
                Diry_1=1; l3_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(0))) && (Py_1+10)<(35+((30)*(1))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_1==1 && Diry_1==0)) 
            begin
                Diry_1=1; l4_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(0))) && (Py_1+10)<(35+((30)*(1))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_1==1 && Diry_1==0)) 
            begin
                Diry_1=1; l5_1=0; score=score+1; Sound_EN=1; 
            end
        //L2
            if(((Py_1+10)>=(35+((30)*(1))) && (Py_1+10)<(35+((30)*(2))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_2==1 && Diry_1==0)) 
            begin
                Diry_1=1; l1_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(1))) && (Py_1+10)<(35+((30)*(2))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_2==1 && Diry_1==0)) 
            begin
                Diry_1=1; l2_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(1))) && (Py_1+10)<(35+((30)*(2))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_2==1 && Diry_1==0)) 
            begin
                Diry_1=1; l3_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(1))) && (Py_1+10)<(35+((30)*(2))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_2==1 && Diry_1==0)) 
            begin
                Diry_1=1; l4_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(1))) && (Py_1+10)<(35+((30)*(2))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_2==1 && Diry_1==0)) 
            begin
                Diry_1=1; l5_2=0; score=score+1; Sound_EN=1; 
            end
        //L3
            if(((Py_1+10)>=(35+((30)*(2))) && (Py_1+10)<(35+((30)*(3))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_3==1 && Diry_1==0)) 
            begin
                Diry_1=1; l1_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(2))) && (Py_1+10)<(35+((30)*(3))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_3==1 && Diry_1==0)) 
            begin
                Diry_1=1; l2_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(2))) && (Py_1+10)<(35+((30)*(3))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_3==1 && Diry_1==0)) 
            begin
                Diry_1=1; l3_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(2))) && (Py_1+10)<(35+((30)*(3))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_3==1 && Diry_1==0)) 
            begin
                Diry_1=1; l4_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_1+10)>=(35+((30)*(2))) && (Py_1+10)<(35+((30)*(3))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_3==1 && Diry_1==0)) 
            begin
                Diry_1=1; l5_3=0; score=score+1; Sound_EN=1; 
            end
        //L4
            if(((Py_1+10)>=(35+((30)*(3))) && (Py_1+10)<(35+((30)*(4))) && (Px_1+10)>(144+((128)*(0))) && (Px_1-10)<(144+((128)*(1))) && l1_4==1 && Diry_1==0)) 
            begin
                Diry_1=1; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Py_1+10)>=(35+((30)*(3))) && (Py_1+10)<(35+((30)*(4))) && (Px_1+10)>(144+((128)*(1))) && (Px_1-10)<(144+((128)*(2))) && l2_4==1 && Diry_1==0)) 
            begin
                Diry_1=1; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if(((Py_1+10)>=(35+((30)*(3))) && (Py_1+10)<(35+((30)*(4))) && (Px_1+10)>(144+((128)*(2))) && (Px_1-10)<(144+((128)*(3))) && l3_4==1 && Diry_1==0)) 
            begin
                Diry_1=1; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Py_1+10)>=(35+((30)*(3))) && (Py_1+10)<(35+((30)*(4))) && (Px_1+10)>(144+((128)*(3))) && (Px_1-10)<(144+((128)*(4))) && l4_4==1 && Diry_1==0)) 
            begin
                Diry_1=1; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Py_1+10)>=(35+((30)*(3))) && (Py_1+10)<(35+((30)*(4))) && (Px_1+10)>(144+((128)*(4))) && (Px_1-10)<(144+((128)*(5))) && l5_4==1 && Diry_1==0)) 
            begin
                Diry_1=1; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end
    //X RIGHT
        //L1
            if(((Px_1-10)<=(144+((128)*(1))) && (Px_1-10)>=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l1_1==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l1_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(2))) && (Px_1-10)>=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l2_1==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l2_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(3))) && (Px_1-10)>=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l3_1==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l3_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(4))) && (Px_1-10)>=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l4_1==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l4_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(5))) && (Px_1-10)>=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l5_1==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l5_1=0; score=score+1; Sound_EN=1;
            end
        //L2
            if(((Px_1-10)<=(144+((128)*(1))) && (Px_1-10)>=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l1_2==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l1_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(2))) && (Px_1-10)>=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l2_2==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l2_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(3))) && (Px_1-10)>=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l3_2==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l3_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(4))) && (Px_1-10)>=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l4_2==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l4_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(5))) && (Px_1-10)>=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l5_2==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l5_2=0; score=score+1; Sound_EN=1;
            end
        //L3
            if(((Px_1-10)<=(144+((128)*(1))) && (Px_1-10)>=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l1_3==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l1_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(2))) && (Px_1-10)>=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l2_3==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l2_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(3))) && (Px_1-10)>=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l3_3==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l3_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(4))) && (Px_1-10)>=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l4_3==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l4_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1-10)<=(144+((128)*(5))) && (Px_1-10)>=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l5_3==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l5_3=0; score=score+1; Sound_EN=1;
            end
        //L4
            if(((Px_1-10)<=(144+((128)*(1))) && (Px_1-10)>=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l1_4==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Px_1-10)<=(144+((128)*(2))) && (Px_1-10)>=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l2_4==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l2_4=0; score=score+1; Sound_EN=1;  POWER_4=1;
            end
            if(((Px_1-10)<=(144+((128)*(3))) && (Px_1-10)>=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l3_4==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Px_1-10)<=(144+((128)*(4))) && (Px_1-10)>=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l4_4==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Px_1-10)<=(144+((128)*(5))) && (Px_1-10)>=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l5_4==1 && Dirx_1==1)) 
            begin
                Dirx_1=0; l5_4=0; score=score+1; Sound_EN=1;  POWER_5=1;
            end
    //X LEFT
        //L1
            if(((Px_1+10)>=(144+((128)*(1))) && (Px_1+10)<=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l1_1==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l1_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(2))) && (Px_1+10)<=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l2_1==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l2_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(3))) && (Px_1+10)<=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l3_1==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l3_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(4))) && (Px_1+10)<=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l4_1==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l4_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(5))) && (Px_1+10)<=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(1))) && (Py_1-10)>(35+((30)*(0))) && l5_1==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l5_1=0; score=score+1; Sound_EN=1;            
            end
        //L2
            if(((Px_1+10)>=(144+((128)*(1))) && (Px_1+10)<=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l1_2==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l1_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(2))) && (Px_1+10)<=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l2_2==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l2_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(3))) && (Px_1+10)<=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l3_2==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l3_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(4))) && (Px_1+10)<=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l4_2==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l4_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(5))) && (Px_1+10)<=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(2))) && (Py_1-10)>(35+((30)*(1))) && l5_2==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l5_2=0; score=score+1; Sound_EN=1;            
            end
        //L3
            if(((Px_1+10)>=(144+((128)*(1))) && (Px_1+10)<=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l1_3==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l1_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(2))) && (Px_1+10)<=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l2_3==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l2_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(3))) && (Px_1+10)<=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l3_3==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l3_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(4))) && (Px_1+10)<=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l4_3==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l4_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_1+10)>=(144+((128)*(5))) && (Px_1+10)<=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(3))) && (Py_1-10)>(35+((30)*(2))) && l5_3==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l5_3=0; score=score+1; Sound_EN=1;            
            end
        //L4
            if(((Px_1+10)>=(144+((128)*(1))) && (Px_1+10)<=(144+((128)*(0))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l1_4==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Px_1+10)>=(144+((128)*(2))) && (Px_1+10)<=(144+((128)*(1))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l2_4==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if(((Px_1+10)>=(144+((128)*(3))) && (Px_1+10)<=(144+((128)*(2))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l3_4==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Px_1+10)>=(144+((128)*(4))) && (Px_1+10)<=(144+((128)*(3))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l4_4==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Px_1+10)>=(144+((128)*(5))) && (Px_1+10)<=(144+((128)*(4))) && (Py_1+10)<(35+((30)*(4))) && (Py_1-10)>(35+((30)*(3))) && l5_4==1 && Dirx_1==0)) 
            begin
                Dirx_1=1; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end

//------BLOCKS COLLITION 2------//
    //Y LOW
        //L1
            if((((Py_2-10)<=(35+((30)*(1))) && (Py_2+10)>=(35+((30)*(0)))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_1==1 && Diry_2==1)) 
            begin
                Diry_2=0; l1_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(1))) && (Py_2+10)>=(35+((30)*(0)))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_1==1 && Diry_2==1)) 
            begin
                Diry_2=0; l2_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(1))) && (Py_2+10)>=(35+((30)*(0)))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_1==1 && Diry_2==1)) 
            begin
                Diry_2=0; l3_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(1))) && (Py_2+10)>=(35+((30)*(0)))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_1==1 && Diry_2==1)) 
            begin
                Diry_2=0; l4_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(1))) && (Py_2+10)>=(35+((30)*(0)))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_1==1 && Diry_2==1)) 
            begin
                Diry_2=0; l5_1=0; score=score+1; Sound_EN=1;
            end
        //L2
            if((((Py_2-10)<=(35+((30)*(2))) && (Py_2+10)>=(35+((30)*(1)))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_2==1 && Diry_2==1)) 
            begin
                Diry_2=0; l1_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(2))) && (Py_2+10)>=(35+((30)*(1)))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_2==1 && Diry_2==1)) 
            begin
                Diry_2=0; l2_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(2))) && (Py_2+10)>=(35+((30)*(1)))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_2==1 && Diry_2==1)) 
            begin
                Diry_2=0; l3_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(2))) && (Py_2+10)>=(35+((30)*(1)))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_2==1 && Diry_2==1)) 
            begin
                Diry_2=0; l4_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(2))) && (Py_2+10)>=(35+((30)*(1)))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_2==1 && Diry_2==1)) 
            begin
                Diry_2=0; l5_2=0; score=score+1; Sound_EN=1;
            end
        //L3
            if((((Py_2-10)<=(35+((30)*(3))) && (Py_2+10)>=(35+((30)*(2)))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_3==1 && Diry_2==1)) 
            begin
                Diry_2=0; l1_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(3))) && (Py_2+10)>=(35+((30)*(2)))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_3==1 && Diry_2==1)) 
            begin
                Diry_2=0; l2_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(3))) && (Py_2+10)>=(35+((30)*(2)))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_3==1 && Diry_2==1)) 
            begin
                Diry_2=0; l3_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(3))) && (Py_2+10)>=(35+((30)*(2)))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_3==1 && Diry_2==1)) 
            begin
                Diry_2=0; l4_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_2-10)<=(35+((30)*(3))) && (Py_2+10)>=(35+((30)*(2)))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_3==1 && Diry_2==1)) 
            begin
                Diry_2=0; l5_3=0; score=score+1; Sound_EN=1;
            end
        //L4
            if((((Py_2-10)<=(35+((30)*(4))) && (Py_2-10)>=(35+((30)*(3)))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_4==1 && Diry_2==1)) 
            begin
                Diry_2=0; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if((((Py_2-10)<=(35+((30)*(4))) && (Py_2-10)>=(35+((30)*(3)))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_4==1 && Diry_2==1)) 
            begin
                Diry_2=0; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if((((Py_2-10)<=(35+((30)*(4))) && (Py_2-10)>=(35+((30)*(3)))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_4==1 && Diry_2==1)) 
            begin
                Diry_2=0; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if((((Py_2-10)<=(35+((30)*(4))) && (Py_2-10)>=(35+((30)*(3)))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_4==1 && Diry_2==1)) 
            begin
                Diry_2=0; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if((((Py_2-10)<=(35+((30)*(4))) && (Py_2-10)>=(35+((30)*(3)))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_4==1 && Diry_2==1)) 
            begin
                Diry_2=0; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end
    //Y UP
        //L1
            if(((Py_2+10)>=(35+((30)*(0))) && (Py_2+10)<(35+((30)*(1))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_1==1 && Diry_2==0)) 
            begin
                Diry_2=1; l1_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(0))) && (Py_2+10)<(35+((30)*(1))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_1==1 && Diry_2==0)) 
            begin
                Diry_2=1; l2_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(0))) && (Py_2+10)<(35+((30)*(1))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_1==1 && Diry_2==0)) 
            begin
                Diry_2=1; l3_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(0))) && (Py_2+10)<(35+((30)*(1))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_1==1 && Diry_2==0)) 
            begin
                Diry_2=1; l4_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(0))) && (Py_2+10)<(35+((30)*(1))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_1==1 && Diry_2==0)) 
            begin
                Diry_2=1; l5_1=0; score=score+1; Sound_EN=1; 
            end
        //L2
            if(((Py_2+10)>=(35+((30)*(1))) && (Py_2+10)<(35+((30)*(2))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_2==1 && Diry_2==0)) 
            begin
                Diry_2=1; l1_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(1))) && (Py_2+10)<(35+((30)*(2))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_2==1 && Diry_2==0)) 
            begin
                Diry_2=1; l2_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(1))) && (Py_2+10)<(35+((30)*(2))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_2==1 && Diry_2==0)) 
            begin
                Diry_2=1; l3_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(1))) && (Py_2+10)<(35+((30)*(2))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_2==1 && Diry_2==0)) 
            begin
                Diry_2=1; l4_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(1))) && (Py_2+10)<(35+((30)*(2))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_2==1 && Diry_2==0)) 
            begin
                Diry_2=1; l5_2=0; score=score+1; Sound_EN=1; 
            end
        //L3
            if(((Py_2+10)>=(35+((30)*(2))) && (Py_2+10)<(35+((30)*(3))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_3==1 && Diry_2==0)) 
            begin
                Diry_2=1; l1_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(2))) && (Py_2+10)<(35+((30)*(3))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_3==1 && Diry_2==0)) 
            begin
                Diry_2=1; l2_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(2))) && (Py_2+10)<(35+((30)*(3))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_3==1 && Diry_2==0)) 
            begin
                Diry_2=1; l3_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(2))) && (Py_2+10)<(35+((30)*(3))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_3==1 && Diry_2==0)) 
            begin
                Diry_2=1; l4_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_2+10)>=(35+((30)*(2))) && (Py_2+10)<(35+((30)*(3))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_3==1 && Diry_2==0)) 
            begin
                Diry_2=1; l5_3=0; score=score+1; Sound_EN=1; 
            end
        //L4
            if(((Py_2+10)>=(35+((30)*(3))) && (Py_2+10)<(35+((30)*(4))) && (Px_2+10)>(144+((128)*(0))) && (Px_2-10)<(144+((128)*(1))) && l1_4==1 && Diry_2==0)) 
            begin
                Diry_2=1; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Py_2+10)>=(35+((30)*(3))) && (Py_2+10)<(35+((30)*(4))) && (Px_2+10)>(144+((128)*(1))) && (Px_2-10)<(144+((128)*(2))) && l2_4==1 && Diry_2==0)) 
            begin
                Diry_2=1; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if(((Py_2+10)>=(35+((30)*(3))) && (Py_2+10)<(35+((30)*(4))) && (Px_2+10)>(144+((128)*(2))) && (Px_2-10)<(144+((128)*(3))) && l3_4==1 && Diry_2==0)) 
            begin
                Diry_2=1; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Py_2+10)>=(35+((30)*(3))) && (Py_2+10)<(35+((30)*(4))) && (Px_2+10)>(144+((128)*(3))) && (Px_2-10)<(144+((128)*(4))) && l4_4==1 && Diry_2==0)) 
            begin
                Diry_2=1; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Py_2+10)>=(35+((30)*(3))) && (Py_2+10)<(35+((30)*(4))) && (Px_2+10)>(144+((128)*(4))) && (Px_2-10)<(144+((128)*(5))) && l5_4==1 && Diry_2==0)) 
            begin
                Diry_2=1; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end
    //X RIGHT
        //L1
            if(((Px_2-10)<=(144+((128)*(1))) && (Px_2-10)>=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l1_1==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l1_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(2))) && (Px_2-10)>=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l2_1==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l2_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(3))) && (Px_2-10)>=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l3_1==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l3_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(4))) && (Px_2-10)>=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l4_1==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l4_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(5))) && (Px_2-10)>=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l5_1==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l5_1=0; score=score+1; Sound_EN=1;
            end
        //L2
            if(((Px_2-10)<=(144+((128)*(1))) && (Px_2-10)>=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l1_2==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l1_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(2))) && (Px_2-10)>=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l2_2==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l2_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(3))) && (Px_2-10)>=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l3_2==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l3_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(4))) && (Px_2-10)>=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l4_2==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l4_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(5))) && (Px_2-10)>=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l5_2==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l5_2=0; score=score+1; Sound_EN=1;
            end
        //L3
            if(((Px_2-10)<=(144+((128)*(1))) && (Px_2-10)>=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l1_3==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l1_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(2))) && (Px_2-10)>=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l2_3==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l2_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(3))) && (Px_2-10)>=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l3_3==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l3_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(4))) && (Px_2-10)>=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l4_3==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l4_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2-10)<=(144+((128)*(5))) && (Px_2-10)>=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l5_3==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l5_3=0; score=score+1; Sound_EN=1;
            end
        //L4
            if(((Px_2-10)<=(144+((128)*(1))) && (Px_2-10)>=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l1_4==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Px_2-10)<=(144+((128)*(2))) && (Px_2-10)>=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l2_4==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l2_4=0; score=score+1; Sound_EN=1;  POWER_4=1;
            end
            if(((Px_2-10)<=(144+((128)*(3))) && (Px_2-10)>=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l3_4==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Px_2-10)<=(144+((128)*(4))) && (Px_2-10)>=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l4_4==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Px_2-10)<=(144+((128)*(5))) && (Px_2-10)>=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l5_4==1 && Dirx_2==1)) 
            begin
                Dirx_2=0; l5_4=0; score=score+1; Sound_EN=1;  POWER_5=1;
            end
    //X LEFT
        //L1
            if(((Px_2+10)>=(144+((128)*(1))) && (Px_2+10)<=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l1_1==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l1_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(2))) && (Px_2+10)<=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l2_1==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l2_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(3))) && (Px_2+10)<=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l3_1==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l3_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(4))) && (Px_2+10)<=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l4_1==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l4_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(5))) && (Px_2+10)<=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(1))) && (Py_2-10)>(35+((30)*(0))) && l5_1==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l5_1=0; score=score+1; Sound_EN=1;            
            end
        //L2
            if(((Px_2+10)>=(144+((128)*(1))) && (Px_2+10)<=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l1_2==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l1_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(2))) && (Px_2+10)<=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l2_2==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l2_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(3))) && (Px_2+10)<=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l3_2==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l3_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(4))) && (Px_2+10)<=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l4_2==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l4_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(5))) && (Px_2+10)<=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(2))) && (Py_2-10)>(35+((30)*(1))) && l5_2==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l5_2=0; score=score+1; Sound_EN=1;            
            end
        //L3
            if(((Px_2+10)>=(144+((128)*(1))) && (Px_2+10)<=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l1_3==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l1_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(2))) && (Px_2+10)<=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l2_3==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l2_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(3))) && (Px_2+10)<=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l3_3==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l3_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(4))) && (Px_2+10)<=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l4_3==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l4_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_2+10)>=(144+((128)*(5))) && (Px_2+10)<=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(3))) && (Py_2-10)>(35+((30)*(2))) && l5_3==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l5_3=0; score=score+1; Sound_EN=1;            
            end
        //L4
            if(((Px_2+10)>=(144+((128)*(1))) && (Px_2+10)<=(144+((128)*(0))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l1_4==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Px_2+10)>=(144+((128)*(2))) && (Px_2+10)<=(144+((128)*(1))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l2_4==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if(((Px_2+10)>=(144+((128)*(3))) && (Px_2+10)<=(144+((128)*(2))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l3_4==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Px_2+10)>=(144+((128)*(4))) && (Px_2+10)<=(144+((128)*(3))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l4_4==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Px_2+10)>=(144+((128)*(5))) && (Px_2+10)<=(144+((128)*(4))) && (Py_2+10)<(35+((30)*(4))) && (Py_2-10)>(35+((30)*(3))) && l5_4==1 && Dirx_2==0)) 
            begin
                Dirx_2=1; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end

//------BLOCKS COLLITION 3------//
    //Y LOW
        //L1
            if((((Py_3-10)<=(35+((30)*(1))) && (Py_3+10)>=(35+((30)*(0)))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_1==1 && Diry_3==1)) 
            begin
                Diry_3=0; l1_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(1))) && (Py_3+10)>=(35+((30)*(0)))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_1==1 && Diry_3==1)) 
            begin
                Diry_3=0; l2_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(1))) && (Py_3+10)>=(35+((30)*(0)))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_1==1 && Diry_3==1)) 
            begin
                Diry_3=0; l3_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(1))) && (Py_3+10)>=(35+((30)*(0)))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_1==1 && Diry_3==1)) 
            begin
                Diry_3=0; l4_1=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(1))) && (Py_3+10)>=(35+((30)*(0)))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_1==1 && Diry_3==1)) 
            begin
                Diry_3=0; l5_1=0; score=score+1; Sound_EN=1;
            end
        //L2
            if((((Py_3-10)<=(35+((30)*(2))) && (Py_3+10)>=(35+((30)*(1)))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_2==1 && Diry_3==1)) 
            begin
                Diry_3=0; l1_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(2))) && (Py_3+10)>=(35+((30)*(1)))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_2==1 && Diry_3==1)) 
            begin
                Diry_3=0; l2_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(2))) && (Py_3+10)>=(35+((30)*(1)))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_2==1 && Diry_3==1)) 
            begin
                Diry_3=0; l3_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(2))) && (Py_3+10)>=(35+((30)*(1)))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_2==1 && Diry_3==1)) 
            begin
                Diry_3=0; l4_2=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(2))) && (Py_3+10)>=(35+((30)*(1)))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_2==1 && Diry_3==1)) 
            begin
                Diry_3=0; l5_2=0; score=score+1; Sound_EN=1;
            end
        //L3
            if((((Py_3-10)<=(35+((30)*(3))) && (Py_3+10)>=(35+((30)*(2)))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_3==1 && Diry_3==1)) 
            begin
                Diry_3=0; l1_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(3))) && (Py_3+10)>=(35+((30)*(2)))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_3==1 && Diry_3==1)) 
            begin
                Diry_3=0; l2_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(3))) && (Py_3+10)>=(35+((30)*(2)))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_3==1 && Diry_3==1)) 
            begin
                Diry_3=0; l3_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(3))) && (Py_3+10)>=(35+((30)*(2)))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_3==1 && Diry_3==1)) 
            begin
                Diry_3=0; l4_3=0; score=score+1; Sound_EN=1;
            end
            if((((Py_3-10)<=(35+((30)*(3))) && (Py_3+10)>=(35+((30)*(2)))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_3==1 && Diry_3==1)) 
            begin
                Diry_3=0; l5_3=0; score=score+1; Sound_EN=1;
            end
        //L4
            if((((Py_3-10)<=(35+((30)*(4))) && (Py_3-10)>=(35+((30)*(3)))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_4==1 && Diry_3==1)) 
            begin
                Diry_3=0; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if((((Py_3-10)<=(35+((30)*(4))) && (Py_3-10)>=(35+((30)*(3)))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_4==1 && Diry_3==1)) 
            begin
                Diry_3=0; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if((((Py_3-10)<=(35+((30)*(4))) && (Py_3-10)>=(35+((30)*(3)))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_4==1 && Diry_3==1)) 
            begin
                Diry_3=0; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if((((Py_3-10)<=(35+((30)*(4))) && (Py_3-10)>=(35+((30)*(3)))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_4==1 && Diry_3==1)) 
            begin
                Diry_3=0; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if((((Py_3-10)<=(35+((30)*(4))) && (Py_3-10)>=(35+((30)*(3)))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_4==1 && Diry_3==1)) 
            begin
                Diry_3=0; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end
    //Y UP
        //L1
            if(((Py_3+10)>=(35+((30)*(0))) && (Py_3+10)<(35+((30)*(1))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_1==1 && Diry_3==0)) 
            begin
                Diry_3=1; l1_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(0))) && (Py_3+10)<(35+((30)*(1))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_1==1 && Diry_3==0)) 
            begin
                Diry_3=1; l2_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(0))) && (Py_3+10)<(35+((30)*(1))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_1==1 && Diry_3==0)) 
            begin
                Diry_3=1; l3_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(0))) && (Py_3+10)<(35+((30)*(1))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_1==1 && Diry_3==0)) 
            begin
                Diry_3=1; l4_1=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(0))) && (Py_3+10)<(35+((30)*(1))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_1==1 && Diry_3==0)) 
            begin
                Diry_3=1; l5_1=0; score=score+1; Sound_EN=1; 
            end
        //L2
            if(((Py_3+10)>=(35+((30)*(1))) && (Py_3+10)<(35+((30)*(2))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_2==1 && Diry_3==0)) 
            begin
                Diry_3=1; l1_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(1))) && (Py_3+10)<(35+((30)*(2))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_2==1 && Diry_3==0)) 
            begin
                Diry_3=1; l2_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(1))) && (Py_3+10)<(35+((30)*(2))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_2==1 && Diry_3==0)) 
            begin
                Diry_3=1; l3_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(1))) && (Py_3+10)<(35+((30)*(2))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_2==1 && Diry_3==0)) 
            begin
                Diry_3=1; l4_2=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(1))) && (Py_3+10)<(35+((30)*(2))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_2==1 && Diry_3==0)) 
            begin
                Diry_3=1; l5_2=0; score=score+1; Sound_EN=1; 
            end
        //L3
            if(((Py_3+10)>=(35+((30)*(2))) && (Py_3+10)<(35+((30)*(3))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_3==1 && Diry_3==0)) 
            begin
                Diry_3=1; l1_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(2))) && (Py_3+10)<(35+((30)*(3))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_3==1 && Diry_3==0)) 
            begin
                Diry_3=1; l2_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(2))) && (Py_3+10)<(35+((30)*(3))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_3==1 && Diry_3==0)) 
            begin
                Diry_3=1; l3_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(2))) && (Py_3+10)<(35+((30)*(3))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_3==1 && Diry_3==0)) 
            begin
                Diry_3=1; l4_3=0; score=score+1; Sound_EN=1; 
            end
            if(((Py_3+10)>=(35+((30)*(2))) && (Py_3+10)<(35+((30)*(3))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_3==1 && Diry_3==0)) 
            begin
                Diry_3=1; l5_3=0; score=score+1; Sound_EN=1; 
            end
        //L4
            if(((Py_3+10)>=(35+((30)*(3))) && (Py_3+10)<(35+((30)*(4))) && (Px_3+10)>(144+((128)*(0))) && (Px_3-10)<(144+((128)*(1))) && l1_4==1 && Diry_3==0)) 
            begin
                Diry_3=1; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Py_3+10)>=(35+((30)*(3))) && (Py_3+10)<(35+((30)*(4))) && (Px_3+10)>(144+((128)*(1))) && (Px_3-10)<(144+((128)*(2))) && l2_4==1 && Diry_3==0)) 
            begin
                Diry_3=1; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if(((Py_3+10)>=(35+((30)*(3))) && (Py_3+10)<(35+((30)*(4))) && (Px_3+10)>(144+((128)*(2))) && (Px_3-10)<(144+((128)*(3))) && l3_4==1 && Diry_3==0)) 
            begin
                Diry_3=1; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Py_3+10)>=(35+((30)*(3))) && (Py_3+10)<(35+((30)*(4))) && (Px_3+10)>(144+((128)*(3))) && (Px_3-10)<(144+((128)*(4))) && l4_4==1 && Diry_3==0)) 
            begin
                Diry_3=1; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Py_3+10)>=(35+((30)*(3))) && (Py_3+10)<(35+((30)*(4))) && (Px_3+10)>(144+((128)*(4))) && (Px_3-10)<(144+((128)*(5))) && l5_4==1 && Diry_3==0)) 
            begin
                Diry_3=1; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end
    //X RIGHT
        //L1
            if(((Px_3-10)<=(144+((128)*(1))) && (Px_3-10)>=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l1_1==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l1_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(2))) && (Px_3-10)>=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l2_1==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l2_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(3))) && (Px_3-10)>=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l3_1==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l3_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(4))) && (Px_3-10)>=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l4_1==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l4_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(5))) && (Px_3-10)>=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l5_1==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l5_1=0; score=score+1; Sound_EN=1;
            end
        //L2
            if(((Px_3-10)<=(144+((128)*(1))) && (Px_3-10)>=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l1_2==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l1_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(2))) && (Px_3-10)>=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l2_2==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l2_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(3))) && (Px_3-10)>=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l3_2==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l3_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(4))) && (Px_3-10)>=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l4_2==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l4_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(5))) && (Px_3-10)>=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l5_2==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l5_2=0; score=score+1; Sound_EN=1;
            end
        //L3
            if(((Px_3-10)<=(144+((128)*(1))) && (Px_3-10)>=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l1_3==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l1_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(2))) && (Px_3-10)>=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l2_3==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l2_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(3))) && (Px_3-10)>=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l3_3==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l3_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(4))) && (Px_3-10)>=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l4_3==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l4_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3-10)<=(144+((128)*(5))) && (Px_3-10)>=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l5_3==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l5_3=0; score=score+1; Sound_EN=1;
            end
        //L4
            if(((Px_3-10)<=(144+((128)*(1))) && (Px_3-10)>=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l1_4==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Px_3-10)<=(144+((128)*(2))) && (Px_3-10)>=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l2_4==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l2_4=0; score=score+1; Sound_EN=1;  POWER_4=1;
            end
            if(((Px_3-10)<=(144+((128)*(3))) && (Px_3-10)>=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l3_4==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Px_3-10)<=(144+((128)*(4))) && (Px_3-10)>=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l4_4==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Px_3-10)<=(144+((128)*(5))) && (Px_3-10)>=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l5_4==1 && Dirx_3==1)) 
            begin
                Dirx_3=0; l5_4=0; score=score+1; Sound_EN=1;  POWER_5=1;
            end
    //X LEFT
        //L1
            if(((Px_3+10)>=(144+((128)*(1))) && (Px_3+10)<=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l1_1==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l1_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(2))) && (Px_3+10)<=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l2_1==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l2_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(3))) && (Px_3+10)<=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l3_1==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l3_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(4))) && (Px_3+10)<=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l4_1==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l4_1=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(5))) && (Px_3+10)<=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(1))) && (Py_3-10)>(35+((30)*(0))) && l5_1==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l5_1=0; score=score+1; Sound_EN=1;            
            end
        //L2
            if(((Px_3+10)>=(144+((128)*(1))) && (Px_3+10)<=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l1_2==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l1_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(2))) && (Px_3+10)<=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l2_2==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l2_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(3))) && (Px_3+10)<=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l3_2==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l3_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(4))) && (Px_3+10)<=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l4_2==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l4_2=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(5))) && (Px_3+10)<=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(2))) && (Py_3-10)>(35+((30)*(1))) && l5_2==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l5_2=0; score=score+1; Sound_EN=1;            
            end
        //L3
            if(((Px_3+10)>=(144+((128)*(1))) && (Px_3+10)<=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l1_3==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l1_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(2))) && (Px_3+10)<=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l2_3==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l2_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(3))) && (Px_3+10)<=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l3_3==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l3_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(4))) && (Px_3+10)<=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l4_3==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l4_3=0; score=score+1; Sound_EN=1;
            end
            if(((Px_3+10)>=(144+((128)*(5))) && (Px_3+10)<=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(3))) && (Py_3-10)>(35+((30)*(2))) && l5_3==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l5_3=0; score=score+1; Sound_EN=1;            
            end
        //L4
            if(((Px_3+10)>=(144+((128)*(1))) && (Px_3+10)<=(144+((128)*(0))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l1_4==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l1_4=0; score=score+1; Sound_EN=1; POWER_3=1;
            end
            if(((Px_3+10)>=(144+((128)*(2))) && (Px_3+10)<=(144+((128)*(1))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l2_4==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l2_4=0; score=score+1; Sound_EN=1; POWER_4=1;
            end
            if(((Px_3+10)>=(144+((128)*(3))) && (Px_3+10)<=(144+((128)*(2))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l3_4==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l3_4=0; score=score+1; Sound_EN=1; POWER_2=1;
            end
            if(((Px_3+10)>=(144+((128)*(4))) && (Px_3+10)<=(144+((128)*(3))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l4_4==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l4_4=0; score=score+1; Sound_EN=1; POWER_1=1;
            end
            if(((Px_3+10)>=(144+((128)*(5))) && (Px_3+10)<=(144+((128)*(4))) && (Py_3+10)<(35+((30)*(4))) && (Py_3-10)>(35+((30)*(3))) && l5_4==1 && Dirx_3==0)) 
            begin
                Dirx_3=1; l5_4=0; score=score+1; Sound_EN=1; POWER_5=1;
            end

//------BALL 3 DRAW------//
	if((100)>=((Px_3-x)*(Px_3-x))+((Py_3-y)*(Py_3-y)))
	begin
        if(BALL_3_ON==1)
        begin
            if(life==3)
            begin
                r=15;g=15;b=15;
            end
            if(life==2)
            begin
                r=15;g=15;b=0;
            end
            if(life==1)
            begin
                r=15;g=0;b=0;
            end
        end
        if(BALL_3_ON==0)
        begin
            r=0;g=0;b=0;
        end
	end

//------BALL 2 DRAW------//
	if((100)>=((Px_2-x)*(Px_2-x))+((Py_2-y)*(Py_2-y)))
	begin
        if(BALL_2_ON==1)
        begin
            if(life==3)
            begin
                r=15;g=15;b=15;
            end
            if(life==2)
            begin
                r=15;g=15;b=0;
            end
            if(life==1)
            begin
                r=15;g=0;b=0;
            end
        end
        if(BALL_2_ON==0)
        begin
            r=0;g=0;b=0;
        end
	end

//------BALL 1 DRAW------//
	if((100)>=((Px_1-x)*(Px_1-x))+((Py_1-y)*(Py_1-y)))
	begin
        if(BALL_1_ON==1)
        begin
            if(life==3)
            begin
                r=15;g=15;b=15;
            end
            if(life==2)
            begin
                r=15;g=15;b=0;
            end
            if(life==1)
            begin
                r=15;g=0;b=0;
            end
        end
        if(BALL_1_ON==0)
        begin
            r=0;g=0;b=0;
        end
	end

//------DIRECTIONS BALL 1------//
	if((Px_1+10)>=784) Dirx_1=1;
	if((Px_1-10)<=144) Dirx_1=0;
    //if((Py_1+10)>=515) Diry_1=1;//NO
	if((Py_1-10)<=35) Diry_1=0;
	//Colision con BAR
	    if((Py_1+12)>=(515-20) && (Py_1+12)<=(515) && (Px_1+10)>(l_x) && (Px_1-10)<(l_x+ln_barra)) 
        begin 
            Diry_1=1; Sound_EN=1;
        end
        if((Px_1-10)<=(l_x+ln_barra) && (Px_1-10)>=(l_x+ln_barra-1) && (Py_1+10)>=(515-20) && (Py_1+10)<=(515) && Dirx_1==1) 
        begin 
            Dirx_1=0; Diry_1=1; Sound_EN=1;
        end	
        if((Px_1+10)>=(l_x) && (Px_1+10)<=(l_x+1) && (Py_1+10)>=(515-20) && (Py_1+10)<=(515) && Dirx_1==0) 
        begin 
            Dirx_1=1; Diry_1=1; Sound_EN=1;
        end

//------DIRECTIONS BALL 2------//
	if((Px_2+10)>=784) Dirx_2=1;
	if((Px_2-10)<=144) Dirx_2=0;
    //if((Py_2+10)>=515) Diry_2=1;//NO
	if((Py_2-10)<=35) Diry_2=0;
	//Colision con BAR
	    if((Py_2+12)>=(515-20) && (Py_2+12)<=(515) && (Px_2+10)>(l_x) && (Px_2-10)<(l_x+ln_barra)) 
        begin 
            Diry_2=1; Sound_EN=1;
        end
        if((Px_2-10)<=(l_x+ln_barra) && (Px_2-10)>=(l_x+ln_barra-1) && (Py_2+10)>=(515-20) && (Py_2+10)<=(515) && Dirx_2==1) 
        begin 
            Dirx_2=0; Diry_2=1; Sound_EN=1;
        end	
        if((Px_2+10)>=(l_x) && (Px_2+10)<=(l_x+1) && (Py_2+10)>=(515-20) && (Py_2+10)<=(515) && Dirx_2==0) 
        begin 
            Dirx_2=1; Diry_2=1; Sound_EN=1;
        end		

//------DIRECTIONS BALL 3------//
	if((Px_3+10)>=784) Dirx_3=1;
	if((Px_3-10)<=144) Dirx_3=0;
    //if((Py_3+10)>=515) Diry_3=1;//NO
	if((Py_3-10)<=35) Diry_3=0;
	//Colision con BAR
	    if((Py_3+12)>=(515-20) && (Py_3+12)<=(515) && (Px_3+10)>(l_x) && (Px_3-10)<(l_x+ln_barra)) 
        begin 
            Diry_3=1; Sound_EN=1;
        end
        if((Px_3-10)<=(l_x+ln_barra) && (Px_3-10)>=(l_x+ln_barra-1) && (Py_3+10)>=(515-20) && (Py_3+10)<=(515) && Dirx_3==1) 
        begin 
            Dirx_2=0; Diry_3=1; Sound_EN=1;
        end	
        if((Px_3+10)>=(l_x) && (Px_3+10)<=(l_x+1) && (Py_3+10)>=(515-20) && (Py_3+10)<=(515) && Dirx_2==0) 
        begin 
            Dirx_2=1; Diry_3=1; Sound_EN=1;
        end	

//------MULTI BALL CONTROL------//
    //BALL OUT
    if((Py_1+10)>=600)
    begin
        BALL_1_ON=0;
        Vel_BALL_X_1=0;
        Vel_BALL_Y_1=0;
    end
    if((Py_2+10)>=600)
    begin
        BALL_2_ON=0;
        Vel_BALL_X_2=0;
        Vel_BALL_Y_2=0;
    end
    if((Py_3+10)>=600)
    begin
        BALL_3_ON=0;
        Vel_BALL_X_3=0;
        Vel_BALL_Y_3=0;
    end
    
    //SPAWN BALLS
    if(BALL_1_ON==1)    
    begin
        Vel_BALL_X_1=Vel_BALL_X;
        Vel_BALL_Y_1=Vel_BALL_Y;
    end
    if(BALL_2_ON==1)    
    begin
        Vel_BALL_X_2=Vel_BALL_X;
        Vel_BALL_Y_2=Vel_BALL_Y;     
    end
    if(BALL_3_ON==1)    
    begin
        Vel_BALL_X_3=Vel_BALL_X;
        Vel_BALL_Y_3=Vel_BALL_Y;
    end

//------BAR DRAW------//
	if(x>(l_x) && x<(l_x+ln_barra) && y>(l_y) && y<(l_y+20))
	begin
		r=15;g=15;b=15;
	end

//------POWER UP------//

    //BALL POWER UP FALL 1 (Increase BAR)
        if(POWER_1==1) PB_Fall_1=1;
        else PB_Fall_1=0;
        //BAR POWER
        if((PB_1y+9)>=(515-20) && (PB_1x+7)>(l_x) && (PB_1x-7)<(l_x+ln_barra)) 
        begin
            POWER_1=0; PB_1y=150; BAR_OP=BAR_OP+30;
        end
        //FALL OUT
        if((PB_1y+9)>=515)
        begin
            POWER_1=0; PB_1y=150;
        end

    //BALL POWER UP FALL 2 (Fast BAR)
        if(POWER_2==1) PB_Fall_2=1;
        else PB_Fall_2=0;
        //BAR POWER
        if((PB_2y+9)>=(515-20) && (PB_2x+7)>(l_x) && (PB_2x-7)<(l_x+ln_barra)) 
        begin
            POWER_2=0; PB_2y=150; VEL_BAR=VEL_BAR+2;
        end
        //FALL OUT
        if((PB_2y+9)>=515)
        begin
            POWER_2=0; PB_2y=150;
        end
    
    //BALL POWER UP FALL 3 (MULTI BALL)
        if(POWER_3==1) PB_Fall_3=1;
        else PB_Fall_3=0;
        //BAR POWER
        if((PB_3y+9)>=(515-20) && (PB_3x+7)>(l_x) && (PB_3x-7)<(l_x+ln_barra)) 
        begin
            POWER_3=0; PB_3y=150;
            if(BALL_1_ON==0) 
            begin 
                BALL_1_ON=1;
                Dirx_1=0;Diry_1=0;
            end
            else if(BALL_1_ON==1 && BALL_2_ON==0)
            begin 
                BALL_2_ON=1;
                Dirx_2=0;Diry_2=0;
            end
            else if(BALL_1_ON==1 && BALL_2_ON==1 && BALL_3_ON==0) 
            begin
                BALL_3_ON=1;
                Dirx_3=0;Diry_3=0;
            end
        end
        //FALL OUT
        if((PB_3y+9)>=515) 
        begin
            POWER_3=0; PB_3y=150;
        end

//------POWER DOWN------// 
    //BALL POWER UP FALL 4 (Decrease BAR)
        if(POWER_4==1) PB_Fall_4=1;
        else PB_Fall_4=0;
        //BAR POWER
        if((PB_4y+9)>=(515-20) && (PB_4x+7)>(l_x) && (PB_4x-7)<(l_x+ln_barra)) 
        begin
            POWER_4=0; PB_4y=150; BAR_OP=BAR_OP-30;
        end
        //FALL OUT
        if((PB_4y+9)>=515)
        begin
            POWER_4=0; PB_4y=150;
        end
        ln_barra=100+BAR_OP;

    //BALL POWER UP FALL 5 (Slow BAR)
        if(POWER_5==1) PB_Fall_5=1;
        else PB_Fall_5=0;
        //BAR POWER
        if((PB_5y+9)>=(515-20) && (PB_5x+7)>(l_x) && (PB_5x-7)<(l_x+ln_barra)) 
        begin
            POWER_5=0; PB_5y=150; VEL_BAR=VEL_BAR-1;
        end
        //FALL OUT
        if((PB_5y+9)>=515)
        begin
            POWER_5=0; PB_5y=150; PB_Fall_5=0;
        end
CHECK=POWER_5+PB_Fall_5;
//------SOUND Control------//
    //Bounce
        if(Sound_EN==1) 
        begin
            Aux_Time=Aux_Time+1;
        end
        if(Aux_Time>=2_500_000)
        begin
            Aux_Time=0; Aux_Time1=Aux_Time1+1;
        end
        if(Aux_Time1>=1)
        begin
            Aux_Time1=0; Sound_EN=0;
        end
    
//------WIN------//
    if(score==20)
    begin
        score=0; l_x=400; l_y=485; level=level+1; color=color^color; PB_1y=150; PB_2y=150; PB_3y=150; PB_4y=150; PB_5y=150; Vel_BALL_X=Vel_BALL_X+1; Vel_BALL_Y=Vel_BALL_Y+1;
        l1_1=1;l2_1=1;l3_1=1;l4_1=1;l5_1=1; l1_2=1;l2_2=1;l3_2=1;l4_2=1;l5_2=1; l1_3=1;l2_3=1;l3_3=1;l4_3=1;l5_3=1; l1_4=1;l2_4=1;l3_4=1;l4_4=1;l5_4=1;
        Px_1=450; Py_1=170; Px_2=450; Py_2=170; Px_3=450; Py_3=170; Diry_1=0; Diry_2=0; Diry_3=0;
        if (life<3)
        begin
            life=life+1;
        end
    end

//------ALL BALL OUT------//
	if(BALL_1_ON==0 && BALL_2_ON==0 && BALL_3_ON==0)
	begin
        Px_1=450;Py_1=170;Dirx_1=0;Diry_1=0;life=life-1; color=1;l_x=400; BALL_1_ON=1;
	end

//------GAME OVER------//
    if(life==0)
    begin
        score=0; l_x=400; l_y=485; level=0; color=color^color; life=3; VEL_BAR=4; Vel_BALL_X=2; Vel_BALL_Y=4; BALL_1_ON=1; BALL_2_ON=0; BALL_3_ON=0;
        ln_barra=100; PB_1y=150; PB_2y=150; PB_3y=150; PB_4y=150; PB_5y=150; BAR_DW=0; BAR_OP=0;
        l1_1=1;l2_1=1;l3_1=1;l4_1=1;l5_1=1; l1_2=1;l2_2=1;l3_2=1;l4_2=1;l5_2=1; l1_3=1;l2_3=1;l3_3=1;l4_3=1;l5_3=1; l1_4=1;l2_4=1;l3_4=1;l4_4=1;l5_4=1;
        Px_1=450; Py_1=170; Px_2=450; Py_2=170; Px_3=450; Py_3=170; Diry_1=0; Diry_2=0; Diry_3=0;
    end
end
endmodule