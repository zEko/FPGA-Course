/* Author : Kai
   Software : iverilog
   License : LGPL
*/
// R,G,B are 8 bit values with 0~255 range
// Y is a 8 bit number, range 0~255
// 
// Conversion Equation
// Y = 0.299*R + 0.587*G + 0.114*B
//
// Normalization equations
// Y = (1/256) * [256*0.299*R + 256*0.587*G + 256*0.114*B]
// Y = (1/256) * [76.544*R + 150.272*G + 29.184*B]
// Y = (1/256) * [77*R + 150*G + 29*B]
//
   
 
module rgb2y(R, G, B, Y, clk, rst);
   parameter WIDTH=8;

   output [WIDTH-1:0] Y;
   input              rst;
   input              clk;
   
   input [WIDTH-1:0]  R;
   input [WIDTH-1:0]  G;
   input [WIDTH-1:0]  B;
   reg [WIDTH-1:0]    Y;
   
   // Normalization coeffecients
   parameter NC_red = 77;
   parameter NC_blue = 29;
   parameter NC_green = 150;
   
   always @(posedge clk)
   begin: RGB_to_Y
     if (rst)
      Y_orig <= 0;     // set all registers to 0 during reset
     else 
      Y = NC_red * R + NC_green * G + NC_blue * B;
   end
endmodule // rgb2y

            
   
