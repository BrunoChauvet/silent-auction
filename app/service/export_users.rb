require 'csv'

class ExportUsers

  PAGE_MARGINS = [60,45,60,45]
  CARD_GAP_TOP = 1
  CARD_GAP_SIDE = 1
  CARD_WIDTH = 252
  IMG_WIDTH = 60
  DETAIL_WIDTH = CARD_WIDTH - IMG_WIDTH
  CARD_HEIGHT = 144
  LINE_WEIGHT = 20
  CARD_PER_PAGE = 10

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
    pdf = Prawn::Document.new(:page_size => 'A4', :margin => PAGE_MARGINS)
    
    users.each_with_index do |user, index|
puts "USER: #{user.first_name} #{user.last_name}"
      if index % CARD_PER_PAGE == 0
        pdf.stroke do
          pdf.vertical_line -20, -10, :at => 0
          pdf.vertical_line -20, -10, :at => CARD_WIDTH
          pdf.vertical_line -20, -10, :at => 2*CARD_WIDTH

          pdf.vertical_line (5*CARD_HEIGHT+20), (5*CARD_HEIGHT+10), :at => 0
          pdf.vertical_line (5*CARD_HEIGHT+20), (5*CARD_HEIGHT+10), :at => CARD_WIDTH
          pdf.vertical_line (5*CARD_HEIGHT+20), (5*CARD_HEIGHT+10), :at => 2*CARD_WIDTH

          pdf.vertical_line CARD_HEIGHT-2, CARD_HEIGHT+2, :at => CARD_WIDTH
          pdf.horizontal_line CARD_WIDTH-2, CARD_WIDTH+2, :at => CARD_HEIGHT

          pdf.vertical_line 2*CARD_HEIGHT-2, 2*CARD_HEIGHT+2, :at => CARD_WIDTH
          pdf.horizontal_line CARD_WIDTH-2, CARD_WIDTH+2, :at => 2*CARD_HEIGHT

          pdf.vertical_line 3*CARD_HEIGHT-2, 3*CARD_HEIGHT+2, :at => CARD_WIDTH
          pdf.horizontal_line CARD_WIDTH-2, CARD_WIDTH+2, :at => 3*CARD_HEIGHT

          pdf.vertical_line 4*CARD_HEIGHT-2, 4*CARD_HEIGHT+2, :at => CARD_WIDTH
          pdf.horizontal_line CARD_WIDTH-2, CARD_WIDTH+2, :at => 4*CARD_HEIGHT
        end
      end

      gap = 0
      if index % 2 == 1
        gap = CARD_WIDTH + CARD_GAP_SIDE
        pdf.move_cursor_to(pdf.cursor + CARD_HEIGHT) - CARD_GAP_TOP
      else
        pdf.move_cursor_to(pdf.cursor - CARD_GAP_SIDE)
      end

      pdf.stroke do
        pdf.horizontal_line -20, -10, :at => pdf.cursor
        pdf.horizontal_line (CARD_WIDTH * 2 + 10), (CARD_WIDTH * 2 + 20), :at => pdf.cursor
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
      end

      pdf.stroke do
        pdf.horizontal_line -20, -10, :at => pdf.cursor
        pdf.horizontal_line (CARD_WIDTH * 2 + 10), (CARD_WIDTH * 2 + 20), :at => pdf.cursor
      end

      if index % CARD_PER_PAGE == (CARD_PER_PAGE - 1)
        pdf.start_new_page
        print_card_back(pdf)
      end
    end

    pdf
  end

  def self.print_card_back(pdf)
    (0..CARD_PER_PAGE-1).each do |index|
      gap = 0
      if index % 2 == 1
        gap = CARD_WIDTH + CARD_GAP_SIDE
        pdf.move_cursor_to(pdf.cursor + CARD_HEIGHT) - CARD_GAP_TOP
      else
        pdf.move_cursor_to(pdf.cursor - CARD_GAP_SIDE)
      end

      pdf.bounding_box([gap, pdf.cursor], width: CARD_WIDTH, height: CARD_HEIGHT) do
        pdf.image "#{Rails.root}/app/assets/images/etihad-logo.jpg",
          :at => [10, pdf.cursor - 25], scale: 0.7

        # pdf.stroke_color '000000'
        # pdf.stroke_bounds
      end

    end

    pdf.start_new_page
    pdf
  end
end