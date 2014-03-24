require 'spec_helper'

describe "acts/new" do
  before(:each) do
    assign(:act, stub_model(Act,
      :user_id => 1,
      :battle_id => 1
    ).as_new_record)
  end

  it "renders new act form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", acts_path, "post" do
      assert_select "input#act_user_id[name=?]", "act[user_id]"
      assert_select "input#act_battle_id[name=?]", "act[battle_id]"
    end
  end
end
