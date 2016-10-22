require 'spec_helper'

describe 'drush', :type => :class do
  let(:title) { 'drush' }

  it { should contain_class('drush') }
end
