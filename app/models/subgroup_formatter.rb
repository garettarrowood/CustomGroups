class SubgroupFormatter

  def initialize(groupdata)
    @groupdata = groupdata.sort
  end

  def html
    content = ""
    i=1
    @groupdata.size.times do
      content<<'<div class="col-xs-4">'
      content<<"<h3 class='group'>Group #{i}</h3>"
      @groupdata[i].each do |name|
        content<<"<p class='student-name'>#{name}</p>"
      end
      content<<'</div>'
      i+=1
    end
    content.html_safe
  end

end
