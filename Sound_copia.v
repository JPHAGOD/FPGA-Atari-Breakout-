module Sound_Bounce(clk10, Sound_EN1, Sound_OUT);
input clk10, Sound_EN1;
output reg Sound_OUT;

//------VARIABLES------//
    reg [23:0]aux=0;
    reg [15:0]cont=0, freq=0;
    wire [6:0]duty=0;
    reg [3:0]nota=0;
	 reg Sound_OUT1;
	 
	 //assign Sound_OUT=Sound_OUT1;

//------NOTAS------//
    parameter do2=17026;
    parameter s=0;

//------Volumen------//
    assign duty=freq>>1;

always@(posedge(clk10))
begin
//------AUDIO CONTROL------//
    aux=aux+1;
    cont=cont+1;
    if(cont>=freq)
    begin
        Sound_OUT=0; cont=0;
    end
    if(cont==(freq>>1)) Sound_OUT=1;

//------NOTAS TIMER------//
    if(aux>=1000000)
        begin
        nota=nota+1; aux=0;
        end
    if(nota>=2) nota=0;

//------NOTAS CASE------//
    if(Sound_EN1==1)
    begin
        case(nota)
            0:freq=do2;
            1:freq=do2;
            2:freq=s;
            default:freq=s;
        endcase
    end
    else freq=s;
end
endmodule
