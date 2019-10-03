class CuisinesController < ApplicationController
    # validates :name, :description, presence: true

    def index
        
    end

    def new
        @cuisine = Cuisine.new
    end

    def create
        @cuisine = Cuisine.new(params.require(:cuisine).permit(:name, :description))

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
        
    end

    def update
        
    end
end