// Test bench for rgb2yuv 

module rgb2y_tb;

   //Define all inputs as registers
   reg rst_t;
   reg clk_t = 0;
   reg [7:0] R_t ;
   reg [7:0] G_t ;
   reg [7:0] B_t ;

   //Define all outputs as wires
   wire [7:0] Y_t;

   //Instantiate the rgb2y module
   rgb2y rgb2y_test( .R(R_t), .G(G_t), .B(B_t), .Y(Y_t), .clk(clk_t), .rst(rst_t) );
      
   initial begin
     
      $dumpfile("test.vcd");
      $dumpvars(0,rgb2y_tb);        // $dumpvars(?, module_name)

//      $monitor(rst_t, clk_t, R_t, G_t, B_t, Y_t);

      #10 rst_t = 0;
      R_t = 255;
      G_t = 123;
      B_t = 124;
      #20 rst_t = 1;
      #90 rst_t = 0;
      R_t = 55;
      G_t = 13;
      B_t = 24;
            
      #100 $stop;
   end // initial begin
   
   always #5 clk_t = !clk_t;
endmodule // rgb2y_tb

     
  