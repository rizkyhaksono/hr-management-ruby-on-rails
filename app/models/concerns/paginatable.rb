module Paginatable
  extend ActiveSupport::Concern

  PER_PAGE = 15

  class_methods do
    def page_records(page = nil)
      page = (page || 1).to_i
      page = 1 if page < 1
      offset((page - 1) * PER_PAGE).limit(PER_PAGE)
    end

    def total_pages(scope = nil)
      count = scope ? scope.count : count()
      count = count.length if count.is_a?(Hash)
      (count.to_f / PER_PAGE).ceil
    end
  end
end
