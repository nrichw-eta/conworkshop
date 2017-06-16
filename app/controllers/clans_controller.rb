# frozen_string_literal: true
class ClansController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def new
    @clan = Clan.new
    @clan.colour = '#99dddd'
  end

  def create
    @clan = Clan.new(clan_params)
    if @clan.save
      redirect_to @clan
    else
      render 'new'
    end
  end

  def index
    @clans = Clan.all
  end

  def join
    # HANDLE CLAN PERMISSION TYPES
    @clan = Clan.find(params[:id])
    @membership = ClanMembership.new
    @membership.user = current_user
    @memership.clan = @clan
    unless @membership.save
      flash[:error] = 'Could not join clan'
    end
    redirect_to @clan
  end

  def edit; end
  def update; end

  def show
    @clan = Clan.find(params[:id])
  end

  def render_404
    redirect_to clans_path
  end

  def destroy; end

  def clan_params
    params.require(:clan).permit(:name, :description, :permission, :symbol, :colour)
  end
end
