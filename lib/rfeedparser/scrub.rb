require 'nokogiri'

module FeedParserUtilities

  def sanitizeHTML(html,encoding)
    html = html.gsub(/<!((?!DOCTYPE|--|\[))/, '&lt;!\1')
    Nokogiri::HTML::DocumentFragment.parse(html).to_html
  end
end
