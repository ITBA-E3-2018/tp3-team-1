`timescale 100us / 100us
module Ej1Mealy_TB();
output reg R,S,I;
input wire B1,B2;
output wire Clock;

clock_gen Clk(Clock);
Ej1Mealy Ej(Clock,R,S,I,B1,B2);
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




module Ej1Mealy(Clock,R,S,I,B1,B2);
    input   Clock,R,I,S;
    output reg B1,B2;
    reg y,Aux;
    wire Y,T;
    initial Aux=0;
    initial y=0;
    assign Y=(~S)&&(I);
    assign T=(y&&S&&I)|(y&&(~S)&&(~I));
   
    always @(posedge Clock,posedge R)
        if(R==1) begin
          y<=1'b0;
          B2=(~I)|(y&&(~Aux)&&(~S));
          B1=(~I)|(y&&Aux&&(~S));
        end
        else begin
          y<=Y;
          B2=(~I)|(y&&(~Aux)&&(~S));
          B1=(~I)|(y&&Aux&&(~S));
          if(T) begin
          Aux<=~Aux;
        end
        end
    always @(S,I,Aux) begin
        B2=(~I)|(y&&(~Aux)&&(~S));
        B1=(~I)|(y&&Aux&&(~S));
        end

endmodule
        