require "rails_helper"
describe "Signed User", type: :feature do  
  let(:user) {create(:user)}
  def sign_in(user)
    visit "/"
    within "form[action='#{authenticate_path}']" do
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
  
  it "shares a valid url movie" do
    sign_in(user)
    click_link("Share a move")
    youtube_video_id = "a-video-id"
    url = "https://youtube.com?v=#{youtube_video_id}"
    youtube_video = double(:youtube_video, title: 'handsome kent',
                            description: 'long long long description')
    expect(Yt::Video).to receive(:new).with(id: youtube_video_id).at_least(1).and_return(youtube_video)
    
    within "form[action='#{movies_path}']" do
      fill_in "url", with: url
      click_button "Share"
    end
    expect(page).to have_content("Thank you for your sharing")
    expect(page).to have_content(youtube_video.title)    
  end

  it "shares a invalid url" do
    sign_in(user)
    click_link("Share a move")
    within "form[action='#{movies_path}']" do
      fill_in "url", with: "https://randome.url"
      click_button "Share"
    end
    expect(page).to have_content("Invalid Youtube URL")
  end
end