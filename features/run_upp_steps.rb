Given /^nothing running$/ do
  @upp = Upp.new
end

When /^I run the program$/ do
  @stats = @upp.create
end

Then /^I get a 6 hex digit string$/ do
  @stats.should == '778899'
end

