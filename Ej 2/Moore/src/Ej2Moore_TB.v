`timescale 100us / 100us
module Ej1Moore_TB();

output reg R,w;
input wire Z;
output wire Clock;

clock_gen Clk(Clock);
Ej2Moore Ej(Clock,R,w,Z);

initial begin
  $display("Clock R w Z");
  $monitor("%b %b %b %b",Clock,R,w,Z);

  #0  
  R=0;
  w=0;
  #2
  w=1;
  #2
  w=1;
  #2
  w=0;
  #2
  w=1;
  #12
  w=1;
  #13
  w=0;
  #13
  R=1;
  #16
  R=0;
  #2
  w=1;
  #2
  w=0;
  #2
  w=1;
  #2
  w=1;
  #2
  w=1;
  #4
  w=0;
  #2
  w=1;
  #40
  w=0;
  #60 $finish;   
    end

endmodule


module clock_gen(clk);

parameter PERIOD = 2;

output reg clk;
	 
always
	begin: CLOCK_DRIVER
		clk <= 1'b0;
		#(PERIOD/2);
		clk <= 1'b1;
		#(PERIOD/2);
	end
endmodule




module Ej2Moore(Clock,R,w,Z);
    input   Clock,R,w;
    output reg Z;
    reg y1,y2,y3;
    wire Y3,Y2,Y1;
    initial y2=0;
    initial y1=0;
    initial y3=0;
    assign Y3=y3|(y2&&y1&&w);
    assign Y2=(w&&(~y2)&&y1)|(&y2&&(~y1));
    assign Y1=(~y1)&&(((~w)&&y2)|(w&&(~y2)&&(~y3)));
   

    always @(posedge Clock,posedge R)
        if(R==1) begin
          y1<=1'b0;
          y2<=1'b0;
          y3<=1'b0;
          Z=y3;
        end
        else begin
          y1<=Y1;
          y2<=Y2;
          y3<=Y3;
          Z=y3;
        end

endmodule
        