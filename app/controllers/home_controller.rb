class HomeController < ApplicationController
  def index
    @parking_slots = ParkingSlot.where(:status => true)
    @vehicles = Vehicle.where(:user_id => current_user.id)
    @bookings = Booking.where(:user_id => current_user.id)
    @totalPayment = 0
    @bookings.each do |booking|
      @totalPayment += booking.payment.totalPrice
    end
  end

  def chart_data
    # Assuming you have a 'Booking' model
    @bookings = Booking.where(:user_id => current_user.id)
  
    # Initialize a hash to store the counts by date
    @bookings_by_date = Hash.new(0)

    # Group bookings by date
    @bookings.each do |booking|
      date = booking.created_at.to_date
      @bookings_by_date[date] += 1
    end

    # Convert data to JSON format for ApexCharts
    @chart_data = @bookings_by_date.map { |date, count| { date: date.strftime("%Y-%m-%d"), count: count } }

    render json: @chart_data
  end

  def parking_data
    parking_data = Booking.joins(:payment)
                          .where(bookings: { created_at: 1.week.ago.beginning_of_week..Time.current })
                          .group_by_day('bookings.created_at', format: "%A")
                          .sum('payments.totalTime')

    days_of_week = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]

    complete_data = days_of_week.map do |day|
      {
        day: day,
        total_time: parking_data[day] || 0
      }
    end

    render json: {
      categories: complete_data.map { |data| data[:day] },
      data: complete_data.map { |data| data[:total_time] }
    }
  end
end
