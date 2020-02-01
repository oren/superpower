require "colorize"

module Superpower
  VERSION = "0.1.0"

	background = Colorize::ColorRGB.new(0, 0, 255)

	text = "                         \n "
	text += "Superpower Bot          \n "
	text += "==============          "
	text = text.colorize.back(background).fore(:light_gray)
	puts text

	text = " Find your superpowers   "
	text = text.colorize.back(Colorize::ColorRGB.new(160, 160,160)).fore(background)
	puts text

	text = " "
	text += "Your superpowers        \n "
	text += "List of superpowers     \n "
	text += "==============          \n "
	text += "HELP                    \n "
	text += "EXIT                    \n "
	text += "                        "
	text = text.colorize.back(background).fore(:light_gray)
	puts text


	STDIN.raw do |io|
		buffer = Bytes.new(3)
		bytes_read = io.read(buffer)
		input = String.new(buffer[0, bytes_read])

		case input
		when "\e[A", "w"
			:up
			puts "up"
		when "\e[B", "s"
			:down
			puts "down"
		when "\e[C", "d"
			:right
		when "\e[D", "a"
			:left
		when "\e"
			:escape
		when "\u{3}"
			:ctrl_c
		when "q", "Q"
			:q
		else
			:unknown
		end
	end

	# TODO: read from db and highlight the completed task
end
