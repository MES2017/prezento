include OwnershipAuthentication
include ComunsMethods

class KalibroConfigurationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :kalibro_configuration_owner?, only: [:edit, :update, :destroy]
  before_action :set_kalibro_configuration, only: [:show, :edit, :update, :destroy]

  # GET /kalibro_configurations/new
  def new
    @kalibro_configuration = KalibroConfiguration.new
  end

  # GET /kalibro_configurations
  # GET /kalibro_configurations.json
  def index
    @kalibro_configurations = KalibroConfiguration.public_or_owned_by_user(current_user)
  end

  # POST /kalibro_configurations
  # POST /kalibro_configurations.json
  def create
    @kalibro_configuration = KalibroConfiguration.new(kalibro_configuration_params)
    respond_to do |format|
      create_and_redir(format, @kalibro_configuration, 'kalibro_configuration')
    end
  end

  # GET /kalibro_configurations/1
  # GET /kalibro_configurations/1.json
  def show
    Rails.cache.fetch("#{@kalibro_configuration.id}_tree_metric_configurations") do
      @kalibro_configuration.tree_metric_configurations
    end
    Rails.cache.fetch("#{@kalibro_configuration.id}_hotspot_metric_configurations") do
      @kalibro_configuration.hotspot_metric_configurations
    end
  end

  # GET /kalibro_configurations/1/edit
  # GET /kalibro_configurations/1/edit.json
  def edit; end

  def update
    if @kalibro_configuration.update(kalibro_configuration_params)
      redirect_to(kalibro_configuration_path(@kalibro_configuration.id))
    else
      render "edit"
    end
  end

  # DELETE /kalibro_configurations/1
  # DELETE /kalibro_configurations/1.json
  def destroy
    @kalibro_configuration.destroy

    respond_to do |format|
      format.html { redirect_to kalibro_configurations_path }
      format.json { head :no_content }
    end

    Rails.cache.delete("#{@kalibro_configuration.id}_metrics")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_kalibro_configuration
    @kalibro_configuration = KalibroConfiguration.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def kalibro_configuration_params
    params[:kalibro_configuration][:name].strip!
    params[:kalibro_configuration]
  end
end
