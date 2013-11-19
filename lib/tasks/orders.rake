desc "Send some orders for your biz"
task send_orders: :environment do
  Order.all.each do |order|
    av  = ActionView::Base.new(ActionController::Base.view_paths)
    pdf = WickedPdf.new.pdf_from_string(av.render(:pdf      => "temp.pdf",
                                                  :template => 'orders/show',
                                                  :formats  => ['pdf'],
                                                  :layout   => 'layouts/print.html',
                                                  :locals   => {:@order => order},
                                                  :page_size    => 'Letter',
                                                  :orientation  => 'Landscape',
                                                  :margin       => {:top    => 5,
                                                                    :bottom => 5,
                                                                    :left   => 5,
                                                                    :right  => 5}
                                                  ))

    OrdersMailer.recent(order, pdf).deliver
  end
end