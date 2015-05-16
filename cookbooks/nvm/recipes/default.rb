git "/usr/local/nvm" do                                            # githubからnvmを/usr/local/nvmへインストール
  repository "git://github.com/creationix/nvm.git"
  notifies :run, "bash[nvm.sh]"                                 # インストールが終わったらnvm.shという名前のbashを実行
end

bash "nvm.sh" do                                                     # nvm.shという名前のbash。
  code <<-EOH
    . /usr/local/nvm/nvm.sh                                      # nvmコマンドの読み込み
    nvm install v0.10.1                                               # Node.js v0.10.1をインストール
  EOH
  action :nothing                                                        # git cloneが終わるまで実行したくないのでnothingを指定。
end

template "/etc/profile.d/nvm.sh" do                        # nvm.sh.erb (後述)を/etc/profile.d/nvm.shにコピー
  source "nvm.sh.erb"
  mode 00644
end
