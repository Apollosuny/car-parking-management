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

  def monthly_revenue
    # Fetch booking totals grouped by year and month
    current_year = Date.today.year
    previous_year = current_year - 1

    # Fetch booking totals grouped by year and month
    bookings_current_year = Booking.includes(:payment)
                                   .where(startTime: (Date.new(current_year, 1, 1)..Date.new(current_year, 12, 31)))
                                   .group_by_month(:startTime, format: "%Y-%m").sum("payments.totalPrice")
    
    bookings_previous_year = Booking.includes(:payment)
                                    .where(startTime: (Date.new(previous_year, 1, 1)..Date.new(previous_year, 12, 31)))
                                    .group_by_month(:startTime, format: "%Y-%m").sum("payments.totalPrice")

    # Generate labels for all months of current and previous year
    all_months = (Date.today.beginning_of_year..Date.today.end_of_year).map { |date| date.strftime("%Y-%m") }

    data_current_year = all_months.map do |month|
      {
        month: month,
        revenue: bookings_current_year[month] || 0
      }
    end

    data_previous_year = all_months.map do |month|
      {
        month: month,
        revenue: bookings_previous_year[month] || 0
      }
    end

    render json: {
      current_year: data_current_year,
      previous_year: data_previous_year
    }
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
