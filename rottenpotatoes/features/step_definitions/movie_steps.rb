# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1)).to be <= page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |boolean, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')
  ratings.each do |rating|
      step 'I ' + boolean.to_s + 'check "ratings_' + rating + '"'
  end
end

Then /I should( not)? see the following movies/ do |boolean, movies_table|
  movies_table.hashes.each do |movie|
    step 'I should' + boolean.to_s + ' see "' + movie['title'] + '"'
  end
end

Then /I should see all of the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = find_by_id('movies').all('tr').size - 1
  expect(rows).to eq 10
    
    #rows = page.all("table#movies tbody tr td[1]").map {|t| t.text}
    #if should == "none"
    #    assert rows.size == 0
    #else
    #    assert rows.size == Movie.all.count
    #end
    
end
