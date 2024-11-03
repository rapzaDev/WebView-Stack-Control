enum webviewURLs {
  cvcrm,
  google,
  youtube,
  spotify;

  String get url => switch (this) {
        cvcrm => "https://cvcrm.com.br",
        google => "https://www.google.com",
        youtube => "https://www.youtube.com",
        spotify => "https://www.spotify.com",
      };

  String get name => switch (this) {
        cvcrm => "CV CRM",
        google => "Google",
        youtube => "Youtube",
        spotify => "Spotify",
      };

  String get img => switch (this) {
        cvcrm => "assets/images/cvcrm_logo.png",
        google => "assets/images/google_logo.png",
        youtube => "assets/images/youtube_logo.png",
        spotify => "assets/images/spotify_logo.png",
      };
}
