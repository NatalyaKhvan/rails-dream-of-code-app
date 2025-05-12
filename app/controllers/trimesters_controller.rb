class TrimestersController < ApplicationController
    before_action :require_admin, only: [:create, :update, :destroy]

    def index
        @trimesters = Trimester.all
    end

    def show
        @trimester = Trimester.find(params[:id])
    end

    def edit
        @trimester = Trimester.find(params[:id])
    end
  
    def update
        @trimester = Trimester.find(params[:id])
    
        if @trimester.update(trimester_params)
          redirect_to trimester_path(@trimester), notice: 'Trimester updated successfully.'
        else
          redirect_to edit_trimester_path(@trimester), alert: 'Please correct the errors and submit again.'
        end
    end

    private

    def trimester_params
        params.require(:trimester).permit(:application_deadline)
    end
end
  