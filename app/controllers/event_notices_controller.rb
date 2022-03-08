class EventNoticesController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
  end

# ↓は views/event_notices/new.html.erbのフォームで入力された値を受け取っている
  def create
    @group = Group.find(params[:group_id])
    @title = params[:title]
    @body = params[:body]

    event = {
      :group_id => @group,
      :title => @title,
      :body => @body
    }

    ContactMailer.send_notifications_to_group(event)

    render 'sent'
  end

  def sent
    redirect_to group_path(params[:group_id])
  end

end
