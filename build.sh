set -e
export GRANIAN_VERSION="v2.8.1"
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
. ~/rust-bootstrap.sh
chmod +x ~/rust-bootstrap.sh
~/rust-bootstrap.sh -y -v
echo "Finished installing latest rust..."
echo "Prepending ~/.cargo/bin to PATH"
PATH="$HOME/.cargo/bin:$PATH"
command -v rustc || exit 127
rustc --version
command -v cargo || exit 127
cargo --version
python3 -m venv ~/venv
. ~/venv/bin/activate
pip install -U pip
pip install build
cd granian
python3 -m build
sudo cp -rv ./dist /tmp/host_workspace/
