class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  # GET /records
  # GET /records.json
  def index
    @records = Record.all
    @records_rooms = Record.where(label: "P")
    @rec_kino_total = Record.where(label: "K").count
    @rec_bunker_total = Record.where(label: "B").count
    @rec_par13_total = Record.where(label: "P").count
    @rec_total_games = @rec_kino_total + @rec_bunker_total + @rec_par13_total
    @rec_kino_by_month = Record.where(label: "K").group_by_month(:datetime)
    @rec_bunker_by_month = Record.where(label: "B").group_by_month(:datetime)
    @rec_par13_by_month = Record.where(label: "P").group_by_month(:datetime)
    @profit_by_month = Record.where(label: "D").group_by_month(:datetime, "sum", "summa")
    @costs_by_month = Record.where(label: "RT").group_by_month(:datetime, "sum", "summa")
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @record }
      else
        format.html { render action: 'new' }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end

  def import
    Record.import(params[:file])
    redirect_to records_path, notice: "Records added successfully"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:datetime, :summa, :desc, :data, :time, :label, :status)
    end
end
