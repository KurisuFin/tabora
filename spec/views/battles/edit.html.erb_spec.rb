require 'spec_helper'

describe "battles/edit" do
  before(:each) do
    @battle = assign(:battle, stub_model(Battle,
      :name => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit battle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", battle_path(@battle), "post" do
      assert_select "input#battle_name[name=?]", "battle[name]"
      assert_select "input#battle_state[name=?]", "battle[state]"
    end
  end
end
