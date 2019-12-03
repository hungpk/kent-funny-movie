require "rails_helper"
RSpec.describe User, type: :model do
  context "#authenticate" do
    it "returns user" do
      user = create(:user)
      expected = User.authenticate(email: user.email, password: 'test')
      expect(expected.id).to eq(user.id)      
    end
    
    it "returns nil" do
      expect(User.authenticate(email: 'random@email', password: 'test')).to be_nil
    end
  end
end