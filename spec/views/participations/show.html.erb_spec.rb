require 'spec_helper'

describe "participations/show" do
  before(:each) do
    @participation = assign(:participation, stub_model(Participation,
      :user_id => 1,
      :tournament_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
