module ex4 
 ( input logic [7:0]a,b,
	input logic clk,rst,
				input logic [2:0] sw,
				output logic [15:0] y);
	logic [15:0] p1,p2,p3;			
always @*begin 
case  (sw) 
		3'b000: 
					y = p1;
		3'b001: 	
					y = p2;
						
		3'b010: 	
					y = p3;
				
	default: 
				y = '0;
endcase 
end 
ex3 nhan (.a(a),.b(b),.clk(clk),.p(p3));						
ex2 tru (.a(a),.b(b),.clk(clk),.out(p2),.c_in(1'b1),.rst(rst));
ex2 cong (.a(a),.b(b),.clk(clk),.out(p1),.c_in(1'b0),.rst(rst));	
endmodule 
module ex2 ( input logic clk,rst,c_in,
				input logic [7:0] a,b,
		
				output logic [7:0] out);
				
 logic [7:0] a_ff,b_ff;
 logic [7:0] f_ff;
 logic c_out,overflow;
 always_ff @(posedge clk) begin
 if (rst)
	out <= 8'b00000000;
else 
	out <= f_ff;
	end 
 always_ff @(posedge clk) begin 
 b_ff <= b;
  a_ff <= a;

  end
overflow2 ovrfl (.a(a_ff),.b(b_ff),.c_in(c_in),.sum(f_ff));
endmodule



module overflow2 (
		input logic [7:0] a,b,c_in,
		output logic [7:0] c_out, sum);
adder1 add0 (.a(a[0]),.b(b[0]^ c_in),.c_in(c_in),.c_out(c_out[0]),.sum(sum[0]));
adder1 add1 (.a(a[1]),.b(b[1]^ c_in),.c_in(c_out[0]),.c_out(c_out[1]),.sum(sum[1]));
adder1 add2 (.a(a[2]),.b(b[2]^ c_in),.c_in(c_out[1]),.c_out(c_out[2]),.sum(sum[2]));
adder1 add3 (.a(a[3]),.b(b[3]^ c_in),.c_in(c_out[2]),.c_out(c_out[3]),.sum(sum[3]));
adder1 add4 (.a(a[4]),.b(b[4]^ c_in),.c_in(c_out[3]),.c_out(c_out[4]),.sum(sum[4]));
adder1 add5 (.a(a[5]),.b(b[5]^ c_in),.c_in(c_out[4]),.c_out(c_out[5]),.sum(sum[5]));
adder1 add6 (.a(a[6]),.b(b[6]^ c_in),.c_in(c_out[5]),.c_out(c_out[6]),.sum(sum[6]));
adder1 add7 (.a(a[7]),.b(b[7]^ c_in),.c_in(c_out[6]),.c_out(c_out[7]),.sum(sum[7]));
		endmodule
		
module adder1 (	
	input logic a,b,c_in,
	output logic c_out, sum);
		assign c_out = (a & b)  | (a ^ b ) & c_in;
		assign sum = a ^ b ^ c_in;
			
	endmodule 
	
module ex3 (
			input logic [7:0] a,b,
			input logic clk,
			output logic [15:0] p);
	logic [7:0] a_ff,b_ff;
	logic [15:0] p_ff;		
always_ff @(posedge clk) begin
a_ff <= a;
b_ff <= b;
p <= p_ff;
end

multi mulitplier (.a(a_ff),.b(b_ff),.p(p_ff));
		
endmodule 

module multi (
	input logic [7:0] a, b,
	input logic cin,
	output logic [15:0] p
);
wire [7:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7;
wire [0:0] carry1, carry2, carry3, carry4, carry5, carry6, carry7;

//layer0
and (p[0], a[0], b[0]);

//layer1
adder fa1 (
	.sum(sum1),
	.a0(a[1] & b[0]),
	.a1(a[2] & b[0]),
	.a2(a[3] & b[0]),
	.a3(a[4] & b[0]),
	.a4(a[5] & b[0]),
	.a5(a[6] & b[0]),
	.a6(a[7] & b[0]),
	.a7(1'b0),
	.b0(a[0] & b[1]),
	.b1(a[1] & b[1]),
	.b2(a[2] & b[1]),
	.b3(a[3] & b[1]),
	.b4(a[4] & b[1]),
	.b5(a[5] & b[1]),
	.b6(a[6] & b[1]),
	.b7(a[7] & b[1]),
	.cin(cin),
	.cout(carry1)
);
	
//layer2
adder fa2 (
	.sum(sum2),
	.a0(sum1[1]),
	.a1(sum1[2]),
	.a2(sum1[3]),
	.a3(sum1[4]),
	.a4(sum1[5]),
	.a5(sum1[6]),
	.a6(sum1[7]),
	.a7(carry1),
	.b0(a[0] & b[2]),
	.b1(a[1] & b[2]),
	.b2(a[2] & b[2]),
	.b3(a[3] & b[2]),
	.b4(a[4] & b[2]),
	.b5(a[5] & b[2]),
	.b6(a[6] & b[2]),
	.b7(a[7] & b[2]),
	.cin(cin),
	.cout(carry2)
);

//layer3
adder fa3 (
	.sum(sum3),
	.a0(sum2[1]),
	.a1(sum2[2]),
	.a2(sum2[3]),
	.a3(sum2[4]),
	.a4(sum2[5]),
	.a5(sum2[6]),
	.a6(sum2[7]),
	.a7(carry2),
	.b0(a[0] & b[3]),
	.b1(a[1] & b[3]),
	.b2(a[2] & b[3]),
	.b3(a[3] & b[3]),
	.b4(a[4] & b[3]),
	.b5(a[5] & b[3]),
	.b6(a[6] & b[3]),
	.b7(a[7] & b[3]),
	.cin(cin),
	.cout(carry3)
);

//layer4
adder fa4 (
	.sum(sum4),
	.a0(sum3[1]),
	.a1(sum3[2]),
	.a2(sum3[3]),
	.a3(sum3[4]),
	.a4(sum3[5]),
	.a5(sum3[6]),
	.a6(sum3[7]),
	.a7(carry3),
	.b0(a[0] & b[4]),
	.b1(a[1] & b[4]),
	.b2(a[2] & b[4]),
	.b3(a[3] & b[4]),
	.b4(a[4] & b[4]),
	.b5(a[5] & b[4]),
	.b6(a[6] & b[4]),
	.b7(a[7] & b[4]),
	.cin(cin),
	.cout(carry4)
);

//layer5
adder fa5 (
	.sum(sum5),
	.a0(sum4[1]),
	.a1(sum4[2]),
	.a2(sum4[3]),
	.a3(sum4[4]),
	.a4(sum4[5]),
	.a5(sum4[6]),
	.a6(sum4[7]),
	.a7(carry4),
	.b0(a[0] & b[5]),
	.b1(a[1] & b[5]),
	.b2(a[2] & b[5]),
	.b3(a[3] & b[5]),
	.b4(a[4] & b[5]),
	.b5(a[5] & b[5]),
	.b6(a[6] & b[5]),
	.b7(a[7] & b[5]),
	.cin(cin),
	.cout(carry5)
);

//layer6
adder fa6 (
	.sum(sum6),
	.a0(sum5[1]),
	.a1(sum5[2]),
	.a2(sum5[3]),
	.a3(sum5[4]),
	.a4(sum5[5]),
	.a5(sum5[6]),
	.a6(sum5[7]),
	.a7(carry5),
	.b0(a[0] & b[6]),
	.b1(a[1] & b[6]),
	.b2(a[2] & b[6]),
	.b3(a[3] & b[6]),
	.b4(a[4] & b[6]),
	.b5(a[5] & b[6]),
	.b6(a[6] & b[6]),
	.b7(a[7] & b[6]),
	.cin(cin),
	.cout(carry6)
);

//layer7
adder fa7 (
	.sum(sum7),
	.a0(sum6[1]),
	.a1(sum6[2]),
	.a2(sum6[3]),
	.a3(sum6[4]),
	.a4(sum6[5]),
	.a5(sum6[6]),
	.a6(sum6[7]),
	.a7(carry6),
	.b0(a[0] & b[7]),
	.b1(a[1] & b[7]),
	.b2(a[2] & b[7]),
	.b3(a[3] & b[7]),
	.b4(a[4] & b[7]),
	.b5(a[5] & b[7]),
	.b6(a[6] & b[7]),
	.b7(a[7] & b[7]),
	.cin(cin),
	.cout(carry7)
);

assign p[15:1] = {carry7, sum7[7:0], sum6[0], sum5[0], sum4[0], sum3[0], sum2[0], sum1[0]};

endmodule
module adder (
	input logic [0:0] a0, a1, a2, a3, a4, a5, a6, a7,
	input logic [0:0] b0, b1, b2, b3, b4, b5, b6, b7,
	input logic cin,
	output logic [7:0] sum, cout,
	output logic [8:0] total
);

logic [7:0] carry;

FA FA0 (.sum(sum[0]), .a(a0), .b(b0^cin), .cin(cin), .cout(carry[0]));
FA FA1 (.sum(sum[1]), .a(a1), .b(b1^cin), .cin(carry[0]), .cout(carry[1]));
FA FA2 (.sum(sum[2]), .a(a2), .b(b2^cin), .cin(carry[1]), .cout(carry[2]));
FA FA3 (.sum(sum[3]), .a(a3), .b(b3^cin), .cin(carry[2]), .cout(carry[3]));
FA FA4 (.sum(sum[4]), .a(a4), .b(b4^cin), .cin(carry[3]), .cout(carry[4]));
FA FA5 (.sum(sum[5]), .a(a5), .b(b5^cin), .cin(carry[4]), .cout(carry[5]));
FA FA6 (.sum(sum[6]), .a(a6), .b(b6^cin), .cin(carry[5]), .cout(carry[6]));
FA FA7 (.sum(sum[7]), .a(a7), .b(b7^cin), .cin(carry[6]), .cout(cout));

assign total = {cout, sum[7:0]};

endmodule


module FA (
	input logic a, b, cin,
	output logic sum, cout
);

assign sum = a^b^cin;
assign cout = a&b | b&cin | cin&a;

endmodule 