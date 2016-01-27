Rails.application.routes.draw do
resources :cats

resources :cat_rental_requests

patch "/cat_rental_requests/:id/approve", to: "cat_rental_requests#approve!", as: "cat_rental_request_approve"
patch "/cat_rental_requests/:id/deny", to: "cat_rental_requests#deny!", as: "cat_rental_request_deny"

end
