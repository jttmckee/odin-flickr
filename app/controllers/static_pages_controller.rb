
class StaticPagesController < ApplicationController
  def home
    @flickr_id = params[:flickr_id] || ENV['FLICKR_USERNAME']
    FlickRaw.api_key = ENV['FLICKRAW_API_KEY']
    FlickRaw.shared_secret = ENV['FLICKRAW_SHARED_SECRET']
    flickr = FlickRaw::Flickr.new #(ENV['FLICKRAW_API_KEY'], ENV['FLICKRAW_SHARED_SECRET'])
    begin
      @photos = flickr.people.getPublicPhotos(user_id: @flickr_id, per_page: 50)
    rescue
      flash.now[:warning] = 'User not found displaying default'
      @flickr_id = ENV['FLICKR_USERNAME']
      @photos = flickr.people.getPublicPhotos(user_id: @flickr_id, per_page: 50)
    end
  end
end
