class YoutubesController < ApplicationController
  # GOOGLE_API_KEY = Rails.application.credentials.google[:api_key]
  # GOOGLE_API_KEY = AIzaSyAnKVFg0CE4X7OhzOe3ZfD23d4IaBAH6uc

  # binding.pry

  def find_videos(keyword, after: 1.months.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = ENV["YOUTUBE_APIKEY"]
    # service.key = AIzaSyAnKVFg0CE4X7OhzOe3ZfD23d4IaBAH6uc

    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 10,
      order: :relevance,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    service.list_searches(:snippet, opt)
  end

  def index
    @youtube_data = find_videos(params[:title])
  end
end
