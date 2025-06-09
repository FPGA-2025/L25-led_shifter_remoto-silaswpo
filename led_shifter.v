module LedShifter #(
    parameter CLK_FREQ = 8
) (
    input  wire clk,
    input  wire rst_n,
    output reg [7:0] leds
);

    reg [$clog2(CLK_FREQ)-1:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            leds <= 8'b00011111; // Valor inicial
            counter <= 0;
        end else begin
            if (counter == (CLK_FREQ / 4) - 1) begin
                // Deslocamento circular para a esquerda
                leds <= {leds[6:0], leds[7]};
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
