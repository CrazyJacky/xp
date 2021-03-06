require 'spec_helper'
include Math

describe UsersController do
  let(:user) { create(:user) }

  before(:each) do
    $rspec_user_id = user.id
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, nickname: user.nickname
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'update_xp'" do
    it "returns http success" do
      user.token = "f657b84d292b178211377015c8bdffeb012aec49"
      user.save
      get :update_xp, nickname: user.nickname
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, nickname: user.nickname
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "POST 'update'" do
    it "returns http success" do
      post :update, nickname: user.nickname, user: { bio: "Bio Update" }
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "#reduce_line_counts" do
    it "can sqrt the line counts of every language in the hash" do
      language_array = [{:Ruby=>10037}, {:Ruby=>4118, :CSS=>6040}, {:Arduino=>2285, :JavaScript=>1078, :Ruby=>965}, {:Ruby=>5437}, {}, {:JavaScript=>27654}, {:Ruby=>20027, :JavaScript=>664, :CoffeeScript=>211, :CSS=>1749}, {:Ruby=>68329, :JavaScript=>3801, :CoffeeScript=>845, :CSS=>4901}] 
      @controller.reduce_line_counts(language_array)
      expect(language_array[1][:CSS]).to eq(sqrt(6040))
    end
  end

end
