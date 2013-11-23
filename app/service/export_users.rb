require 'csv'

class ExportUsers
  def self.export_highest_bids
    auction = []
    items = Item.order(:code)
    items.each do |item|
      last_bid = Bid.where(item: item).order('timestamp desc').first
      auction << {item: item, bid: last_bid, user: last_bid.try(:user)}
    end
    
    CSV.generate do |csv|
      csv << ['Pakcage Number', 'Package Name', 'Highest Bidder', 'Bidder Table', 'Amount']
      items = Item.order(:code)
      items.each do |item|
        last_bid = Bid.where(item: item).order('timestamp desc').first
        user = last_bid.try(:user)
        csv << [item.code,
                item.name,
                "#{user.try(:title)} #{user.try(:first_name)} #{user.try(:last_name)}",
                "#{user.try(:user_group).try(:name)}",
                "#{last_bid.try(:price)}"]
      end
    end
  end

  def self.export_user_cards_pdf(users)
    pdf = Prawn::Document.new(:margin => [20,40,20,40])

    card_gap = 15
    card_width = 252
    img_width = 60
    detail_width = card_width - img_width
    card_height = 144
    line_height = 20
    
    users.each_with_index do |user, index|
      gap = 0
      if index % 2 == 1
        gap = card_width + card_gap
        pdf.move_cursor_to( pdf.cursor + card_height)
      else
        pdf.move_cursor_to(pdf.cursor - card_gap)
      end

      pdf.bounding_box([gap, pdf.cursor], width: card_width, height: card_height) do
        pdf.bounding_box([0, pdf.bounds.top], width: img_width, height: card_height) do
          pdf.image "#{Rails.root}/app/assets/images/ufe_logo.png",
            :at => [5, pdf.cursor - 25], scale: 0.9
        end

        pdf.bounding_box([img_width, pdf.bounds.top], width: detail_width, height: card_height) do
          pdf.bounding_box([0, pdf.cursor - 30], width: detail_width, height: line_height) do
            pdf.text_box("Silent Auction", size: 18, align: :center)
          end

          pdf.bounding_box([0, pdf.cursor - 5], width: detail_width, height: line_height) do
            pdf.text_box("#{user.title} #{user.first_name} #{user.last_name}", size: 14, align: :center)
          end

          pdf.bounding_box([20, pdf.cursor], width: detail_width - 40, height: line_height) do
            pdf.formatted_text_box([text: "PIN: ", size: 12, align: :center, color: "606060"],
              at: [30, line_height - 6], height: line_height, width: 40)
            pdf.formatted_text_box([text: "#{user.pin}", size: 14, align: :center, color: "606060"],
              at: [80, line_height - 4], height: line_height, width: 40)

            pdf.stroke_color '606060'
            pdf.stroke_bounds
          end

          pdf.bounding_box([0, pdf.cursor], width: detail_width, height: line_height) do
            pdf.formatted_text_box([text: "Charity Gala UFE 2013", size: 10, align: :center, color: "8080A0"],
              at: [20, -15], height: line_height, width: detail_width)
          end

        end

        pdf.stroke_color '000000'
        pdf.stroke_bounds
      end

      if index % 8 == 7
        pdf.start_new_page
      end
    end

    pdf
  end
end