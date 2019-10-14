class CuisinesController < ApplicationController
    # validates :name, :description, presence: true

    def index
        @cuisines = Cuisine.all
    end

    def new
        @cuisine = Cuisine.new
    end

    def create
        @cuisine = Cuisine.new(params.require(:cuisine)
                               .permit(:name, :description))

        if @cuisine.save()
            redirect_to @cuisine
        else
            render :new
        end
    end

    def show
        @cuisine = Cuisine.find(params[:id])
    end

    def edit
        @cuisine = Cuisine.find(params[:id])
    end

    def update
        @cuisine = Cuisine.find(params[:id])

        if @cuisine.update(params.require(:cuisine).permit(:name, :description))
            redirect_to @cuisine
        else
            render :edit
        end
    end
end