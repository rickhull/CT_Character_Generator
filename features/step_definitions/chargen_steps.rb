def character_data_parse(data)
    data_lines = data.split("\n")
end


Given(/^I need a character$/) do
end

When(/^I run the program with a \-b option$/) do
  character_data = `ruby bin/Chargen -b`
  @cd_output = character_data_parse(character_data)
  @cd_indexed_output = []
  @index = 0
  @cd_output.each do |line|
    @cd_indexed_output[@index] = line.split()
    @index += 1
  end
end

Then(/^Output should have a six hex digit UPP$/) do 
  # This fails to fail if the number in the {} isn't 6 or less.
  match_output = @cd_indexed_output[0][-1].match(/[[:xdigit:]]{6}/)
  expect(match_output).not_to eq(nil)
end
And(/^Output age should be 18 or greater$/) do 
  expect(@cd_indexed_output[0][-2].to_i).to be >= 18
end

