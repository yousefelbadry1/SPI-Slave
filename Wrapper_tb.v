module Wrapper_tb();

    reg MOSI, SS_n, clk, rst_n;
    wire MISO;

    Wrapper Dut (
        .MOSI(MOSI),
        .MISO(MISO),
        .SS_n(SS_n),
        .clk(clk),
        .rst_n(rst_n)
    );

    always 
    begin
        clk= 1;
        forever 
            #5 clk = ~clk;
    end 



    initial begin
        rst_n = 0;
        MOSI = 0;
        SS_n = 1;
        @(negedge clk)
        rst_n = 1;
        MOSI = 0;
        SS_n = 0;
        @(negedge clk);
        @(negedge clk);
        //**************************************************************************
        // Write Address to RAM 
        MOSI = 0;
        @(negedge clk)
        MOSI = 0;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        repeat(2) @(negedge clk);

        MOSI = 0;
        SS_n = 1;
        @(negedge clk);
        @(negedge clk);
        
        
        SS_n = 0;
        @(negedge clk);
        @(negedge clk);
        // Write Data to RAM
        MOSI = 0;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1; 
        repeat(2) @(negedge clk);

        SS_n = 1; 
        @(negedge clk)
        @(negedge clk);
        
        SS_n = 0; 
        @(negedge clk)
        @(negedge clk);
        // Read Address to RAM
        MOSI = 1;
        @(negedge clk)
        MOSI = 0;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1; 
        repeat(2) @(negedge clk);


        SS_n = 1; 
        MOSI = 1;
        @(negedge clk)

        SS_n = 0; 
        @(negedge clk)
        @(negedge clk)

        // Read Data to RAM
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        MOSI = 1;
        @(negedge clk)
        repeat(10) @(negedge clk);
        
        SS_n = 1; 
        @(negedge clk)
        
        $display("MISO = %b", MISO);
        //**************************************************************************
        $stop;
    end

endmodule
