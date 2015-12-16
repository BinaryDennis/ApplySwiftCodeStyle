#!/usr/bin/ruby
#

unless ARGV.length == 1
  puts "Dude, not the right number of arguments!"
  puts "Usage: ./updateCodeStyle.rb path/to/sources\n"
  exit 1
end

input_path = ARGV[0]
if input_path == "."
  input_path=Dir.pwd
end
files = "#{input_path}/**/*.swift"


Dir.glob(files) do  |swift_file|
  puts "updating file #{swift_file}..."

  contents = File.read(swift_file)
  contents.gsub!(/^\s+$/, '')                     # convert empty lines (eg only spaces) to a single newline
  contents.gsub!(/ +$/ , '')                      # right trim line (remove ending whitespaces)
  contents.gsub!(/\n{3,}/, "\n\n")                # squash multiple (3 or more) newlines into 2
  contents.gsub!(/\n{2,}\z/, "\n")                # files should end with 1 newline
  contents.gsub!(/\S\K\n\s*{/, " {\n")            # move starting curly brackets to end of previous line
  contents.gsub!(/;$/, '')                        # remove terminating semicolons
  contents.gsub!(/\/\/\K(\S)/, ' \1')             # Single-line comment should start with whitespace
  contents.gsub!(/^([^\?^\n]+)\K( :)/, ':')       # [colon-whitespace] Colon should have no spaces before it
  contents.gsub!(/(\S:)([^"\s])/, '\1 \2')        # [colon-whitespace] Colon should have exactly one space after it
  #contents.gsub!(/func \K([A-Z])/){ $1.downcase } # functions should start with lowercase
  contents.gsub!(/switch \K\((.+)\)/, '\1')       # Switch expression should not be enclosed within parentheses
  contents.gsub!(/}(\n[^\n])/, '}'"\n"'\1')       # Function should have at least one blank line after it

  File.open(swift_file, "w") { |file| 
    file.puts contents 
  }

end

puts "done"


  
  
