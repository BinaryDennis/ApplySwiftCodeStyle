#!/usr/bin/ruby
#
# author: Dennis Korkchi (@BinaryDennis)


unless ARGV.length == 1
  puts "Dude, not the right number of arguments!"
  puts "Usage: ./applyCodeStyle.rb path/to/sources\n"
  exit 1
end

input_path = ARGV[0]
if input_path == "."
	input_path=Dir.pwd
end
files = "#{input_path}/*/*.swift"


Dir.glob(files) do  |swift_file|
  puts "updating file #{swift_file}..."

  contents = File.read(swift_file)
  contents = contents.gsub(/^ +$/, '')              # convert empty lines (eg only spaces) to a single newline
  contents = contents.gsub(/ +$/ , '')              # right trim line (remove ending whitespaces)
  contents = contents.gsub(/\n{3,}/, "\n\n")        # squash multiple (3 or more) newlines into 2
  contents = contents.gsub(/\n{2,}\z/, "\n")        # files should end with 1 newline
  contents = contents.gsub(/\S\K\n\s*{/, " {\n")    # move starting curly brackets to end of previous line
  contents = contents.gsub(/;$/, '')                # remove terminating semicolons

  File.open(swift_file, "w") { |file| 
  	file.puts contents 
  }

end

puts "done"


  
  
