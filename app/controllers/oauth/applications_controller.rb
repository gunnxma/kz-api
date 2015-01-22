class Oauth::ApplicationsController < ApplicationController
    before_filter :set_application, only: [:show, :edit, :update, :destroy]
    layout "nohead"

    def index
      @applications = OauthApplication.all
    end

    def new
      @application = OauthApplication.new
    end

    def create
      @application = OauthApplication.new(application_params)
      @application.uid = SecureRandom.hex
      @application.secret = SecureRandom.hex
      if @application.save
        flash[:notice] = '添加应用成功'
        redirect_to @application
      else
        render :new
      end
    end

    def update
      if @application.update_attributes(application_params)
        flash[:notice] = '修改应用成功'
        redirect_to @application
      else
        render :edit
      end
    end

    def destroy
      flash[:notice] = '删除应用成功' if @application.destroy
      redirect_to :action => :index
    end

    private

    def set_application
      @application = OauthApplication.find(params[:id])
    end

    def application_params
      if params.respond_to?(:permit)
        params.require(:oauth_application).permit(:name, :unit_id, :redirect_uri)
      else
        params[:oauth_application].slice(:name, :unit_id, :redirect_uri) rescue nil
      end
    end
end
