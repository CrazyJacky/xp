class TagsController < ApplicationController
  def create
    @tag = Tag.new(:name => params[:name], :category => "topic")

    if @tag.save
      redirect_to :back
    else
      redirect_to :back
      # render "lessons/new"
    end
  end
  def new 
    @tag = Tag.new
  end
end