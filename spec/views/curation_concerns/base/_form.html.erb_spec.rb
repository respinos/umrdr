require 'spec_helper'

describe 'curation_concerns/base/_form.html.erb', type: :view do
  # let(:work) do
  #   stub_model(GenericWork, id: '456', rights: [ RightsService.select_options[0][-1] ])
  # end
  # let(:ability) { double }

  # let(:form) do
  #   CurationConcerns::GenericWorkForm.new(work, ability)
  # end

  # before do
  #   view.lookup_context.view_paths.push 'app/views/curation_concerns'
  #   # view.lookup_context.view_paths.push 'app/views/records'
  #   allow(view).to receive(:curation_concern).and_return(work)
  #   # allow(controller).to receive(:current_user).and_return(stub_model(User))
  #   assign(:curation_concern, work)
  #   assign(:form, form)
  # end

  # let(:page) do
  #   render
  #   Capybara::Node::Simple.new(rendered)
  # end

  let(:ability) { double }
  let(:generic_work) { stub_model(GenericWork, id: nil, depositor: 'bob', rights: [RightsService.select_options[0][-1]]) }
  let(:form) do
    CurationConcerns::GenericWorkForm.new(generic_work, ability)
  end
  let(:builder) { FormBuilder.new }

  before do
    allow(controller).to receive(:current_user).and_return(stub_model(User))
    assign :generic_work, generic_work
    assign :curation_concern, generic_work
    assign :form, form
    view.lookup_context.view_paths.push "#{CurationConcerns::Engine.root}/app/views/curation_concerns/base"
    render partial: "curation_concerns/base/form", curation_concern: generic_work
  end

  it "rights should have asides" do
    num_asides = RightsService.select_options.length
    expect(page).to have_selector(".generic_work_rights .radio aside", count: num_asides)
  end
end
