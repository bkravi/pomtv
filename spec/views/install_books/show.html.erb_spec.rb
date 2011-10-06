require 'spec_helper'

describe "install_books/show.html.erb" do
  before(:each) do
    @install_book = assign(:install_book, stub_model(InstallBook,
      :cust_inf_id => 1,
      :CustId => 1,
      :GSK_No => 1,
      :GSK_Pin => 1,
      :RCV_No => 1,
      :RCV_Pin => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
