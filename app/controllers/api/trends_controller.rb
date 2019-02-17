class Api::TrendsController < ApplicationController
  def index
    render json: Trend.where(collected: params[:date])
  end

  def show
    l = []
    @trend = Trend.find(params[:id])
    l.push(@trend.nodes)
    @trend.nodes.each {|n|
      l.push(n.links)
    }
    render json: l
  end
end
