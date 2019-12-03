require "rails_helper"
describe "Signed User", type: :feature do  
  let(:user) {create(:user)}
  def sign_in(user)
    visit "/"
    within "form[action='/authenticate']" do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: "test"
      click_button "Login/Register"
    end
  end

  def expect_with(page, user)
    expect(page).to have_content("Welcome #{user.email}")
    expect(page).to have_link("Share a move", href: new_movie_path)
    expect(page).to have_link("Logout", href: logout_path)
  end

  it "signs in" do
    sign_in(user)    
    expect_with(page, user)
  end

  it "signs with new user [Register]" do
    user = User.new email: "random#{Time.now.to_i}@sample.com"
    sign_in(user)
    expect_with(page, user)
  end

  it "signs out" do
    sign_in(user)
    click_link("Logout")
    expect(page).to have_selector("form[action='/authenticate']")
  end
  
end