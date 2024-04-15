#!/usr/bin/fish

source ./helpers/helper.fish

echo 'Enter Blender version in the format x.x.x (Only v2.83+ are supported):'
versionCheck
echo -e '\e[36mInstalling Blender \e[33mv'$bver'\e[0m'
set -l fver (echo $bver | sed -r 's/^(.*\..*)\..*$/\1/')
wget -P ~/Downloads/ https://download.blender.org/release/Blender$fver/blender-$bver-$arch.tar.xz
folderCheck
sudo tar xf ~/Downloads/blender-$bver-$arch.tar.xz -C /opt/Blender --strip-components=1
rm ~/Downloads/blender-$bver-$arch.tar.xz
cd /opt
sudo ln -s Blender blender
sudo ln -s /opt/blender/blender /usr/bin/blender
sudo ln -s /opt/blender/blender-thumbnailer /usr/bin/blender-thumbnailer
sudo ln -s /opt/blender/blender.desktop /usr/share/applications/
sudo ln -s /opt/blender/blender.svg /usr/share/icons/hicolor/scalable/
sed -i 's{Icon=blender{Icon=/usr/share/icons/hicolor/scalable/blender.svg{' /blender/blender.desktop
echo 'application/x-blender				blend' | sudo tee -a /etc/mime.types
sudo ln -s /opt/blender/blender-symbolic.svg /usr/share/icons/Pop/scalable/mimetypes/application-x-blender.svg
sudo update-icon-caches /usr/share/icons/Pop/
echo -e '[Thumbnailer Entry]\nTryExec=/usr/bin/blender-thumbnailer\nExec=/usr/bin/blender-thumbnailer %i %o\nMimeType=application/x-blender;\n' | sudo tee -a /usr/share/thumbnailers/x-blender.thumbnailer
echo '\e[32mDone!\e[0m'
killall -3 gnome-shell