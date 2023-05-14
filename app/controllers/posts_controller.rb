# frozen_string_literal: true

class PostsController < Controller
  def index
    @posts = Post.all
  end
end
