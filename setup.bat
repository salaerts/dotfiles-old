@echo off
SET source=%~dp0
SET destination=%UserProfile%

echo %source%

copy %source%\_vimrc %destination%\_vimrc
mkdir %destination%\.vim
mkdir %destination%\.vim\bundle

git clone https://github.com/gmarik/vundle.git %destination%\.vim\bundle\vundle
