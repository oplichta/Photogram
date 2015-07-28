require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:valid_attributes) do
    {
      image: Rack::Test::UploadedFile.new(Rails.root +
      'spec/fixtures/images/coffee.png', 'image/png'),
      caption: 'Some description'
    }
  end

  describe 'POST create' do
    context 'when user is not signed in' do
      describe 'with valid params' do
      it 'redirects user to login page' do
          post :create, post: valid_attributes
          expect(response).to redirect_to(new_user_session_path)
        end
    end

    describe 'PUT update' do
      it 'redirects user to login page' do
        post = create(:post)
        put :update, id: post.to_param, caption: { title: 'MyString' }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET edit' do
      it 'redirects user to login page' do
        post = create(:post)
        get :edit, id: post.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

    describe 'GET index' do
      it 'not redirects user to login page' do
        create(:post)
        get :index
        expect(response).to_not redirect_to(new_user_session_path)
      end
    end

    describe 'GET show' do
      it 'redirects user to login page' do
        post = create(:post)
        get :show, { id: post.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET new' do
      it 'redirects user to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when user is signed in' do
    let(:user) { create(:user) }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in :user, user
    end

    describe 'POST /create' do
      describe 'with valid params' do
        it 'creates a new Post' do
          expect{
            post :create, post: valid_attributes
          }.to change(Post, :count).by(1)
        end

        it 'expose a newly created post' do
          post :create, post: valid_attributes
          expect(assigns(:post)).to be_a(Post)
          expect(assigns(:post)).to be_persisted
        end

        it 'redirects to the created post' do
          post :create, post: valid_attributes
          expect(response).to redirect_to(post_path(Post.last))
        end
      end

      describe 'with invalid params' do
        it 'expose a newly created but unsaved post' do
          allow_any_instance_of(Post).to receive(:save).and_return(false)
          post :create, post: { 'caption' => 'invalid value' }
          expect(assigns(:post)).to be_a_new(Post)
        end

        it "re-renders the 'new' template" do
          post :create, post: { 'caption' => 'invalid value' }
          allow_any_instance_of(Post).to receive(:save).and_return(false)
          expect(response).to render_template('new')
        end
      end
    end


    describe 'PUT update' do
      describe 'with valid params' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user: user ) }

        before do
          @request.env['devise.mapping'] = Devise.mappings[:user]
          @user = FactoryGirl.create(:user)
          sign_in :user, user
          post.user = @user
        end

        it 'updates the requested post' do
          put :update, id: post.to_param, post: { 'title' => 'New value' }
          expect(response).to redirect_to(post_path(post))
        end

        it 'expose the requested post' do
          put :update, id: post.to_param, post: { 'title' => 'New value' }
          expect(assigns(:post)).to eq(post)
        end

        it 'redirects to the post' do
          put :update, id: post.to_param, post: { 'title' => 'New value' }
          expect(response).to redirect_to(post_path(post))
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    context 'user is signed in' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in :user, user
        post.user = @user
      end

      it 'destroys the requested post' do
        expect {
          delete :destroy, id: post.to_param
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to the posts page' do
        delete :destroy, id: post.to_param
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'user is not signed in' do
      it 'redirects user to login page' do
        delete :destroy, id: post.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
