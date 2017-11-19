class ProfileController < ApplicationController
    before_action :authenticate_user!
    def index
        render json: {
            dept: @current_user.outstanding_money,
            balance: @current_user.balance,
            receiving_money: @current_user.receiving_money
        }
    end
end
