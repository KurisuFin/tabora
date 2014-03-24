require 'spec_helper'

describe "battles/index" do
  before(:each) do
    assign(:battles, [
      stub_model(Battle,
        :name => "Name",
        :state => "State"
      ),
      stub_model(Battle,
        :name => "Name",
        :state => "State"
      )
    ])
  end

  it "renders a list of battles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
