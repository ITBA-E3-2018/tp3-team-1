`timescale 100us / 100us
module Ej1Moore_TB();

output reg R,S,I;
input wire B1,B2;
output wire Clock;

clock_gen Clk(Clock);
Ej1Moore Ej(Clock,R,S,I,B1,B2);
integer i;

initial begin
  $display("Clock R S I B1 B2");
  $monitor("%b %b %b %b %b %b", Clock,R,S,I,B1,B2);

  #0  
  #15
  R=0;
  S=1; 
  I=1;
  #20
   
  S=0;
  I=0;
  #25
   
  S=0;
  I=1;
  #30
   
  S=1;
  I=1;
  #35
 
  S=1;
  I=1;
  #40
 
  S=0;
  I=1;
  #50  
  R=1;
  #60
  R=0;
  #70
  S=0;
  I=0;
  
  #100 $finish;   

  
    end

endmodule


module clock_gen(clk);

parameter PERIOD = 10;

output reg clk;
	 
always
	begin: CLOCK_DRIVER
		clk <= 1'b0;
		#(PERIOD/2);
		clk <= 1'b1;
		#(PERIOD/2);
	end
endmodule




module Ej1Moore(Clock,R,S,I,B1,B2);
    input   Clock,R,I,S;
    output reg B1,B2;
    reg y1,y2,Aux;
    wire Y2,Y1;
    initial Aux=0;
    assign Y2=(~S)&I;
    assign Y1=(~I)|((~S)&y2&y1)|((~Aux)&(~S)&(~y2)&I);
   

    always @(posedge Clock,posedge R)
        if(R==1) begin
          y1<=1'b0;
          y2<=1'b0;
          B2=y1;
          B1=y1^y2;
        end
        else begin
          y1<=Y1;
          y2<=Y2;
          B2=y1;
          B1=y1^y2;
          if(y2==1) begin
          Aux<=y1;
        end
        end

endmodule
        