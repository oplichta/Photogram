require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:post) { create(:post) }
  let(:valid_attributes) do
    { post_id: post.id,
      content: 'Some comment'
    }
  end

  describe 'POST /create' do
    context 'user is signed in' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:comment) { create(:comment, user: user, post: post) }

      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in :user, user
        comment.user = user
      end

      describe 'with valid params' do
        it 'creates a comment from factory' do
          expect { create(:comment) }.to change(Comment, :count).by(1)
        end
        # nie działa i nie wiem dlaczego, wyskakuje "wrong number of arguments (2 for 0)"
        it 'create a comment with valid attributes' do
          expect{
            post :create, comment: valid_attributes, post_id: post.to_param
          }.to change(Comment, :count).by(1)
        end
      end
    end
  end
  describe 'DELETE /destroy' do
    let(:user) { create(:user) }
    let(:comment) { create(:comment, user_id: user.to_param) }

    context 'user is not signed in' do
      it 'redirects to login page' do
        delete :destroy, id: comment.id, user_id: user.to_param,
        post_id: comment.post.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'user is signed in' do
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in :user, user
        comment.user = user
      end
      describe 'with valid params' do
        it 'delete a comment' do
          expect{
            delete :destroy, id: comment.id, user_id: user.to_param,
            post_id: comment.post.to_param
          }.to change(Comment, :count).by(-1)
        end
      end
    end
  end
end
