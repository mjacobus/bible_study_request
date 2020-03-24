# frozen_string_literal: true

class BibleStudyRequestsController < ApplicationController
  unless Rails.env.development?
    http_basic_authenticate_with(
      name: ENV['HTTP_BASIC_AUTH'].to_s.split(':').first,
      password: ENV['HTTP_BASIC_AUTH'].to_s.split(':').last,
      only: :index
    )
  end

  def index
    @visitors = Visitor.all
  end

  def new
    @visitor = Visitor.new(
      cid: cid,
      uuid: uuid
    )
  end

  def create
    @visitor = Visitor.new(visitor_params)
    if @visitor.save
      redirect_to new_bible_study_request_path(requested: true)
      return
    end
    render :new
  end

  private

  def visitor_params
    params.require(:visitor).permit(
      :uuid,
      :email,
      :name,
      :phone,
      :cid,
      :message
    )
  end

  def cid
    cookies[:cid] ||= params[:cid]
  end

  def uuid
    session[:uuid] ||= Uuid.new.to_s
  end
end
