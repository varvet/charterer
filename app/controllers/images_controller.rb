class ImagesController < ApplicationController

  before_action :authenticate_user!

  def index
    # @image = current_user.first_image || current_user.get_more_images(request.remote_ip)
    @image = current_user.first_image || current_user.get_more_images("83.241.129.195")
  end

  def update
    @image = Image.find(params[:id])

    if current_user.tag(@image, with: permitted_params[:image][:tag_list], on: :tags)
      @image = current_user.first_image || current_user.get_more_images("83.241.129.195", current_user.last_image)
    end

    respond_to do |format|
      format.json { render json: @image }
    end
  end

  protected

  def permitted_params
    params.permit(image: [
      :tag_list
    ])
  end

end
