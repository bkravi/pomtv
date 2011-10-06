require 'spec_helper'

describe "install_books/index.html.erb" do
  before(:each) do
    assign(:install_books, [
      stub_model(InstallBook,
        :cust_inf_id => 1,
        :CustId => 1,
        :GSK_No => 1,
        :GSK_Pin => 1,
        :RCV_No => 1,
        :RCV_Pin => 1
      ),
      stub_model(InstallBook,
        :cust_inf_id => 1,
        :CustId => 1,
        :GSK_No => 1,
        :GSK_Pin => 1,
        :RCV_No => 1,
        :RCV_Pin => 1
      )
    ])
  end

  it "renders a list of install_books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
