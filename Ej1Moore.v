module Ej1Moore(Clock,R,S,I,B1,B2);
    input   Clock,R,I,S;
    output reg B1,B2;
    reg y1,y2,Aux;
    wire Y2,Y1;
    
    assign Y2=(~S)&I;
    assign Y1=(~I)|((~S)&y2&y1)|((~Aux)&(~S)&(~y2)&I);
   

    always @(posedge Clock,posedge R)
        if(R==0) begin
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
        end

    always @(y1,y2)
        if(y2==1) begin
        Aux<=y1;
        end  
endmodule
        
