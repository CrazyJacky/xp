require 'spec_helper'

describe LessonsController do
  let!(:user) { create(:user) }

  before(:each) do
    $rspec_user_id = user.id
  end

  describe "GET 'index'" do

    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    xit "has the xp logo on it" do
      get :index
      expect(response).to include("xp")
    end

  end

end