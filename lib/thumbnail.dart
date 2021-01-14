class Thumbnail {
  /// The class for the thumbnails in home screen
  ///
  /// Contains a url to the document, as well as a path to the thumbnail asset
  String documentUrl, assetPath;
  Thumbnail(this.documentUrl, this.assetPath);
}

final thumbnailList = [
  Thumbnail('https://www.pdftron.com/webviewer/demo/gallery/PDFTRON_about.pdf',
      'assets/file-covers/about-cover.png'),
  Thumbnail('https://www.pdftron.com/webviewer/demo/gallery/Report_2011.pdf',
      'assets/file-covers/report-cover.png'),
  Thumbnail('https://www.pdftron.com/webviewer/demo/gallery/floorplan.pdf',
      'assets/file-covers/floorplan-cover.png'),
  Thumbnail(
      'https://www.pdftron.com/webviewer/demo/gallery/chart_supported.pdf',
      'assets/file-covers/chart-cover.png'),
  Thumbnail('https://www.pdftron.com/webviewer/demo/gallery/form-1040.pdf',
      'assets/file-covers/form-cover.png'),
  Thumbnail('https://www.pdftron.com/webviewer/demo/gallery/magazine.pdf',
      'assets/file-covers/magazine-cover.png'),
  Thumbnail(
      'https://www.pdftron.com/webviewer/demo/gallery/comp_sci_cheatsheet.pdf',
      'assets/file-covers/cheatsheet-cover.png'),
  Thumbnail(
      'https://www.pdftron.com/webviewer/demo/gallery/legal-contract-doc.pdf',
      'assets/file-covers/contract-cover.png'),
  Thumbnail(
      'https://www.pdftron.com/webviewer/demo/gallery/construction_drawing-final.pdf',
      'assets/file-covers/layout-cover.png'),
];
