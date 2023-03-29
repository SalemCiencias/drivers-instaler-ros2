# drivers-instaler-ros2
Bash script para instalar los drivers de la kobuli en ros2

## Requerimientos

- Distribucion de ros2 (probado con Humble)
- python3-rosdep2

```bash
sudo apt install python3-rosdep2
```

Al momento de ejecutar el instalador, asegurate de estar usando la version de python que usa tu sistema. O en su defecto contar con las bibliotecas que proporciona `python3-rosdep2`.

## Ejecuta el instalador

1. Descarga el archivo `install_kobuki_drivers.sh` 
2. Otorgale permisos de ejecución
```
chmod +x install_kobuki_drivers.sh
```
3. Ejecuta el script
```bash
./install_kobuki_drivers.sh
```
Si tu version de ros no es humble, o deseas cambiar el directorio de instalación, modifica las variables:
```bash
SRC_DIRECTORY=kobuki_base_ws/src
ROS_DISTRO=humble
```
por los deseados. Toma en cuenta que el `SRC_DIRECTORY` debe terminar en /src.

## Lanzar nodo controlador de la kobuki

Al terminar la instalación ejecuta:
```bash
cd kobuki_base_ws | <directorio de instalacion>
source install/setup.bash

ros2 launch kobuki_node kobuki_node-composed-launch.py
```

Si la instalación es correcta se desplegará el nodo controlador de la kobuki.
