class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[my_recipes new create edit update]
  before_action :recipe_dependencies, only: %i[new edit]
  before_action :set_recipe, only: %i[edit update]
  before_action :own_recipe?, only: %i[edit update]

  def index
    @recipes = Recipe.where("title LIKE ?", "%#{params[:title]}%")
  end

  def my_recipes
    @recipes = current_user.recipes
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
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
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :cook_method,
                                   :ingredients)
  end

  def recipe_dependencies
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def own_recipe?
    redirect_to root_path unless @recipe.user == current_user
  end
end