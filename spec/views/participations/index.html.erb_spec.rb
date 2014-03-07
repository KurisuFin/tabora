require 'spec_helper'

describe "participations/index" do
  before(:each) do
    assign(:participations, [
      stub_model(Participation,
        :user_id => 1,
        :tournament_id => 2
      ),
      stub_model(Participation,
        :user_id => 1,
        :tournament_id => 2
      )
    ])
  end

  it "renders a list of participations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
