class GenerateReceipts

  RECEIPT_WIDTH = 510
  RECEIPT_HEIGHT = 710
  CONTENT_WIDTH = RECEIPT_WIDTH - 80
  LC_WIDTH = 100
  LC_WIDTH2 = 120
  TITLE_COLOR = "335599"
  TEXT_COLOR = "303030"

  def self.receipt_for(pdf, item)
    bid = Bid.where(item: item).order('timestamp desc').first
    return pdf unless bid

    if pdf
      pdf.start_new_page
    else
      pdf = Prawn::Document.new(:margin => [40,50,40,50])
    end

    user = bid.user

    pdf.bounding_box([0, pdf.cursor], width: RECEIPT_WIDTH, height: RECEIPT_HEIGHT) do
      pdf.image "#{Rails.root}/app/assets/images/ufe_logo.png", :at => [5, pdf.cursor - 25], scale: 0.9

      pdf.formatted_text_box([text: "UFE Charity Gala",
                              size: 32, align: :center, color: TITLE_COLOR],
                              at: [150, pdf.cursor - 45], height: 30, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "SATURDAY 30TH NOVEMBER 2013",
                              size: 12, align: :center, color: TITLE_COLOR],
                              at: [170, pdf.cursor - 80], height: 15, width: CONTENT_WIDTH)

      add_bid_detail(pdf, bid)
      add_contact(pdf)
      add_payment(pdf)

      pdf.stroke_color '000000'
      pdf.stroke_bounds

    end

    pdf
  end

private

  def self.add_bid_detail(pdf, bid)
    item = bid.item
    user = bid.user

    pdf.bounding_box([40, pdf.cursor - 110], width: CONTENT_WIDTH, height: 140) do
      pdf.formatted_text_box([text: "SILENT AUCTION CONTRACT NOTE", size: 18, align: :center, color: TITLE_COLOR, styles: [:bold]],
                              at: [60, pdf.cursor - 10], height: 25, width: CONTENT_WIDTH)
      
      pdf.formatted_text_box([text: "ITEM", size: 18, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 40], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "#{item.code} #{item.name}", size: 16, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH, pdf.cursor - 40], height: 20, width: CONTENT_WIDTH - LC_WIDTH)

      pdf.formatted_text_box([text: "BID", size: 18, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 70], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "$#{bid.price}", size: 16, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH, pdf.cursor - 70], height: 20, width: CONTENT_WIDTH - LC_WIDTH)

      pdf.formatted_text_box([text: "BUYER", size: 18, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 100], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "#{user.title} #{user.first_name} #{user.last_name}",
                              size: 16, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH, pdf.cursor - 100], height: 20, width: CONTENT_WIDTH - LC_WIDTH)

      pdf.stroke_color '606060'
      pdf.stroke_bounds
    end
  end
  
  def self.add_contact(pdf)
    pdf.bounding_box([40, pdf.cursor], width: CONTENT_WIDTH, height: 140) do
      pdf.formatted_text_box([text: "Address:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 40], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "___________________________________",
                              size: 16, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH, pdf.cursor - 40], height: 20, width: CONTENT_WIDTH - LC_WIDTH)

      pdf.formatted_text_box([text: "___________________________________",
                              size: 16, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH, pdf.cursor - 60], height: 20, width: CONTENT_WIDTH - LC_WIDTH)

      pdf.formatted_text_box([text: "Phone:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 90], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "___________________________________",
                              size: 16, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH, pdf.cursor - 90], height: 20, width: CONTENT_WIDTH - LC_WIDTH)
    end
  end

  def self.add_payment(pdf)
    pdf.bounding_box([40, pdf.cursor], width: CONTENT_WIDTH, height: 140) do
      pdf.formatted_text_box([text: "METHOD OF PAYMENT", size: 16, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 10], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "Use payment method from previous auction item", size: 14, align: :center, color: TEXT_COLOR],
                              at: [25, pdf.cursor - 35], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "CASH:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 60], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "$________", size: 14, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH2, pdf.cursor - 60], height: 20, width: CONTENT_WIDTH - LC_WIDTH2)

      pdf.formatted_text_box([text: "CHEQUE:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 80], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "$________", size: 14, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH2, pdf.cursor - 80], height: 20, width: CONTENT_WIDTH - LC_WIDTH2)

      pdf.formatted_text_box([text: "CREDIT CARD:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 100], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "$________", size: 14, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH2, pdf.cursor - 100], height: 20, width: CONTENT_WIDTH - LC_WIDTH2)

      pdf.formatted_text_box([text: "BANKCARD            VISA            MASTER CARD            AMEX", size: 14, color: TEXT_COLOR],
                              at: [25, pdf.cursor - 130], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "CARD No:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 150], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "____ ____ ____ ____", size: 14, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH2 + 60, pdf.cursor - 150], height: 20, width: CONTENT_WIDTH - LC_WIDTH2)

      pdf.formatted_text_box([text: "EXPIRY DATE:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 170], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "____ / ____", size: 14, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH2 + 60, pdf.cursor - 170], height: 20, width: CONTENT_WIDTH - LC_WIDTH2)

      pdf.formatted_text_box([text: "CARDHOLDER'S NAME:", size: 14, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 190], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "___________________", size: 14, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH2 + 60, pdf.cursor - 190], height: 20, width: CONTENT_WIDTH - LC_WIDTH2)

      pdf.formatted_text_box([text: "BUYER'S SIGNATURE:", size: 16, align: :center, color: TEXT_COLOR, styles: [:bold]],
                              at: [10, pdf.cursor - 240], height: 20, width: CONTENT_WIDTH)

      pdf.formatted_text_box([text: "___________________", size: 14, align: :center, color: TEXT_COLOR],
                              at: [LC_WIDTH2 + 80, pdf.cursor - 240], height: 20, width: CONTENT_WIDTH - LC_WIDTH2)

      pdf.bounding_box([10, pdf.cursor - 35], width: 10, height: 10) do
        pdf.stroke_bounds
      end
      pdf.move_cursor_to(pdf.cursor + 45)

      pdf.bounding_box([10, pdf.cursor - 130], width: 10, height: 10) do
        pdf.stroke_bounds
      end
      pdf.move_cursor_to(pdf.cursor + 140)

      pdf.bounding_box([135, pdf.cursor - 130], width: 10, height: 10) do
        pdf.stroke_bounds
      end
      pdf.move_cursor_to(pdf.cursor + 140)

      pdf.bounding_box([215, pdf.cursor - 130], width: 10, height: 10) do
        pdf.stroke_bounds
      end
      pdf.move_cursor_to(pdf.cursor + 140)

      pdf.bounding_box([365, pdf.cursor - 130], width: 10, height: 10) do
        pdf.stroke_bounds
      end
      pdf.move_cursor_to(pdf.cursor + 140)


    end
  end
end