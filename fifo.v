/*Fifo top module has been used for instantiating all the child modules. Fifo
supports insert,remove and flush operations.Fifo has default width=32bit word and depth=128.
The data will be inserted on clk_in and removed on clk_out clock. Whenever
we assert flush and deassert reset, all the data will be erased from the fifo.
Depth value has been given interms of 2 power i.e 2^7 =128.
*/

`include "writefsm.v"
`include "readfsm.v"
`include "fifo_buffer.v"
`include "sync_w2r.v"
`include "sync_r2w.v"
`include "flags.v"

module fifo #(parameter WIDTH=32,DEPTH=7)(output [(WIDTH-1):0] data_out,output full,empty,input [(WIDTH-1):0] data_in,input insert,remove,flush,reset,clk_in,clk_out);


wire [DEPTH:0] w2rsync2_ptr,r2wsync2_ptr,wr_ptr_wr,rd_ptr_rd;
wire flush_out;
wire full_wr,empty_rd;

//Instantiation of write fsm module,read,fifo_buffer,synchronizer for the read
//and write pointers and flags-full and empty.

writefsm  #(.WIDTH(WIDTH), .DEPTH(DEPTH)) writefsm( .full(full_wr), .clk_in(clk_in), .reset(reset), .insert(insert), .flush(flush), .wr_ptr_wr(wr_ptr_wr));
                                                   
readfsm #(.WIDTH(WIDTH), .DEPTH(DEPTH)) readfsm( .empty(empty_rd), .clk_out(clk_out), .reset(reset), .remove(remove), .flush(flush_out), .rd_ptr_rd(rd_ptr_rd));

fifo_buffer #(.WIDTH(WIDTH), .DEPTH(DEPTH)) buffer(.data_in(data_in), .data_out(data_out), .clk_in(clk_in), .clk_out(clk_out), .reset(reset), .flush(flush), .insert(insert), .remove(remove), .wr_ptr_wr(wr_ptr_wr), .rd_ptr_rd(rd_ptr_rd));

sync_w2r #(.DEPTH(DEPTH)) wrtord( .w2rsync2_ptr(w2rsync2_ptr), .wr_ptr_wr(wr_ptr_wr), .reset(reset), .clk_out(clk_out), .flush_out(flush_out), .flush(flush));

sync_r2w #(.DEPTH(DEPTH))rdtowr( .r2wsync2_ptr(r2wsync2_ptr), .rd_ptr_rd(rd_ptr_rd), .reset(reset), .clk_in(clk_in));

flags #(.DEPTH(DEPTH))flag( .r2wsync2_ptr(r2wsync2_ptr), .w2rsync2_ptr(w2rsync2_ptr), .full(full), .empty(empty), .full_wr(full_wr), .empty_rd(empty_rd));



endmodule
