# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: {in: ["PENDING", "DENIED", "APPROVED"],
    message: "%{value} not permitted" }
  validate :request_cannot_overlap

  def overlapping_requests # returns array of overlapping requests
    same_cat_requests = CatRentalRequest.where(cat_id: self.cat_id)
    self_range = start_date..end_date
    same_cat_requests.select do |request|
      request_range = request.start_date..request.end_date
      self_range.include?(request.start_date) || self_range.include?(request.end_date) ||
      request_range.include?(self.start_date) || request_range.include?(self.end_date)
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select do |request|
      request.status == "APPROVED"
    end
  end

  def overlapping_pending_requests
    overlapping_requests.select do |request|
      request.status == "PENDING"
    end
  end

  def request_cannot_overlap
    unless overlapping_approved_requests.empty?
      errors.add(:base, "is invalid")
    end
  end

  def approve!
    self.update!(status: "APPROVED")
    overlapping_pending_requests.update_all(status: "DENIED")
  end

  def deny!
    self.update!(status: "DENIED")
  end

end
