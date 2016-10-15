require 'rails_helper'

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

RSpec.describe EbidtaController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Ebidtum. As you add validations to Ebidtum, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EbidtaController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all ebidta as @ebidta" do
      ebidtum = Ebidtum.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:ebidta)).to eq([ebidtum])
    end
  end

  describe "GET #show" do
    it "assigns the requested ebidtum as @ebidtum" do
      ebidtum = Ebidtum.create! valid_attributes
      get :show, params: {id: ebidtum.to_param}, session: valid_session
      expect(assigns(:ebidtum)).to eq(ebidtum)
    end
  end

  describe "GET #new" do
    it "assigns a new ebidtum as @ebidtum" do
      get :new, params: {}, session: valid_session
      expect(assigns(:ebidtum)).to be_a_new(Ebidtum)
    end
  end

  describe "GET #edit" do
    it "assigns the requested ebidtum as @ebidtum" do
      ebidtum = Ebidtum.create! valid_attributes
      get :edit, params: {id: ebidtum.to_param}, session: valid_session
      expect(assigns(:ebidtum)).to eq(ebidtum)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Ebidtum" do
        expect {
          post :create, params: {ebidtum: valid_attributes}, session: valid_session
        }.to change(Ebidtum, :count).by(1)
      end

      it "assigns a newly created ebidtum as @ebidtum" do
        post :create, params: {ebidtum: valid_attributes}, session: valid_session
        expect(assigns(:ebidtum)).to be_a(Ebidtum)
        expect(assigns(:ebidtum)).to be_persisted
      end

      it "redirects to the created ebidtum" do
        post :create, params: {ebidtum: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Ebidtum.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved ebidtum as @ebidtum" do
        post :create, params: {ebidtum: invalid_attributes}, session: valid_session
        expect(assigns(:ebidtum)).to be_a_new(Ebidtum)
      end

      it "re-renders the 'new' template" do
        post :create, params: {ebidtum: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested ebidtum" do
        ebidtum = Ebidtum.create! valid_attributes
        put :update, params: {id: ebidtum.to_param, ebidtum: new_attributes}, session: valid_session
        ebidtum.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested ebidtum as @ebidtum" do
        ebidtum = Ebidtum.create! valid_attributes
        put :update, params: {id: ebidtum.to_param, ebidtum: valid_attributes}, session: valid_session
        expect(assigns(:ebidtum)).to eq(ebidtum)
      end

      it "redirects to the ebidtum" do
        ebidtum = Ebidtum.create! valid_attributes
        put :update, params: {id: ebidtum.to_param, ebidtum: valid_attributes}, session: valid_session
        expect(response).to redirect_to(ebidtum)
      end
    end

    context "with invalid params" do
      it "assigns the ebidtum as @ebidtum" do
        ebidtum = Ebidtum.create! valid_attributes
        put :update, params: {id: ebidtum.to_param, ebidtum: invalid_attributes}, session: valid_session
        expect(assigns(:ebidtum)).to eq(ebidtum)
      end

      it "re-renders the 'edit' template" do
        ebidtum = Ebidtum.create! valid_attributes
        put :update, params: {id: ebidtum.to_param, ebidtum: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested ebidtum" do
      ebidtum = Ebidtum.create! valid_attributes
      expect {
        delete :destroy, params: {id: ebidtum.to_param}, session: valid_session
      }.to change(Ebidtum, :count).by(-1)
    end

    it "redirects to the ebidta list" do
      ebidtum = Ebidtum.create! valid_attributes
      delete :destroy, params: {id: ebidtum.to_param}, session: valid_session
      expect(response).to redirect_to(ebidta_url)
    end
  end

end
