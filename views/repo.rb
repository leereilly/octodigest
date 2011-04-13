class Octodigest;module Views;class Repo < Layout

  def user
    h params[:user]
  end

  def repo
    h params[:repo]
  end

  def tags

    @gah.tags["tags"].sort.each do |k,v|
      @k = k
    end

  end

  def contributors

    @gah.contributors["contributors"].each do |c|
      login       = c["login"]
      gravatar_id = c["gravatar_id"]
      name        = c["name"]
    end

  end

  def contributions
    h @gah.contributions
  end

end;end;end