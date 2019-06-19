/*Flags module has been used for getting the value of full and empty flags
using synchronized write and read pointers.Extra MSB bit for read and write
pointers has been used to to compare them.*/

module flags#(parameter DEPTH=7)(output reg empty,full,empty_rd,full_wr,input[DEPTH:0] w2rsync2_ptr,r2wsync2_ptr);


//for full condition
always@(*)
begin
if((w2rsync2_ptr[(DEPTH-1):0]==r2wsync2_ptr[(DEPTH-1):0]) && (w2rsync2_ptr[DEPTH]!=r2wsync2_ptr[DEPTH]))
begin
full=1'b1;
full_wr =1'b1;
end
else
begin
full=1'b0;
full_wr =1'b0;
end


//for empty condition
if((w2rsync2_ptr[(DEPTH-1):0]==r2wsync2_ptr[(DEPTH-1):0]) && (w2rsync2_ptr[DEPTH]==r2wsync2_ptr[DEPTH]))
begin
empty=1'b1;
empty_rd=1'b1;
end
else
begin
empty=1'b0;
empty_rd=1'b0;
end
end

endmodule





