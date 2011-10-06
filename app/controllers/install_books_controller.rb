class InstallBooksController < ApplicationController
  # GET /install_books
  # GET /install_books.xml
  def index
    @install_books = InstallBook.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @install_books }
    end
  end

  # GET /install_books/1
  # GET /install_books/1.xml
  def show
    @install_book = InstallBook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @install_book }
    end
  end

  # GET /install_books/new
  # GET /install_books/new.xml
  def new
    @install_book = InstallBook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @install_book }
    end
  end

  # GET /install_books/1/edit
  def edit
    @install_book = InstallBook.find(params[:id])
  end

  # POST /install_books
  # POST /install_books.xml
  def create
    @install_book = InstallBook.new(params[:install_book])

    respond_to do |format|
      if @install_book.save
        format.html { redirect_to(@install_book, :notice => 'Install book was successfully created.') }
        format.xml  { render :xml => @install_book, :status => :created, :location => @install_book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @install_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /install_books/1
  # PUT /install_books/1.xml
  def update
    @install_book = InstallBook.find(params[:id])

    respond_to do |format|
      if @install_book.update_attributes(params[:install_book])
        format.html { redirect_to(@install_book, :notice => 'Install book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @install_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /install_books/1
  # DELETE /install_books/1.xml
  def destroy
    @install_book = InstallBook.find(params[:id])
    @install_book.destroy

    respond_to do |format|
      format.html { redirect_to(install_books_url) }
      format.xml  { head :ok }
    end
  end
end
