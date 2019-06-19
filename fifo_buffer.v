/*Fifo_buffer has been used for storage purpose, the buffer takes write and
read pointers as a reference for performing insert and remove operation.
whenever we apply reset and flush, the buffer clears all the locations
by using for loop. */


module fifo_buffer #(parameter  WIDTH=32, DEPTH=7) (output reg [(WIDTH-1):0] data_out, input [(WIDTH-1):0] data_in,input [DEPTH:0]wr_ptr_wr,input [DEPTH:0]rd_ptr_rd,input clk_in,clk_out,insert,remove,flush,reset);

localparam pointer_limit =  1 << (DEPTH);

reg[(WIDTH-1):0] fifo[(pointer_limit-1):0];

integer i;

always@(posedge clk_in, negedge reset)
begin

if(!reset)
begin
for(i=0;i<pointer_limit;i=i+1)
fifo[i]<='b0;
end

else if(flush==1'b1)
begin
for(i=0;i<pointer_limit;i=i+1)
fifo[i]<='b0;
end

else if(insert)
fifo[wr_ptr_wr[(DEPTH-1):0]]<=data_in;

else
fifo[wr_ptr_wr[(DEPTH-1):0]]<=fifo[wr_ptr_wr[(DEPTH-1):0]];

end


always@(posedge clk_out,negedge reset)

begin

if(!reset)
data_out<='b0;


else if(flush==1'b1)
data_out<='b0;


else if(remove)
data_out<=fifo[rd_ptr_rd[(DEPTH-1):0]];

else
data_out<=data_out;

end

endmodule








