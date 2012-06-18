module PagesHelper
  
  def render_resume_with_titles(title1 = "", title2 = "")
    render :partial => 'pages/resume_total', :locals => {:title1 => title1, :title2 => title2}
  end
  
end
