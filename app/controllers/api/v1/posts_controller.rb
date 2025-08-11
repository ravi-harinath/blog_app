module Api
  module V1
    class PostsController < ApplicationController
      protect_from_forgery with: :null_session  # Skip CSRF for API

      before_action :set_post, only: %i[show update destroy]

      def index
        posts = Post.order(created_at: :desc)
        render json: posts
      end

      def show
        render json: @post
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
        head :no_content
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body, :published)
      end
    end
  end
end
