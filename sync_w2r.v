/*sync_w2r module has been used for synchronizing the write pointer and flush  into the read clock domain.
*/

module sync_w2r #(parameter DEPTH=7) (output reg[DEPTH:0] w2rsync2_ptr, output reg flush_out, input flush, input [DEPTH:0] wr_ptr_wr,input reset,clk_out);


reg [DEPTH:0] w2rsync1_ptr;
reg temp;

always@(posedge clk_out,negedge reset)


if(!reset)
begin
      {w2rsync2_ptr,w2rsync1_ptr} <= 'b0;
      {temp,flush_out}<=2'b0;
 end
else
begin
      {w2rsync2_ptr,w2rsync1_ptr} <= {w2rsync1_ptr,wr_ptr_wr};
      {temp,flush_out}<={flush,temp};
end  

endmodule


