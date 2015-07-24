include_recipe "curl"

git "/home/vagrant/.nvm" do                                            # githubからnvmを/usr/local/nvmへインストール
  user "vagrant"
  group "vagrant"
  repository "git://github.com/creationix/nvm.git"
  notifies :run, "bash[nvm.sh]"                                 # インストールが終わったらnvm.shという名前のbashを実行
end

bash "nvm.sh" do                                                     # nvm.shという名前のbash。
  user "vagrant"
  group "vagrant"
  code <<-EOH
    cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
    . /home/vagrant/.nvm/nvm.sh                                      # nvmコマンドの読み込み
    nvm install v0.12.7                                               # Node.js v0.12.7をインストール
  EOH
  action :nothing                                                        # git cloneが終わるまで実行したくないのでnothingを指定。
end

template "/etc/profile.d/nvm.sh" do                        # nvm.sh.erb (後述)を/etc/profile.d/nvm.shにコピー
  owner "root"
  source "nvm.sh.erb"
  mode 00644
end
