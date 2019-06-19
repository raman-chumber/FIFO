/*The writefsm module has been used for handling  write pointers. This module has a finite state machine, that tells us when to write into the fifo. 
*/

module writefsm #(parameter WIDTH=32, DEPTH=7)(input full, output reg [DEPTH:0]wr_ptr_wr,input clk_in,reset,insert,flush);


reg [1:0] presentstate, nextstate;
localparam IDLE=2'b00;
localparam RESET_ST=2'b01;
localparam WRITE=2'b10;
localparam pointer_limit= 1<< (DEPTH);



//This sequential block is for state transition.

always@(posedge clk_in ,negedge reset)

   if(!reset)
       presentstate<=RESET_ST;  
   else if(flush)
      presentstate<=RESET_ST;
   else         
       presentstate<=nextstate;

//The below combinational block is for the next state representation, It has
//three states IDLE,RESET_ST and WRITE   


always@(*)
begin
case(presentstate)

IDLE:

   if(insert)
       nextstate=WRITE;
   else
       nextstate=IDLE;


RESET_ST:
   begin
    nextstate=IDLE;
   end

WRITE:
  if(insert && !full)
  begin
      nextstate=WRITE;
  end
  else
      nextstate=IDLE;

default: nextstate=IDLE;

endcase
end

//This always block has been used for handling the write pointer value like
//incrementing,reseting.

always@(posedge clk_in,negedge reset)
    if(!reset)
       wr_ptr_wr<='b0;
    else if(flush)
       wr_ptr_wr<='b0;
    else if(insert && !full)
        begin
       if(wr_ptr_wr==(pointer_limit))
          wr_ptr_wr<='b0;
       else
           wr_ptr_wr<=wr_ptr_wr+1;
           end
    else
       wr_ptr_wr<=wr_ptr_wr;

endmodule



