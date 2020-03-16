class Application < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    @deposit = DepositCalculator.new(params[:amount].to_i,
                                     params[:rate].to_i,
                                     Date.parse(params[:start_date]),
                                     params[:term_type],
                                     params[:term_length].to_i,
                                     params[:inflation_rate].to_f)

    erb :index
  end
end

























