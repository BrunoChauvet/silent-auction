class GenerateReceipts
  def self.receipt_for(pdf, item)
    bid = Bid.where(item: item).order('timestamp desc').first
    return pdf unless bid

    if pdf
      pdf.start_new_page
    else
      pdf = Prawn::Document.new(:margin => [40,50,40,50])
    end

    user = bid.user

    receipt_width = 510
    receipt_height = 710

    content_width = receipt_width - 80

    pdf.bounding_box([0, pdf.cursor], width: receipt_width, height: receipt_height) do
      pdf.image "#{Rails.root}/app/assets/images/ufe_logo.png", :at => [5, pdf.cursor - 25], scale: 0.9

      pdf.formatted_text_box([text: "UFE CHARITY GALA 2013",
                              size: 20, align: :center, color: "606060"],
                              at: [120, pdf.cursor - 45], height: 60, width: content_width)

      pdf.bounding_box([40, pdf.cursor - 80], width: content_width, height: 250) do
        pdf.formatted_text_box([text: "Silent Auction Receipt ",
                                size: 14, align: :center, color: "606060"],
                                at: [0, pdf.cursor - 10], height: 60, width: content_width)
        
        pdf.formatted_text_box([text: "#{item.code} #{item.name}",
                                size: 18, align: :center, color: "606060"],
                                at: [0, pdf.cursor - 40], height: 60, width: content_width)

        pdf.formatted_text_box([text: "#{user.title} #{user.first_name} #{user.last_name}",
                                size: 18, align: :center, color: "606060"],
                                at: [0, pdf.cursor - 70], height: 60, width: content_width)

        pdf.formatted_text_box([text: "$#{bid.price}",
                                size: 18, align: :center, color: "606060"],
                                at: [0, pdf.cursor - 100], height: 60, width: content_width)

        pdf.stroke_color '606060'
        pdf.stroke_bounds
      end

      pdf.stroke_color '000000'
      pdf.stroke_bounds
    end

    pdf
  end
end