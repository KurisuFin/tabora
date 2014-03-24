require 'spec_helper'

describe "acts/edit" do
  before(:each) do
    @act = assign(:act, stub_model(Act,
      :user_id => 1,
      :battle_id => 1
    ))
  end

  it "renders the edit act form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", act_path(@act), "post" do
      assert_select "input#act_user_id[name=?]", "act[user_id]"
      assert_select "input#act_battle_id[name=?]", "act[battle_id]"
    end
  end
end
