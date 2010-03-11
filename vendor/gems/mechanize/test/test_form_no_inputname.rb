require "helper"

class FormNoInputNameTest < Test::Unit::TestCase
  def setup
    @agent = Mechanize.new
    @page = @agent.get('http://localhost/form_no_input_name.html')
  end

  def test_no_input_name
    form = @page.forms.first
    assert_equal(0, form.fields.length)
    assert_equal(0, form.radiobuttons.length)
    assert_equal(0, form.checkboxes.length)
  end
end
