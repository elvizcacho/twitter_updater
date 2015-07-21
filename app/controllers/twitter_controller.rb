class TwitterController < ApplicationController
  
  CLIENTS = Clients.new.clients

  def update_user
    @@i ||= 0
    begin
      param = params[:screen_name] if params[:screen_name].present?
      param = params[:uid].to_i if params[:uid].present?
      response = CLIENTS[@@i].user(param)
      data = {screen_name: response.screen_name, followers: response.followers_count}
      render json: data, status: 200
    rescue Twitter::Error::TooManyRequests => error
      response = "client #{@@i} ready on #{error.rate_limit.reset_in} seconds"
      @@i = (@@i < CLIENTS.count - 1) ? @@i + 1 : @@i = 0
      render json:{response: response}, status: 412
    rescue Twitter::Error::Forbidden => e
      render json:{response: e}, status: 410
    rescue Twitter::Error::NotFound => e
      render json:{response: e}, status: 404
    end
    
  end

end