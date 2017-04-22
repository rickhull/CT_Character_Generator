def character_data_parse(data)
    data_lines = data.split("\n")
end


Given(/^I need a Navy character$/) do
end

When(/^I run the program with a \-c Navy option$/) do
  character_data = `ruby bin/Chargen -c Navy`
  @cd_output = character_data_parse(character_data)
  @cd_indexed_output = []
  @index = 0
  @cd_output.each do |line|
    @cd_indexed_output[@index] = line.split()
    @index += 1
  end
end

Then(/^Output should have a Navy career listed$/) do 
  match_output = @cd_indexed_output[0].include?('Navy:')
  expect(match_output).to equal(true)
end
