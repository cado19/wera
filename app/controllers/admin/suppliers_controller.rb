class Admin::SuppliersController < Admin::BaseController
  layout "admin"
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
    @search = Supplier.search(params[:q])
    @suppliers = @search.result.paginate(page: params[:page], per_page: 10)
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to admin_supplier_url(@supplier), notice: 'Supplier was successfully created.' }
        format.json { render :show, status: :created, location: admin_supplier(@supplier) }
      else
        format.html { render :new }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to admin_supplier_url(@supplier), notice: 'Supplier was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_supplier(@supplier) }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.update_attributes(:deleted, true)
    respond_to do |format|
      format.html { redirect_to admin_suppliers_url, notice: 'Supplier successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:name, :telephone, :email)
    end
end
