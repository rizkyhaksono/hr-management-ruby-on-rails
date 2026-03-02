class SearchController < ApplicationController
  def index
    @query = params[:q].to_s.strip
    return render(plain: "") if @query.length < 2

    @employees = Employee.search(@query).limit(5)
    @leaves = Leave.includes(:employee).joins(:employee)
      .where("employees.first_name LIKE :q OR employees.last_name LIKE :q OR leaves.reason LIKE :q", q: "%#{@query}%")
      .limit(5)
    @attendances = Attendance.includes(:employee).joins(:employee)
      .where("employees.first_name LIKE :q OR employees.last_name LIKE :q", q: "%#{@query}%")
      .limit(5)

    render layout: false
  end
end
