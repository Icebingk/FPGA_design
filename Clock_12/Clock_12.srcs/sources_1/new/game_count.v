module game_count(
input rst_n, 
input clk, 
input [9:0]money,
input set,
input [1:0]boost,//模式选择
output [9:0]remain,
output yellow,
output red
);

reg [1:0] game_state;
reg [9:0] money_r = 10'd0;
reg [1:0] money_reduce;
// reg       try_model_times;
reg [2:0] try_model_cnt;
reg       yellow_r;
reg       red_r;
reg       set_onces = 1'b0;
parameter shut_down         = 0;
parameter simple_model      = 1;
parameter free_model        = 2;
parameter try_model         = 3;

assign remain = money_r;
assign yellow = yellow_r;
assign red = red_r;

//状态机,模式的选择
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)begin
        game_state <= simple_model;
        try_model_cnt <= 3'd5;
    end else begin
        case (boost)
            2'b00: game_state <= shut_down; 
            2'b01: game_state <= simple_model;
            2'b11: begin 
                    if (try_model_cnt) begin 
                        game_state <= try_model;
                        try_model_cnt <= try_model_cnt - 3'd1;
                    end else game_state <= simple_model;
            end
            2'b10: game_state <= free_model;
            default: game_state <= simple_model;
        endcase
    end
end

// 记录剩余的钱，如果是复位，金钱价格重置，如果是set信号有效，则增加剩余的金额并且减1分钟，如果正常，则按时间减钱
always @(posedge clk or negedge rst_n) begin
    if (set == 1'b1 && !set_onces) begin
        money_r <= money_r + money;
    end else if (~rst_n) begin
        money_r <= money_r;
    end else if (money_r == 10'd0) begin
        money_r <= money_r;
    end else begin
        if (money >= money_reduce) begin
            money_r <= money_r - money_reduce; 
        end else begin
            money_r <= money_r;
        end
    end
end

//控制只能充值一次
always @(posedge clk) begin
    set_onces <= set;
end

//控制不同游戏模式下，每分钟消耗的金额
always @(*) begin
    if (!rst_n) begin
        money_reduce <= 2'd1;
    end else begin
        case (game_state)
            shut_down: money_reduce = 2'd0;
            simple_model: money_reduce = 2'd1; 
            free_model: money_reduce = 2'd2;
            try_model: money_reduce = 2'd0;
            default: money_reduce = 2'd0;
        endcase
    end
end

//控制信号灯
always @(*) begin
    if (!rst_n) begin
        yellow_r <= 1'd0;
    end else begin
        case (game_state)
            shut_down: yellow_r <= 1'd0;
            try_model: yellow_r = 2'd0;
            default: begin
                if (money_r < 10'd10) begin
                    yellow_r <= 1'd1;
                end else begin
                    yellow_r <= 1'd0;
                end
            end
        endcase
    end
end

always @(*) begin
    if (!rst_n) begin
        red_r <= 1'd0;
    end else begin
        case (game_state)
            shut_down: red_r <= 1'd0;
            try_model: red_r = 2'd0;
            default: begin
                if (money_r < money_reduce) begin
                    red_r <= 1'd1;
                end else begin
                    red_r <= 1'd0;
                end
            end
        endcase
    end
end

endmodule