class Octodigest; module Views; class Layout < Mustache

  include Rack::Utils
  alias_method :h, :escape_html

  def title
    if @title
      "it's a git... addicted! :: " + (h @title)
    else
      "it's a git... addicted! :: Online Github Summary"
    end
  end

end;end;end