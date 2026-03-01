# frozen_string_literal: true

class ExpedientesController < ApplicationController
  before_action :set_expediente, only: [:show, :edit, :update, :destroy]

  def index
    authorize Expediente
    @q = Expediente.ransack(params[:q])
    @q.sorts = "updated_at desc" if @q.sorts.empty?
    @pagy, @expedientes = pagy(
      @q.result.includes(:client, :assigned_to),
      items: 15
    )
  end

  def show
    authorize @expediente
    @deadlines = @expediente.deadlines.by_due_date
    @movements = @expediente.movements.chronological.limit(10)
    @procedural_instances = @expediente.procedural_instances.ordered.includes(procedural_acts: :deadlines)
  end

  def new
    @expediente = Expediente.new
    authorize @expediente
  end

  def create
    @expediente = Expediente.new(expediente_params)
    authorize @expediente

    if @expediente.save
      redirect_to @expediente, notice: "Expediente creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @expediente
  end

  def update
    authorize @expediente
    if @expediente.update(expediente_params)
      redirect_to @expediente, notice: "Expediente actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @expediente
    @expediente.destroy
    redirect_to expedientes_path, notice: "Expediente eliminado."
  end

  private

  def set_expediente
    @expediente = Expediente.find(params[:id])
  end

  def expediente_params
    params.require(:expediente).permit(
      :caratula, :numero_causa, :juzgado, :fuero, :jurisdiccion,
      :status, :tipo_proceso, :materia, :parte, :monto_reclamado,
      :moneda, :fecha_inicio, :descripcion, :client_id, :assigned_to_id,
      documents: []
    )
  end
end
