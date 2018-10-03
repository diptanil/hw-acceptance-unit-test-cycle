# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |m1, m2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  body = page.body
  loc_m1 = body.index(m1)
  loc_m2 = body.index(m2)
  if loc_m1 == nil || loc_m2 == nil
    fail "One of both search not found"
  else
    expect(loc_m1<loc_m2).to eq(true)
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    if uncheck
      step "I uncheck \"ratings_#{rating.strip}\""
    else
      step "I check \"ratings_#{rating.strip}\""
    end
  end
end


Then /I should see all of the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all("table#movies>tbody tr").count
  expect(rows).to eq(Movie.count)
end


Then /^the director of "(.*)" should be "(.*)"/ do |mov_title, mov_director|
  movie = Movie.find_by_title(mov_title)
  expect(movie.director).to eq(mov_director)
end