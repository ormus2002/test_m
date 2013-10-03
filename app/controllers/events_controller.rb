# -*- encoding : utf-8 -*-
class EventsController < ApplicationController
  before_filter :find_event, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
    @events_by_date = @events.group_by(&:published_on)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, notice: "Событие создано."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: "Событие успешно обновлено."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Событие успешно удалено."
    redirect_to events_path
  end

  private

    def find_event
      @event = Event.where(id: params[:id]).first
      render_404 unless @event
    end
end
