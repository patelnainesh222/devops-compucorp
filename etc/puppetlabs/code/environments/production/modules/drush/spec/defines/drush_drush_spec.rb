require 'spec_helper'

describe 'drush::drush' do
  let(:title) { 'drush' }

  it { should contain_exec('drush-install-7') \
    .with_command('composer --prefer-dist require drush/drush 7') \
    .with_user('root') \
    .with_cwd('/opt/drush-7') \
    .with_environment('COMPOSER_HOME=/opt/drush-7')
  }

  it { should contain_file('/opt/drush-7') \
    .with_ensure('directory') \
    .with_owner('root') \
    .with_mode('0755')
  }

  it { should contain_file('/usr/local/bin/drush') \
    .with_target('/opt/drush-7/vendor/bin/drush') \
    .with_owner('root')
  }

  describe 'with a given version' do
    let(:params) {{ :version => '6' }}

    it { should contain_exec('drush-install-6') \
      .with_command('composer --prefer-dist require drush/drush 6') \
      .with_user('root') \
      .with_cwd('/opt/drush-6') \
      .with_environment('COMPOSER_HOME=/opt/drush-6')
    }

    it { should contain_file('/opt/drush-6') \
      .with_ensure('directory') \
       .with_owner('root') \
      .with_mode('0755')
    }

    it { should contain_file('/usr/local/bin/drush') \
      .with_target('/opt/drush-6/vendor/bin/drush') \
      .with_owner('root')
    }
  end

  describe 'with a given target_dir' do
    let(:params) {{ :target_dir => '/usr/local' }}

    it { should contain_exec('drush-install-7') \
      .with_command('composer --prefer-dist require drush/drush 7') \
      .with_user('root') \
      .with_cwd('/usr/local/drush-7') \
      .with_environment('COMPOSER_HOME=/usr/local/drush-7')
    }

    it { should contain_file('/usr/local/drush-7') \
      .with_ensure('directory') \
      .with_owner('root') \
      .with_mode('0755')
    }

    it { should contain_file('/usr/local/bin/drush') \
      .with_target('/usr/local/drush-7/vendor/bin/drush') \
      .with_owner('root')
    }
  end

  describe 'with a given user' do
    let(:params) {{ :user => 'durpal' }}

    it { should contain_exec('drush-install-7') \
      .with_command('composer --prefer-dist require drush/drush 7') \
      .with_user('durpal') \
      .with_cwd('/opt/drush-7') \
      .with_environment('COMPOSER_HOME=/opt/drush-7')
    }

    it { should contain_file('/opt/drush-7') \
      .with_ensure('directory') \
      .with_owner('durpal') \
       .with_mode('0755')
    }

    it { should contain_file('/usr/local/bin/drush') \
      .with_target('/opt/drush-7/vendor/bin/drush') \
      .with_owner('durpal')
    }
  end

  describe 'with a given link_name' do
    let(:params) {{ :link_name => '/usr/local/bin/drushicle' }}

    it { should contain_exec('drush-install-7') \
      .with_command('composer --prefer-dist require drush/drush 7') \
      .with_user('root') \
      .with_cwd('/opt/drush-7') \
      .with_environment('COMPOSER_HOME=/opt/drush-7')
    }

    it { should contain_file('/opt/drush-7') \
      .with_ensure('directory') \
      .with_owner('root') \
      .with_mode('0755')
    }

    it { should contain_file('/usr/local/bin/drushicle') \
      .with_target('/opt/drush-7/vendor/bin/drush') \
      .with_owner('root')
    }
  end
end
