class Thumbnail {
  /// The class for the thumbnails in home screen
  ///
  /// Contains a url to the document, as well as a path to the thumbnail asset
  String documentUrl, assetPath;
  Thumbnail(this.documentUrl, this.assetPath);
}

final thumbnailList = [
  Thumbnail('https://pdftron.s3.amazonaws.com/downloads/pl/PDFTRON_about.pdf',
      'assets/pdftron-about-cover.png'),
  Thumbnail(
      'https://pdftron.s3.amazonaws.com/custom/ID-zJWLuhTffd3c/sgong/getting_started.pdf',
      'assets/getting-started-cover.png'),
  Thumbnail('http://www.africau.edu/images/default/sample.pdf',
      'assets/simple-cover.png'),
  Thumbnail('https://www.hq.nasa.gov/alsj/a17/A17_FlightPlan.pdf',
      'assets/large-cover.png'),
  Thumbnail(
      'https://ocw.mit.edu/courses/mathematics/18-821-project-laboratory-in-mathematics-spring-2013/writing/MIT18_821S13_latexsample.pdf',
      'assets/math-cover.png'),
  Thumbnail('https://planetpdf.com/planetpdf/pdfs/jpn.pdf',
      'assets/japanese-cover.png'),
  Thumbnail(
      'https://www.irs.gov/pub/irs-pdf/f1040.pdf', 'assets/form-cover.png')
];
