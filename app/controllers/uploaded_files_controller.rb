class UploadedFilesController < ApplicationController


  def index
    @uploaded_files = UploadedFile.desc.paginate(page: params[:page])
  end

  def show
    @uploaded_file = UploadedFile.find(params[:id])
  end

  def new
    @uploaded_file = UploadedFile.new
  end

  def create
    params[:uploaded_file].merge!(user_id: current_user.id)
    @uploaded_file = UploadedFile.create(params[:uploaded_file])

  end

  def edit
    @uploaded_file = UploadedFile.find(params[:id])
  end


end
