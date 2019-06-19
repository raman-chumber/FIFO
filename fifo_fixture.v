/*This test_fixture is for testing the fifo.v DUT, here we have instantiated
fifo module with Width=32 and depth=128, depth is given interms of power of 2.*/


`include "fifo.v"

module fifo_fixture;

parameter WIDTH=32;
parameter DEPTH=7;

reg insert,remove,flush;
reg [(WIDTH-1):0] data_in;
reg clk_in,clk_out,reset;
wire [(WIDTH-1):0] data_out;
wire full,empty;


//Instantiation of fifo.v DUT
fifo #( .DEPTH(DEPTH), .WIDTH(WIDTH)) fifo 
( .data_out(data_out), .full(full), .empty(empty), .data_in(data_in), .insert(insert), .remove(remove), .flush(flush), .reset(reset), .clk_in(clk_in), .clk_out(clk_out));

initial 
$vcdpluson;

//Clock generation for clk_in
initial
begin
clk_in=1'b0;
forever
#5 clk_in=~clk_in;
end


//Clock generation for clk_out
initial
begin
clk_out=1'b0;
forever
#10 clk_out=~clk_out;
end


//Task for initializing the input ports- flush,remove,insert,data_in

task INITIALIZER;
begin
insert=1'b0; remove=1'b0; flush=1'b0; data_in=32'h0;
end
endtask


//Task for reset
task RESET;
begin
reset=1'b0;
#10 reset=1'b1;
end
endtask


//Task for Flush operation
task FLUSH;
begin
flush=1'b1;
@(posedge clk_in) flush=1'b0;
end
endtask


//Task for remove opearation
task REMOVE;
begin
@(posedge clk_out) remove=1'b1;
#300 @(posedge clk_out) remove=1'b0;
end
endtask


//Task for insert opearation with random vector generation
task INSERT1;
begin
@(posedge clk_in) insert=1'b1; data_in=$random;
end
endtask


//Task for insert opearation without random
task INSERT2;
begin
@(posedge clk_in) insert=1'b1; data_in='hffffffff;
@(posedge clk_in) data_in='habcdefab;
@(posedge clk_in) data_in='haaaaaaaa;
@(posedge clk_in) data_in='hbabababa;
@(posedge clk_in) data_in='hcccccccc;
@(posedge clk_in) data_in='hacacacac;
@(posedge clk_in) data_in='habdcefac;
@(posedge clk_in) data_in='h6793abcd;
@(posedge clk_in) data_in='h12345678;
@(posedge clk_in) data_in='h87654321;
insert=1'b0;
end
endtask


initial 
begin

//Calling tasks


INITIALIZER;
RESET;
INSERT1;
FLUSH;
RESET;
INSERT2;
REMOVE;
INSERT2;
REMOVE;
INSERT2;
RESET;
INSERT2;
REMOVE;
FLUSH;
INSERT2;
REMOVE;
RESET;
INSERT1;
FLUSH;
INSERT1;


end


initial
begin
$monitor($time, " reset=%b, insert=%b, remove=%b, flush=%b, data_in=%h, data_out=%h, full=%b, empty=%b",reset,insert,remove,flush,data_in,data_out,full,empty);
end


initial
begin
#3080 $finish;
end

endmodule







