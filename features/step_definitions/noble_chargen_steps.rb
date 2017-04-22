def character_data_parse(data)
    data_lines = data.split("\n")
end


Given(/^I need a Noble character$/) do
end

When(/^I run the program with a \-c Noble option$/) do
  character_data = `ruby bin/Chargen -c Noble`
  @cd_output = character_data_parse(character_data)
  @cd_indexed_output = []
  @index = 0
  @cd_output.each do |line|
    @cd_indexed_output[@index] = line.split()
    @index += 1
  end
end

Then(/^Output should have a Noble career listed$/) do 
  match_output = @cd_indexed_output[0].include?('Noble:')
  expect(match_output).to equal(true)
end
