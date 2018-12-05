module music_notes(clk, flip);

input clk;

reg [8:0] index;
reg [18:0] inverting_counter;
reg [25:0] note_length_timer;

output wave;

theme_song_notes notez(.address(index),
					   .clock(clk),
					   .q(note));

theme_song_count countz(.address(index), 
						.clock(clk), 
						.q(duration));
assign flip = wave;

initial
begin
	index <= 0;
end

always @ (negedge clk)
begin
	if(note_length_timer>=duration){
		index <= index + 1;
	}
end

always@(posedge clk)
	inverting_counter <= inverting_counter + 1;
	begin
		case (note)
			0: begin //Eb4
				if(inverting_counter >= 160705)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			1: begin //E4
				if(inverting_counter >= 151685)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			2: begin //F4
				if(inverting_counter >= 143172)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			3: begin //Gb4
				if(inverting_counter >= 135139)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			4: begin //G4
				if(inverting_counter >= 127551)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			5: begin //Ab4
				if(inverting_counter >= 120395)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			6: begin //A4
				if(inverting_counter >= 113636)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			7: begin //Bb4
				if(inverting_counter >= 107259)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			8: begin //B4
				if(inverting_counter >= 101239)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			9: begin //C5
				if(inverting_counter >= 95557)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			10: begin //Db5
				if(inverting_counter >= 90192)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			11: begin //D5
				if(inverting_counter >= 85131)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			12: begin //Eb5
				if(inverting_counter >= 80354)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			13: begin //E5
				if(inverting_counter >= 75844)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			14: begin //F5
				if(inverting_counter >= 71586)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			15: begin //Gb5
				if(inverting_counter >= 67568)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
			16: begin //G5
				if(inverting_counter >= 63776)
				begin
					inverting_counter <= 0;
					wave <= ~wave;
				end
				else
					inverting_counter <= inverting_counter + 1;
			   end
		endcase;
	end

endmodule