module ApplicationHelper
  def broadcast(channel, &block)
    unless Rails.env.test?
      puts "Published to #{channel}"
      uri = URI.parse("http://localhost:9292/faye")
      Net::HTTP.post_form(uri, message: {
        channel: channel,
        data: capture(&block),
        ext: {
          auth_token: FAYE_TOKEN
        }
      }.to_json)
    end
  end
end
