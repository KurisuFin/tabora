require 'spec_helper'

describe "participations/edit" do
  before(:each) do
    @participation = assign(:participation, stub_model(Participation,
      :user_id => 1,
      :tournament_id => 1
    ))
  end

  it "renders the edit participation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", participation_path(@participation), "post" do
      assert_select "input#participation_user_id[name=?]", "participation[user_id]"
      assert_select "input#participation_tournament_id[name=?]", "participation[tournament_id]"
    end
  end
end
