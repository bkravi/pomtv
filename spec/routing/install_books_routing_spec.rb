require "spec_helper"

describe InstallBooksController do
  describe "routing" do

    it "routes to #index" do
      get("/install_books").should route_to("install_books#index")
    end

    it "routes to #new" do
      get("/install_books/new").should route_to("install_books#new")
    end

    it "routes to #show" do
      get("/install_books/1").should route_to("install_books#show", :id => "1")
    end

    it "routes to #edit" do
      get("/install_books/1/edit").should route_to("install_books#edit", :id => "1")
    end

    it "routes to #create" do
      post("/install_books").should route_to("install_books#create")
    end

    it "routes to #update" do
      put("/install_books/1").should route_to("install_books#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/install_books/1").should route_to("install_books#destroy", :id => "1")
    end

  end
end
