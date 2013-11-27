require 'csv'

class ExportUsers

  CARD_GAP = 15
  CARD_WIDTH = 252
  IMG_WIDTH = 60
  DETAIL_WIDTH = CARD_WIDTH - IMG_WIDTH
  CARD_HEIGHT = 144
  LINE_WEIGHT = 20

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
    
    users.each_with_index do |user, index|
      gap = 0
      if index % 2 == 1
        gap = CARD_WIDTH + CARD_GAP
        pdf.move_cursor_to( pdf.cursor + CARD_HEIGHT)
      else
        pdf.move_cursor_to(pdf.cursor - CARD_GAP)
      end

      pdf.bounding_box([gap, pdf.cursor], width: CARD_WIDTH, height: CARD_HEIGHT) do
        pdf.bounding_box([0, pdf.bounds.top], width: IMG_WIDTH, height: CARD_HEIGHT) do
          pdf.image "#{Rails.root}/app/assets/images/logo-ufe.jpg",
            :at => [5, pdf.cursor - 25]
        end

        pdf.bounding_box([IMG_WIDTH, pdf.bounds.top], width: DETAIL_WIDTH, height: CARD_HEIGHT) do
          pdf.bounding_box([0, pdf.cursor - 30], width: DETAIL_WIDTH, height: LINE_WEIGHT) do
            pdf.text_box("Silent Auction", size: 18, align: :center)
          end

          pdf.bounding_box([0, pdf.cursor - 5], width: DETAIL_WIDTH, height: LINE_WEIGHT) do
            pdf.text_box("#{user.title} #{user.first_name} #{user.last_name}", size: 14, align: :center)
          end

          pdf.bounding_box([20, pdf.cursor], width: DETAIL_WIDTH - 40, height: LINE_WEIGHT) do
            pdf.formatted_text_box([text: "PIN: ", size: 12, align: :center, color: "606060"],
              at: [30, LINE_WEIGHT - 6], height: LINE_WEIGHT, width: 40)
            pdf.formatted_text_box([text: "#{user.pin}", size: 14, align: :center, color: "606060"],
              at: [80, LINE_WEIGHT - 4], height: LINE_WEIGHT, width: 40)

            pdf.stroke_color '606060'
            pdf.stroke_bounds
          end

          pdf.bounding_box([0, pdf.cursor], width: DETAIL_WIDTH, height: LINE_WEIGHT) do
            pdf.formatted_text_box([text: "Charity Gala UFE 2013", size: 10, align: :center, color: "8080A0"],
              at: [20, -15], height: LINE_WEIGHT, width: DETAIL_WIDTH)
          end

        end

        pdf.stroke_color '000000'
        pdf.stroke_bounds
      end

      if index % 8 == 7
        pdf.start_new_page
        print_card_back(pdf)
      end
    end

    pdf
  end

  def self.print_card_back(pdf)
    (0..7).each do |index|
      gap = 0
      if index % 2 == 1
        gap = CARD_WIDTH + CARD_GAP
        pdf.move_cursor_to( pdf.cursor + CARD_HEIGHT)
      else
        pdf.move_cursor_to(pdf.cursor - CARD_GAP)
      end

      pdf.bounding_box([gap, pdf.cursor], width: CARD_WIDTH, height: CARD_HEIGHT) do
        pdf.image "#{Rails.root}/app/assets/images/etihad-logo.jpg",
          :at => [10, pdf.cursor - 25], scale: 0.7

        pdf.stroke_color '000000'
        pdf.stroke_bounds
      end

    end

    pdf.start_new_page
    pdf
  end
end