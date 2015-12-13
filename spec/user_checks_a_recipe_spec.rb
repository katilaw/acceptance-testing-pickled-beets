require "spec_helper"

feature "User checks a recipe's deliciousness", %(
  As a user
  I want to submit a recipe name to see if it is delicious
  So that I know with confidence what to cook.

  Acceptance Criteria:
  [X] When I visit the root path, I can see a form to submit a recipe name
  [X] If I submit a recipe name with "pickled beets" in the name, I am
      sent to a "results" page telling me that the recipe is delicious
  [x] If I submit a recipe name without "pickled beets" in the name, I am
      sent to a "results" page telling me that the recipe is not delicious
  [X] From the "results" page, I am able to click a link bringing me back to
      the home page
  [ ] If I submit a blank entry to the form, I am brought to an error page
  [ ] From the error page, I can click a link bringing me back to the home page

) do
  before :each do
    visit '/'
  end

  scenario "user submits a recipe name containing 'pickled beets'" do
    fill_in 'Recipe Name', with: 'Potatoes and pickled beets'
    click_on('Submit')

    expect(page).to have_content('pickled beets')
    expect(page).to have_content('is a delicious recipe!')
  end

  scenario "user submits a recipe name without 'pickled beets'" do
    visit '/'
    fill_in 'Recipe Name', with: 'Mashed Potatoes'
    click_on('Submit')

    expect(page).to have_content('not a delicious recipe!')
  end

  scenario "user navigates back to the home page after checking a recipe name" do
    visit '/'
    fill_in 'Recipe Name', with: 'Mashed Potatoes'
    click_on('Submit')
    click_on('Try again!')

    expect(page).to have_content('Instructions')
    expect(page).to have_button('Submit')

    visit '/'
    fill_in 'Recipe Name', with: 'Potatoes and pickled beets'
    click_on('Submit')
    click_on('Try again!')

    expect(page).to have_content('Instructions')
  end

  scenario "user submits an empty form" do
    visit '/'
    click_on('Submit')

    expect(page).to have_content('Error')
  end

  scenario "user navigates back to the home page after submitting an empty form" do
    visit '/'
    click_on('Submit')
    click_on('Try again!')

    expect(page).to have_content('The High-Tech Recipe Evaluation Machine')
  end
end
