require 'spec_helper'
require 'rails_helper'

describe 'records/edit_fields/_rights.html.erb', type: :view do
  include SimpleForm::ActionViewExtensions::FormHelper
  helper_method :simple_form

  let(:work) do
    stub_model(GenericWork, id: '456', rights: [ RightsService.select_options[0][-1] ])
  end
  let(:ability) { double }
  # let(:f) { simple_form(work) }

  let(:form) do
    CurationConcerns::GenericWorkForm.new(work, ability)
  end

  before do
    view.lookup_context.view_paths.push 'app/views/curation_concerns'
    # view.lookup_context.view_paths.push 'app/views/records'
    # allow(controller).to receive(:curation_concern).and_return(work)
    # allow(controller).to receive(:current_user).and_return(stub_model(User))
    assign(:form, form)
  end

  # let(:page) do
  #   render locals: { }
  #   Capybara::Node::Simple.new(rendered)
  # end

  it "rights should have asides" do
    num_asides = RightsService.select_options.length
    # simple_form(work) do |f|
    #   render_template(partial: "records/edit_fields/_rights")
    # end
    expect(view).to render_template(partial: "records/edit_fields/_rights", f: f)
    # expect(page).to have_selector(".generic_work_rights .radio aside", count: num_asides)
  end
end
