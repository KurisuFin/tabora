require 'spec_helper'

describe "battles/new" do
  before(:each) do
    assign(:battle, stub_model(Battle,
      :name => "MyString",
      :state => "MyString"
    ).as_new_record)
  end

  it "renders new battle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", battles_path, "post" do
      assert_select "input#battle_name[name=?]", "battle[name]"
      assert_select "input#battle_state[name=?]", "battle[state]"
    end
  end
end
