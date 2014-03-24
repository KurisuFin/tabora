require 'spec_helper'

describe "acts/show" do
  before(:each) do
    @act = assign(:act, stub_model(Act,
      :user_id => 1,
      :battle_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
