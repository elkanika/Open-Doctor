# frozen_string_literal: true

class DeadlinesController < ApplicationController
  before_action :set_deadline, only: [:edit, :update, :destroy, :mark_completed, :mark_expired]

  def calendar
    authorize Deadline, :index?
    # Simple Calendar uses the start_date param automatically
    start_date = params.fetch(:start_date, Date.current).to_date
    
    # Base scope for the calendar
    base = Deadline.includes(:expediente)
    
    # We load all deadlines from the beginning of the month's week to the end
    @deadlines = base.where(due_on: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def index
    authorize Deadline
    @q = Deadline.ransack(params[:q])
    @q.sorts = "due_on asc" if @q.sorts.empty?
    @pagy, @deadlines = pagy(
      @q.result.includes(:expediente),
      items: 20
    )

    # Filtros predefinidos
    @filter = params[:filter]
    base = Deadline.includes(:expediente)
    @deadlines_scope = case @filter
                       when "propios" then base.propios.pendientes
                       when "contraria" then base.de_contraria.pendientes
                       when "vencidos" then base.vencidos
                       when "urgentes" then base.urgentes.pendientes
                       when "proximos" then base.proximos(7)
                       else base
                       end

    if @filter.present?
      @pagy, @deadlines = pagy(@deadlines_scope.by_due_date, items: 20)
    end
  end

  def new
    @deadline = Deadline.new(expediente_id: params[:expediente_id])
    authorize @deadline
  end

  def create
    @deadline = Deadline.new(deadline_params)
    authorize @deadline

    if @deadline.save
      redirect_to @deadline.expediente, notice: "Plazo creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @deadline
  end

  def update
    authorize @deadline
    if @deadline.update(deadline_params)
      redirect_to @deadline.expediente, notice: "Plazo actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @deadline
    expediente = @deadline.expediente
    @deadline.destroy
    redirect_to expediente, notice: "Plazo eliminado."
  end

  def mark_completed
    authorize @deadline
    @deadline.update!(status: :cumplido, completed_on: Date.current)
    redirect_back fallback_location: deadlines_path, notice: "Plazo marcado como cumplido."
  end

  def mark_expired
    authorize @deadline
    @deadline.update!(status: :vencido)
    redirect_back fallback_location: deadlines_path, notice: "Plazo marcado como vencido."
  end

  private

  def set_deadline
    @deadline = Deadline.find(params[:id])
  end

  def deadline_params
    params.require(:deadline).permit(
      :title, :description, :party, :starts_on, :due_on, :completed_on,
      :days_count, :business_days, :status, :alert_days_before,
      :depends_on_event, :event_occurred, :event_date, :priority,
      :expediente_id, :procedural_act_id, :parent_deadline_id
    )
  end
end
