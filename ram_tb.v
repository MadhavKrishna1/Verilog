//`include "dual_address_ram.v"
//module dual_port_ram_tb;
module hello_tb;

    // Input signals
    reg clock;
    reg write_enable;
    reg [7:0] input_data;
    reg [3:0] address_0;
    reg [3:0] address_1;
    reg enable_port_0;
    reg enable_port_1;

    // Output signals
    wire [7:0] output_data_0;
    wire [7:0] output_data_1;
    
    integer index;

    // Instantiate the Unit Under Test (UUT)
    dual_port_ram uut (
        .clk(clock), 
        .wr_en(write_enable), 
        .data_in(input_data), 
        .addr_in_0(address_0), 
        .addr_in_1(address_1), 
        .port_en_0(enable_port_0), 
        .port_en_1(enable_port_1), 
        .data_out_0(output_data_0), 
        .data_out_1(output_data_1)
    );
    
    // Clock signal generation
    always #5 clock = ~clock;

    initial begin
        $dumpfile("hello_tb.vcd");
        $dumpvars(0, hello_tb);

        // Initialize input signals
        clock = 1;
        address_1 = 0;
        enable_port_0 = 0;
        enable_port_1 = 0;
        write_enable = 0;
        input_data = 0;
        address_0 = 0;  
        #20;

        // Write data to all RAM locations
        enable_port_0 = 1;  
        write_enable = 1;
        for (index = 1; index <= 16; index = index + 1) begin
            input_data = index;
            address_0 = index - 1;
            #10;
        end
        write_enable = 0;
        enable_port_0 = 0;  

        // Read data from all RAM locations using port 1
        enable_port_1 = 1;  
        for (index = 1; index <= 16; index = index + 1) begin
            address_1 = index - 1;
            #10;
        end
        enable_port_1 = 0;
    end
      
endmodule
