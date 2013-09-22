class AuctionController < ApplicationController
  include ActionController::Live

  Mime::Type.register "text/event-stream", :stream
  
  def index
    respond_to do |format|
      format.html

      format.json {
        auction = []
        items = Item.all(order: :id)
        items.each do |item|
          last_bid = Bid.where(item: item).order('timestamp desc').first
          auction << {item: item, bid: last_bid, user: last_bid.try(:user)}
        end
        render json: auction
      }

      format.stream {
        response.headers['Content-Type'] = 'text/event-stream'
        begin
          last_update = nil
          loop do
            Bid.uncached do
              if last_update.nil? || last_update < Bid.maximum(:timestamp)
                last_update = Bid.maximum(:timestamp)
                
                auction = []
                items = Item.all(order: :id)
                items.each do |item|
                  last_bid = Bid.where(item: item).order('timestamp desc').first
                  auction << {item: item, bid: last_bid, user: last_bid.try(:user)}
                end
                response.stream.write "data: #{auction.to_json}\n\n"
              end
            end
            sleep 1
          end
        rescue IOError
        ensure
          response.stream.close
        end
      }
    end
  end

end
