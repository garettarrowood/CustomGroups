require 'rails_helper'

describe "Student management" do

  before do
    login
  end

  let!(:group1) { create :group, title: "Class 1", genderfied: "0",user_id: 1 }

  it "can create students right after creating group" do
    visit '/groups/new'

    fill_in "Class title", with: "Example Class"

    click_button "Create Class"

    fill_in "First name", with: "Garett"
    fill_in "Last name", with: "Arrowood"
    choose('student_gender_male')

    click_button "Add student"

    expect(page).to have_content "Student created, next..."
  end

  it "can create new students from roster page" do
    visit "/groups/1/students/roster_edit"

    click_link "Add more students"

    fill_in "First name", with: "Garett"
    fill_in "Last name", with: "Arrowood"
    choose('student_gender_male')

    click_button "Add student"

    expect(page).to have_content "Student created, next..."
  end

  it "will not create if field left empty" do
    visit "/groups/1/students/roster_edit"

    click_link "Add more students"

    fill_in "First name", with: "Bob"

    click_button "Add student"

    expect(page).to have_content "Student was not created"
  end

end
