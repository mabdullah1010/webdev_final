class DocumentsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  #def index
  #  @documents = Document.where(user: User.first)  # TEMP: replace with current_user
  #end

  def index
    @documents = Document.all
  
    if params[:keyword].present?
      @documents = @documents.where("keywords LIKE ?", "%#{params[:keyword]}%")
    end
  
    if params[:category].present?
      @documents = @documents.where(category: params[:category])
    end
  end
  
  

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user = User.first  # TEMPORARY: replace with current_user
    if @document.save
      redirect_to @document, notice: "Document uploaded successfully."
    else
      render :new
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def edit
  end

  def update
    if params[:document][:file].present?
      @document.file.purge if @document.file.attached?  # remove old file
    end
  
    if @document.update(document_params)
      redirect_to @document, notice: "Document updated"
    else
      render :edit
    end
  end
  
  def destroy
    @document.destroy
    redirect_to documents_path, notice: "Document deleted"
  end

  private

  def document_params
    params.require(:document).permit(:title, :category, :keywords, :file)

  end


  def set_document
    @document = Document.find(params[:id])  # TEMP: current_user.documents.find(...)
  end
end
