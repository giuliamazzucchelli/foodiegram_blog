class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters,
    if: :devise_controller?
        protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up,keys: [:avatar,:username,:bio])
            devise_parameter_sanitizer.permit(:account_update,keys: [:avatar,:username,:bio])
        end

        def after_sign_in_path_for(resource)
            if resource.class == Admin
                rails_admin.dashboard_path
            elsif resource.class == User 
                user_path(current_user)
            end
        end

end
