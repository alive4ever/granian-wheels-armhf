set -e
export GRANIAN_VERSION="v2.8.2"
if ! [ -d "$HOME/.local/bin" ]; then
	mkdir -p "$HOME/.local/bin"
fi
PATH=$HOME/.local/bin:$PATH
cd ~
git clone https://github.com/emmett-framework/granian
cd granian
git checkout "$GRANIAN_VERSION"
cd ..
curl -L -o uv-install.sh https://astral.sh/uv/install.sh
sh uv-install.sh -v --no-modify-path
command -v uv || exit 127
echo "Installing latest rust..."
curl -Lo ~/rust-bootstrap.sh https://sh.rustup.rs
chmod +x ~/rust-bootstrap.sh
~/rust-bootstrap.sh -y -v --no-modify-path --default-toolchain=1.97.1
echo "Finished installing latest rust..."
echo "Prepending ~/.cargo/bin to PATH"
PATH="$HOME/.cargo/bin:$PATH"
command -v rustc || exit 127
rustc --version
command -v cargo || exit 127
cargo --version
. /etc/os-release
case $VERSION_CODENAME in
	"trixie")
		x=13;;
	"bookworm")
		x=11;;
esac
uv python install 3.$x
uv venv ~/venv
. ~/venv/bin/activate
cd granian
uv build --wheel
sudo cp -rv ./dist /tmp/host_workspace/
