// counter.v
// author:manaka
// date:20/07/19
// Description:First

// History
// v0.1 create new
//

module COUNTER #(
   parameter COUNT_WIDTH = 5
  )
  (
   input                   rst             // reset
  ,input                   clk             // clock
  ,input                   clr             // clear(sync)
  ,input                   en              // enable
  ,output[COUNT_WIDTH-1:0] cnt_out         // count_output
  );

reg  [COUNT_WIDTH-1:0] cnt_r ; // count_reg
wire [COUNT_WIDTH-1:0] cnt   ; // count_wire

/* Counter */
always @(posedge clk or posedge rst)
  begin
  if(rst)begin      // async reset
    cnt_r <= {COUNT_WIDTH{1'b0}};
  end
  else if(clr)begin // sync clear
    cnt_r <= {COUNT_WIDTH{1'b0}};
  end
  else if(en)begin  // count up
    cnt_r <= cnt + 1 ;
  end  
  else begin        // do nothing
    cnt_r <= cnt;
  end
end

assign cnt = cnt_r ;

/* external port */
assign cnt_out = cnt ;

endmodule