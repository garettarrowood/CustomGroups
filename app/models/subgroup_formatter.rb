class SubgroupFormatter

  def initialize(groupdata)
    @groupdata = groupdata.sort
  end

  def html
    content = ""
    i=1
    @groupdata.size.times do 
      content<<'<div class="col-xs-4">'
      content<<"<h4><u>Group #{i}</u></h4>"
      @groupdata[i].each do |name|
        content<<"<p>#{name}</p>"
      end
      content<<'</div>'
      i+=1
    end
    content.html_safe
  end

end
