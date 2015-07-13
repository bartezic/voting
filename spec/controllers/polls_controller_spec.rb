require 'rails_helper'

RSpec.describe PollsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) {
    {
      question: 'Some question here?',
      multi: true,
      public: true,
      token: 'fdsbfb42',
      options_attributes: [{name: 'Answer 1'},{name: 'Answer 2'}],
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      question: nil
    }
  }

  context 'works for all' do
    describe "GET #show" do
      it "assigns the requested poll as @poll" do
        poll = Poll.create! valid_attributes
        get :show, {:id => poll.token}
        expect(assigns(:poll)).to eq(poll)
      end
    end
  end

  context 'works only for logged in' do
    
    before(:each) do
      sign_in(user)
    end

    describe "GET #index" do
      it "assigns all polls as @polls" do
        poll = Poll.create! valid_attributes
        get :index, {}
        expect(assigns(:polls)).to eq([poll])
      end
    end

    describe "GET #new" do
      it "assigns a new poll as @poll" do
        get :new, {}
        expect(assigns(:poll)).to be_a_new(Poll)
      end
    end

    describe "GET #edit" do
      it "assigns the requested poll as @poll" do
        poll = Poll.create! valid_attributes
        get :edit, {:id => poll.to_param}
        expect(assigns(:poll)).to eq(poll)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Poll" do
          expect {
            post :create, {:poll => valid_attributes}
          }.to change(Poll, :count).by(1)
        end

        it "assigns a newly created poll as @poll" do
          post :create, {:poll => valid_attributes}
          expect(assigns(:poll)).to be_a(Poll)
          expect(assigns(:poll)).to be_persisted
        end

        it "redirects to the polls list" do
          post :create, {:poll => valid_attributes}
          expect(response).to redirect_to(polls_url)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved poll as @poll" do
          post :create, {:poll => invalid_attributes}
          expect(assigns(:poll)).to be_a_new(Poll)
        end

        it "re-renders the 'new' template" do
          post :create, {:poll => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            question: 'Some another question here?',
            multi: false,
            token: 'newToKeN'
          }
        }

        it "updates the requested poll" do
          poll = Poll.create! valid_attributes
          put :update, {:id => poll.to_param, :poll => new_attributes}
          poll.reload
          expect(poll.question).to eq(new_attributes[:question])
          expect(poll.multi).to eq(new_attributes[:multi])
          expect(poll.token).to eq(new_attributes[:token])
        end

        it "assigns the requested poll as @poll" do
          poll = Poll.create! valid_attributes
          put :update, {:id => poll.to_param, :poll => valid_attributes}
          expect(assigns(:poll)).to eq(poll)
        end

        it "redirects to the polls list" do
          poll = Poll.create! valid_attributes
          put :update, {:id => poll.to_param, :poll => new_attributes}
          expect(response).to redirect_to(polls_url)
        end
      end

      context "with invalid params" do
        it "assigns the poll as @poll" do
          poll = Poll.create! valid_attributes
          put :update, {:id => poll.to_param, :poll => invalid_attributes}
          expect(assigns(:poll)).to eq(poll)
        end

        it "re-renders the 'edit' template" do
          poll = Poll.create! valid_attributes
          put :update, {:id => poll.to_param, :poll => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested poll" do
        poll = Poll.create! valid_attributes
        expect {
          delete :destroy, {:id => poll.to_param}
        }.to change(Poll, :count).by(-1)
      end

      it "redirects to the polls list" do
        poll = Poll.create! valid_attributes
        delete :destroy, {:id => poll.to_param}
        expect(response).to redirect_to(polls_url)
      end
    end
  end

end
