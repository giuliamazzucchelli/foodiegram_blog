class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        if resource.class == Admin
            rails_admin.dashboard_path
        end

   end
end
