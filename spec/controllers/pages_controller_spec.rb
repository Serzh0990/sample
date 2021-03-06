require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    it "should_have_a_title" do
      get 'home'
      response.should have_selector("title",
                      :content=> " | Home")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    it "should_have_a_title" do
      get 'contact'
      response.should have_selector("title",
                      :content=> " | Contact")
    end
  end
  describe "GET 'about'" do
    it "returns_http_success" do
      get 'about'
      response.should be_success
    end
    it "should_have_a_title" do
      get 'about'
      response.should have_selector("title",
                      :content=> " | About")
    end
  end
  describe "GET 'help'" do
   it "returns_http_success" do
     get 'help'
     response.should be_success
   end
  end

end
