Rails.application.config.session_store :cookie_store, key: '_bluelry_session', domain: :all, tld_length: 2, secure: Rails.env.production?

