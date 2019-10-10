class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @recipes = Recipe.where("title LIKE ?", "%#{params[:title]}%")
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
  
  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      # flash.now[:alert] = "tesasdaodiasdo"
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :new
    end        
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash[:notice] = "Você deve informar todos os dados da receita"
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    render :edit
    end
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :cook_method, :ingredients)
  end
end