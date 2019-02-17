class TrendsController < ApplicationController
  def index
    @date = params[:date]
    @date = Date.today.to_s if @date == nil
    @prev_date = get_date(@date, -1)
    @next_date = get_date(@date, 1)
    @trends = Trend.where(collected: @date)
  end

  def show
    @trend = Trend.find(params[:id])
    @prev = (@trend != Trend.first) ? @trend.id-1 : nil
    @next = (@trend != Trend.last)  ? @trend.id+1 : nil
  end

  def search
    @q = params[:q]
    @trends = (@q.blank?) ? nil : Trend.where(['label LIKE ?', "%#{@q}%"])
    @trends = (@trends != nil) ? @trends.group_by{|trend| trend.collected }.to_a.reverse : []
    @trends = Kaminari.paginate_array(@trends).page(params[:page])
  end

  private
  def get_date(date, offset)
    d = (Date.parse(date)+offset).to_s
    d = nil if Trend.find_by(collected: d) == nil
    return d
  end
end
