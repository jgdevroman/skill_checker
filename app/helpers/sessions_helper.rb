module SessionsHelper
    # Log in the given user
    def log_in(user)
        session[:user_id] = user.id
    end

    # Returns the current logged-in user
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    # Checks if the given user is the logged-in user
    def current_user?(user)
        current_user == user
    end

    # Checks if a user is logged in 
    def logged_in
        !current_user.nil?
    end

    #logs the current user out
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    #Redirects to stored location
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    #Stores the URL trying to be accessed
    def store_location
        session.delete(:forwarding_url) if[:forwarding_url].any?
        session[:forwarding_url] = request.original_url if request.get?
    end


end
