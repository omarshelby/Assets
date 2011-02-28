class AssetsController < ApplicationController

  before_filter :login_required, :except => [:index, :show]
  
  def index

    @assets = Asset.paginate  :page => params[:page], :order => 'created_at ASC'
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      flash[:notice] = "Successfully created asset."
      redirect_to assets_url
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def update
    @asset = Asset.find(params[:id])
    if @asset.update_attributes(params[:asset])
      flash[:notice] = "Your asset is successfully updated!"
      redirect_to assets_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    flash[:notice] = "Your asset is successfully removed!."
    redirect_to assets_url
  end
end
