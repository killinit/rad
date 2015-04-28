class Admin::AdvisersController < Admin::ApplicationController
  def index
    @search = Adviser.ransack(params[:q])

    @advisers = @search.result
    @advisers = @advisers.where(firm_id: firm) if firm
    @advisers = @advisers.page(params[:page]).per(20)
  end

  def show
    @adviser = adviser
  end

  def edit
    @adviser = adviser
  end

  def update
    @adviser = adviser

    if @adviser.update(adviser_params)
      redirect_to admin_adviser_path(@adviser)
    else
      render 'edit'
    end
  end

  private

  def firm
    @firm ||= Firm.find(params[:firm_id]) if params[:firm_id]
  end
  helper_method :firm

  def adviser
    Adviser.find(params[:id])
  end

  def adviser_params
    params.require(:adviser).permit(:postcode)
  end
end
