class UploadsController < ApplicationController
  before_filter do
    unless current_admin_user
      respond_to do |format|
        format.html {redirect_to :root}
        format.json {render :nothing}
      end
    end
  end
  # TODO: finish testing need to figure out paperclip upload
  def index
    @uploads = Upload.all
    @upload = Upload.new
  end

  # POST /uploads
  # POST /uploads.xml
  # FIXME: for some reason it refuses to render partial uploads/upload though the partial is used elsewhere
  def create
    newparams = coerce(params)
    @upload = Upload.new(newparams[:upload])
    if @upload.save
      flash[:notice] = "Successfully created upload."
      respond_to do |format|
        format.html {redirect_to index}
        format.json {render :json => { :result => 'success', :upload => @upload.image.url } }
      end
    else
      render :action => 'new'
    end
   end
   
  # TODO: have a delete eventually incase uploads are canceled
  
  private 
  def coerce(params)
    if params[:upload].nil? 
      h = Hash.new 
      h[:upload] = Hash.new 
      h[:upload][:image] = params[:Filedata] 
      h[:upload][:image].content_type = MIME::Types.type_for(h[:upload][:image].original_filename).to_s
      h
    else 
      params
    end 
  end
end
