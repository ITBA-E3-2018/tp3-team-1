`timescale 100us / 100us
module Ej2Mealy_TB();

output reg R,w;
input wire Z;
output wire Clock;

clock_gen Clk(Clock);
Ej2Mealy Ej(Clock,R,w,Z);

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




module Ej2Mealy(Clock,R,w,Z);
    input Clock,R,w;
    output reg Z;
    reg y1,y2;
    wire Y2,Y1;
    initial y2=0;
    initial y1=0;
    initial Z=0;
    assign Y2=(w&&y1&(~y2))|(y2&&(~y1));
    assign Y1=(~y1)&&(y2^w);
    assign S = y2&&y1&&w;
   

    always @(posedge Clock,posedge R)
        if(R==1) begin
          y1<=1'b0;
          y2<=1'b0;
          Z<=1'b0;
        end
        else begin
          y1<=Y1;
          y2<=Y2;
          Z<=Z;
        end
    always @(y2,y1,w,R)   
        if(S==1)begin
          Z<=1'b1;
          end
        else if(R==1)begin
          Z<=1'b0;
          end  
          else begin
          Z<=Z;
        end
     
endmodule
        