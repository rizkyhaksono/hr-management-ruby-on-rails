module Paginatable
  extend ActiveSupport::Concern

  PER_PAGE = 20

  class_methods do
    def page_records(page = nil)
      page = (page || 1).to_i
      page = 1 if page < 1
      offset((page - 1) * PER_PAGE).limit(PER_PAGE)
    end
  end
end
