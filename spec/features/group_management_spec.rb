require 'rails_helper'

describe "Group management" do

  before do
    login
  end

  let!(:group1) { create :group, title: "Class 1", genderfied: "0",user_id: 1 }
  let!(:group2) { create :group, title: "Class 2", user_id: 1 }

  it "can visit index of groups" do
    visit '/'

    expect(page).to have_content "Select a Class"
  end

  it 'can visit group edit page' do
    visit '/'

    click_link "Edit or Delete class"

    expect(page).to have_content "All your classes"
  end

  it 'can visit specific group show page' do
    visit '/'

    click_link "Class 1"

    expect(page).to have_content "Class 1"
    expect(page).to have_content "Class Roster"
  end

  it 'can create new group' do
    visit '/'

    click_link 'Add Class'

    fill_in "Class title", with: "Example Class"

    click_button "Create Class"

    expect(page).to have_content "Example Class"
    expect(page).to have_content "Add student:"
  end


  it 'will not create new group without title' do
    visit '/groups/new'

    click_button "Create Class"

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Class needs to have a title"
  end

  it 'can update group' do
    visit '/groups/class_edit'

    within("#edit_group_1") do
      fill_in("group_title", with: "Editted Class Title")
    end

    first(:button, "Save Change").click
    expect(page).to have_content "Editted Class Title"
  end

  it 'will not update group with empty field' do
    visit '/groups/class_edit'

    within("#edit_group_1") do
      fill_in("group_title", with: "")
    end

    first(:button, "Save Change").click
    expect(page).to have_content "Unable to update"
  end

  it 'can delete group' do
    visit '/groups/class_edit'

    click_button "Remove Class 1"

    expect(page).to have_content "Class 1 has been deleted."
  end

  it 'can visit class settings' do
    visit '/groups/1'

    click_link "Class settings"

    expect(page).to have_content "On this page you can set parameters for this group's randomization."
  end

  # it 'can change "Gender Mixed" setting' do
  #   visit "/groups/1/class_settings"

  #   check('Gender Mixed:')

  #   click_button "Save selection"

  #   expect(page).to have_css('input.checked')
  # end

end
