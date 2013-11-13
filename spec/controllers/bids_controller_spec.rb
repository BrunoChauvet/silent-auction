require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BidsController do

  # This should return the minimal set of attributes required to create a valid
  # Bid. As you add validations to Bid, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "price" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BidsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all bids as @bids" do
      bid = Bid.create! valid_attributes
      get :index, {}, valid_session
      assigns(:bids).should eq([bid])
    end
  end

  describe "GET show" do
    it "assigns the requested bid as @bid" do
      bid = Bid.create! valid_attributes
      get :show, {:id => bid.to_param}, valid_session
      assigns(:bid).should eq(bid)
    end
  end

  describe "GET new" do
    it "assigns a new bid as @bid" do
      get :new, {}, valid_session
      assigns(:bid).should be_a_new(Bid)
    end
  end

  describe "GET edit" do
    it "assigns the requested bid as @bid" do
      bid = Bid.create! valid_attributes
      get :edit, {:id => bid.to_param}, valid_session
      assigns(:bid).should eq(bid)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bid" do
        expect {
          post :create, {:bid => valid_attributes}, valid_session
        }.to change(Bid, :count).by(1)
      end

      it "assigns a newly created bid as @bid" do
        post :create, {:bid => valid_attributes}, valid_session
        assigns(:bid).should be_a(Bid)
        assigns(:bid).should be_persisted
      end

      it "redirects to the created bid" do
        post :create, {:bid => valid_attributes}, valid_session
        response.should redirect_to(Bid.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bid as @bid" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bid.any_instance.stub(:save).and_return(false)
        post :create, {:bid => { "price" => "invalid value" }}, valid_session
        assigns(:bid).should be_a_new(Bid)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bid.any_instance.stub(:save).and_return(false)
        post :create, {:bid => { "price" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bid" do
        bid = Bid.create! valid_attributes
        # Assuming there are no other bids in the database, this
        # specifies that the Bid created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Bid.any_instance.should_receive(:update).with({ "price" => "MyString" })
        put :update, {:id => bid.to_param, :bid => { "price" => "MyString" }}, valid_session
      end

      it "assigns the requested bid as @bid" do
        bid = Bid.create! valid_attributes
        put :update, {:id => bid.to_param, :bid => valid_attributes}, valid_session
        assigns(:bid).should eq(bid)
      end

      it "redirects to the bid" do
        bid = Bid.create! valid_attributes
        put :update, {:id => bid.to_param, :bid => valid_attributes}, valid_session
        response.should redirect_to(bid)
      end
    end

    describe "with invalid params" do
      it "assigns the bid as @bid" do
        bid = Bid.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Bid.any_instance.stub(:save).and_return(false)
        put :update, {:id => bid.to_param, :bid => { "price" => "invalid value" }}, valid_session
        assigns(:bid).should eq(bid)
      end

      it "re-renders the 'edit' template" do
        bid = Bid.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Bid.any_instance.stub(:save).and_return(false)
        put :update, {:id => bid.to_param, :bid => { "price" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bid" do
      bid = Bid.create! valid_attributes
      expect {
        delete :destroy, {:id => bid.to_param}, valid_session
      }.to change(Bid, :count).by(-1)
    end

    it "redirects to the bids list" do
      bid = Bid.create! valid_attributes
      delete :destroy, {:id => bid.to_param}, valid_session
      response.should redirect_to(bids_url)
    end
  end

end
