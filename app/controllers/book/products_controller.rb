class Book::ProductsController < Book::ApplicationController
  before_action :authenticate_user!
  def index
    @items=Book.all
  end
end
