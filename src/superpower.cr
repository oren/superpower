require "colorize"

module Screen
	def self.clear
		print "\e[2J\e[1;1H"
	end

	def self.readkeypress
		STDIN.raw do |io|
			buffer = Bytes.new(3)
			bytes_read = io.read(buffer)
			input = String.new(buffer[0, bytes_read])

			case input
			when "\n"
				:enter
			when "\e[A", "w"
				:up
			when "\e[B", "s"
				:down
			when "\e"
				:escape
				return false
			when "\u{3}"
				:ctrl_c
				return false
			when "q", "Q"
				:q
				return false
			else
				:unknown
			end
		end
	end
end

class Superpower
  VERSION = "0.1.0"
	@current_line = 3
	@say = ""

	@lines = [
		"Superpower Bot",
		"==============",
    "Introduction          [COMPLETED]",
	  "Find your superpowers            ",
		"==============",
		"HELP",
		"EXIT"
	]

	def draw
		Screen.clear

		blue_background = Colorize::ColorRGB.new(0, 0, 139)
		gray_background = Colorize::ColorRGB.new(160, 160,160)

		@lines.each_with_index do |line, index|
			line = " " + line
			if @current_line == index
				puts line.ljust(35).colorize.back(gray_background).fore(:light_gray)
			else
				puts line.ljust(35).colorize.back(blue_background).fore(:light_gray)
			end
		end
	end

  def execute_action(action)
    case action
    when :enter
			@current_line += 1
			true
    when :up
			if @current_line > 2
				@current_line -= 1
			end
			true
    when :down
			if @current_line < 6
				@current_line += 1
			end
			true
    when :ctrl_c, :escape, :q
			@say = "bye!"
      false
    when :unknown
      true
    else
      #raise ArgumentError.new "Unknown action: #{action}"
    end
  end

	def run
		draw

		until false
			if execute_action Screen.readkeypress
				draw
			else
				puts "test"
				puts @say
				exit
			end
		end
	end

	# Hi, I am a bot that helps you find your superpowers. It will take you 30 mintues of playing.
  # I'll present you 30 stories and you'll pick the two that you think represent you. Let's get started!

	# TODO: read from db and highlight the completed task
end

Superpower.new.run
