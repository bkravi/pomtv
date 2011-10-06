require 'spec_helper'

describe "install_books/new.html.erb" do
  before(:each) do
    assign(:install_book, stub_model(InstallBook,
      :cust_inf_id => 1,
      :CustId => 1,
      :GSK_No => 1,
      :GSK_Pin => 1,
      :RCV_No => 1,
      :RCV_Pin => 1
    ).as_new_record)
  end

  it "renders new install_book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => install_books_path, :method => "post" do
      assert_select "input#install_book_cust_inf_id", :name => "install_book[cust_inf_id]"
      assert_select "input#install_book_CustId", :name => "install_book[CustId]"
      assert_select "input#install_book_GSK_No", :name => "install_book[GSK_No]"
      assert_select "input#install_book_GSK_Pin", :name => "install_book[GSK_Pin]"
      assert_select "input#install_book_RCV_No", :name => "install_book[RCV_No]"
      assert_select "input#install_book_RCV_Pin", :name => "install_book[RCV_Pin]"
    end
  end
end
