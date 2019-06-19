/*The readfsm module has been used for handling read pointer value, this module tells when to read from the fifo. The input flush is synchronized.
*/

module readfsm #(parameter WIDTH=32, DEPTH=7)(input empty,output reg[DEPTH:0]rd_ptr_rd, input clk_out,reset,remove,flush);


reg [1:0] presentstate, nextstate;
localparam IDLE=2'b00;
localparam RESET_ST=2'b01;
localparam READ=2'b10;
localparam pointer_limit= 1 << (DEPTH);

// The below sequential block is for state transition.

always@(posedge clk_out ,negedge reset)

  if(!reset)
      presentstate<=RESET_ST;  
  else if(flush)
      presentstate<=RESET_ST;
  else         
      presentstate<=nextstate;


//This always block for next state representation, that uses a finite state
//machine with three states IDLE, RESET_ST, READ.


always@(*)
  begin
    case(presentstate)

IDLE:

  if(remove)
     nextstate=READ;
  else
     nextstate=IDLE;

RESET_ST:
  begin
     nextstate=IDLE;
  end

READ:

  if(remove && !empty)

  begin
     nextstate=READ;
  end

  else
     nextstate=IDLE;

default: nextstate=IDLE;

endcase
end


//Below always block is for write pointer incrementation and reset

always@(posedge clk_out,negedge reset)
  if(!reset)
     rd_ptr_rd<='b0;
  else if(flush)
     rd_ptr_rd<='b0;
  else if(remove && !empty)
     begin
     if(rd_ptr_rd==pointer_limit)
         rd_ptr_rd<='b0;
     else
     rd_ptr_rd<=rd_ptr_rd+1;
     end
  else
     rd_ptr_rd<=rd_ptr_rd;

endmodule



