class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
