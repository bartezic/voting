require 'rails_helper'

RSpec.describe "Polls", type: :request do
  describe "GET /polls" do
    it "works for logined user" do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      get polls_path
      expect(response).to have_http_status(200)
    end

    it "redirects for unlogined user" do
      get polls_path
      expect(response).to have_http_status(302)
    end
  end
end
