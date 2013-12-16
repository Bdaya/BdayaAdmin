GOOGLE_AUTH_URI = "https://accounts.google.com/o/oauth2/auth"
GOOGLE_CLIENT_SECRET = "mrmyoC__YHZO1rCgL-4TFpL4"
GOOGLE_TOKEN_URI  = "https://accounts.google.com/o/oauth2/token"
GOOGLE_CLIENT_EMAIL = "899337032209@developer.gserviceaccount.com"
GOOGLE_CLIENT_ID = "899337032209-ofg2hhipfe2a169ea8g8hk97tgkp3j96.apps.googleusercontent.com"
GOOGLE_REDIRECT_URI = "http://bdayasystem.herokuapp.com/oauth2callback"
GOOGLE_SCOPES = "https://docs.google.com/feeds/ " + "https://docs.googleusercontent.com/ " + "https://spreadsheets.google.com/feeds/"
GOOGLE_CLIENT = OAuth2::Client.new(
    GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET,
    site: "https://accounts.google.com",
    token_url: "/o/oauth2/token",
    authorize_url: "/o/oauth2/auth")