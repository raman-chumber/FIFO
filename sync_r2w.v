/*sync_r2w module has been used for synchronizing the read pointer into the write clock domain.
*/

module sync_r2w #(parameter DEPTH=7) (output reg[DEPTH:0] r2wsync2_ptr,input [DEPTH:0] rd_ptr_rd,input reset,clk_in);


reg [DEPTH:0] r2wsync1_ptr;


always@(posedge clk_in,negedge reset)


if(!reset)
            {r2wsync2_ptr,r2wsync1_ptr} <=0;
   
      else
            {r2wsync2_ptr,r2wsync1_ptr} <= {r2wsync1_ptr,rd_ptr_rd};


endmodule

