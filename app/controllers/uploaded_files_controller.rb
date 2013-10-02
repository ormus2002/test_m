# -*- encoding : utf-8 -*-
class UploadedFilesController < ApplicationController
  
  before_filter :find_uploaded_file, only: [:edit, :update, :destroy]

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
  end

  def update
    if @uploaded_file.update_attributes(params[:uploaded_file])
      flash[:notice] = "Файл успешно изменен."
      redirect_to uploaded_files_path
    else
      render 'edit'
    end
  end

  def destroy
    @uploaded_file.destroy
    flash[:notice] = "Файл успешно удален."
    redirect_to uploaded_files_path
  end

  private
    
    def find_uploaded_file
      @uploaded_file = UploadedFile.where(id: params[:id]).first
      render_404 unless @uploaded_file
    end
end
