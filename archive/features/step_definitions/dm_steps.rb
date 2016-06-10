Given /^nothing running$/ do
end

When(/^I use the "(.*?)" option$/) do |arg1|
  char = arg1.should == '-c Marine'
end

Then(/^the character is labelled as a Marine$/) do
  pending # express the regexp above with the code you wish you had
end

