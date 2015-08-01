require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:post) { create(:post) }
  let(:valid_attributes) do
    {
      post_id: post.id,
      content: 'Some comment'
    }
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
            delete :destroy, { id: comment.id, user: user, post_id: comment.post }
          }.to change{
            Comment.count
          }.by(-1)
        end
      end
    end
  end
end
