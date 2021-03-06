require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    it "should have title" do
      get 'new'
      response.should have_selector("title",
                      content: "Sign Up")
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
  end

  end

  describe "POST 'create'" do
    describe "failture" do
      before(:each) do
        @attr = {:name => "", :email => "",:password => "", :password_confirmation => ""}
      end
      it "should not create a user" do
        lambda do
          post :create , :user => @attr
          end.should_not change(User, :count)
      end
      it "should have the right title" do
        post :create , :user => @attr
        response.should have_selector("title", :content => "Sign Up")
      end
      it "should render the 'new' page" do
        post :create , :user => @attr
        response.should render_template('new')
      end
    end
    describe "success" do
      before(:each) do
        @attr= {:name => "New User",
                :email => "user@example.com",
                :password => "foobar",
                :password_confirmation => "foobar"}
      end
      it "should a create user" do
        lambda do
          post :create , :user => @attr
          end.should change(User, :count).by(1)
      end
      it "should redirect to user name show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      it "should a welcome message" do
        post :create , :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end

  describe "GET'edit'" do
    before(:each)do
      @user=Factory(:user)
      test_sign_in(@user)
    end
    it "should be successful" do
      get :edit, id: @user
      response.should be_success
    end
     it "should have right title" do
       get :edit, id: @user
       response.should have_selector("title" , content: "Edit user")
     end
    it "should have a link to change gravatar" do
      get :edit, id: @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", href: gravatar_url,content:"Change Avatar")
    end
  end

end
