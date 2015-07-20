class VegetablesController < ApplicationController

  def index
    # Vegetables --> Vegetable, mode name should be singular
    @vegetables = Vegetable.all   
  end

  def show
    @vegetable = Vegetable.find(params[:id])
  end

  def new
    @vegetable = Vegetable.new
  end

  def create
    @vegetable = Vegetable.new(whitelisted_vegetable_params)
    if @vegetable.save
      flash[:success] = "That sounds like a tasty vegetable!"
      redirect_to @vegetable
    # end
    # redirect_to :new
    # Instead of redirecting, render the new view in case we need to 
    # prepopulate the previous input
    else
      flash.now[:error] = "Error occured"
      render :new
    end
  end

  def edit
    # whitelisted_vegetable_params --> params[:id]
    # Find the entry by id
    @vegetable = Vegetable.find(params[:id])
  end

  def update
    # @vegetable = Vegetable.new(whitelisted_vegetable_params)
    # Instead of create a new vegetable, we should modify the 
    # existing entry
    @vegetable = Vegetable.find(params[:id])
    # Pass whitelisted_vegetable_params to @vegetable.update
    if @vegetable.update(whitelisted_vegetable_params)
      flash[:success] = "A new twist on an old favorite!"
      redirect_to @vegetable
    else
      # flash --> flash.now  
      # display flash message in the rendered view
      flash.now[:error] = "Something is rotten here..."
      render :edit
    end
  end

  def delete
    @vegetable = Vegetable.find(params[:id])
    @vegetable.destroy
    flash[:success] = "That veggie is trashed."
    # redirect_to @vegetable
    # Cannot redirect to the deleted vegetable
    # redirect to the index view instead
    redirect_to vegetables_path

  end

  private

  def whitelisted_vegetable_params
    require(:vegetable).permit(:name, :color, :rating, :latin_name)
  end

end
