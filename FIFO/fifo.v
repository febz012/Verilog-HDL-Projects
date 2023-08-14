module fifo(
  
  input clk,rd,wr,rst
  input [7:0] data_in,
  output full,empty,
  output [7:0] data_out
);
  
  
  reg [7:0] mem [31:0];
  reg [4:0] rd_ptr;
  reg [4:0] wr_ptr;
  
  always @(posedge clk) begin
    if(rst == 1'b0) begin
      data_out <= 0;
      rd_ptr <= 0;
      wr_ptr <= 0;
      foreach(mem[i]) mem[i] <= 0;
    end
    
    else begin
      if ((wr == 1'b1) && (full == 1'b0)) begin
        mem[wr_ptr] = data_in;
        wr_ptr = wr_ptr + 1;
      end
      
      if ((rd == 1'b1) && (empty == 1'b0)) begin
        data_out = mem[rd_ptr];
        rd_ptr = rd_ptr + 1;
      end
    end
  end
  
  assign empty = (rd_ptr == wr_ptr) ? 1'b1 : 1'b0;
  assign full = (wr_ptr - rd_ptr == 31) ? 1'b1 : 1'b0;
endmodule
  
interface fifo_if;
  
  logic clk,rd,wr,rst;
  logic [7:0] data_in;
  logic [7:0] data_out'
  logic full,empty;
  
  endinterface
