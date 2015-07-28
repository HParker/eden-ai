namespace :socket do
  desc "start the sock-drawer server to manage socket connections"
  task server: :environment do
    Sock::Drawer.new.start!
  end
end
