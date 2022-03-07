class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
  end

  def edit
  end

  def update
  end
end
