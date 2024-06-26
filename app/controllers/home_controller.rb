class HomeController < ApplicationController
  def index
    @parking_slots = ParkingSlot.where(:status => true)
    @vehicles = Vehicle.where(:user_id => current_user.id)
    @bookings = Booking.where(:user_id => current_user.id)
    @totalPayment = 0
    @bookings.each do |booking|
      @totalPayment += booking.payment.totalPrice
    end
    @allUsers = User.where(role: 'user')
    @activeUsers = User.where(role: 'user', status: true)
    @availableParkingSlots = ParkingSlot.where(:status => true)
    @bookedToday = Booking.where(startTime: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @allVehicles = Vehicle.all
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

  def booked_per_day
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week

    # Fetch booking counts grouped by day
    bookings = Booking.where(startTime: start_date..end_date)
                      .group_by_day(:startTime)
                      .count

    # Ensure all days of the week are included
    data = (start_date..end_date).map do |date|
      {
        date: date,
        count: bookings[date] || 0
      }
    end

    render json: data
  end

  def revenue_data_for_last_7_days
    data = (0..6).map do |i|
      day = i.days.ago.to_date
      revenue = Booking.joins(:payment)
                       .where(created_at: day.beginning_of_day..day.end_of_day)
                       .sum('payments.totalPrice')
      { date: day.strftime('%A'), revenue: revenue }
    end
    render json: data
  end

  def vehicle_model_distribution
    vehicle_model_distribution = Vehicle.joins(:vehicle_model)
                                          .group('vehicle_models.brand')
                                          .count
                                          .map { |model, count| { name: model, data: count } }
    render json: vehicle_model_distribution
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
