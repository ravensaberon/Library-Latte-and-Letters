@echo off
REM Script para quick connect sa Railway MySQL Database

echo ========================================
echo Connecting to Railway MySQL Database...
echo ========================================
echo.
echo Host: hayabusa.proxy.rlwy.net
echo Port: 18615
echo User: root
echo Database: railway
echo.
echo ========================================

mysql -h hayabusa.proxy.rlwy.net -u root -pJAzgscTMSDFzQyetSZuiBDSVBscMVLOy -P 18615 railway

pause
