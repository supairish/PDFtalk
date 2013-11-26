require 'spec_helper'

describe OrdersController do
  before do
    @orders = [].tap do |orders|
      10.times do
        orders << Order.create(title: Faker::Name.name, total: rand(1000).to_s)
      end
    end
  end

  describe 'Index PDF headers & templates' do
    render_views

    let(:filename){ "Orders-for-#{Time.zone.now.strftime("%m-%d-%Y")}.pdf" }

    it "should render the home page template in the application layout" do
      get :index, format: 'pdf'

      expect(response).to render_template('orders/index')
      expect(response).to render_template(layout: "print.html")
    end

    it "should render with the correct headers" do
      get :index, format: 'pdf'

      expect(response.content_type).to eq("application/pdf")
      expect(response.headers["Content-Disposition"]).to eq("attachment; filename=\"#{filename}\"")
    end

  end

  describe "Index PDF content" do
    render_views

    it "should have a table header and the correct table contents" do
      get :index, format: 'pdf', debug: '1'

      page = Capybara::Node::Simple.new(response.body)

      expect(page).to have_selector("thead th", text: 'Title')
      expect(page).to have_selector("thead th", text: 'Total')
      expect(page).to have_selector("tbody tr", count: 10 )

      @orders.each do |order|
        expect(page).to have_selector("td", text: order.title)
      end
    end
  end
end