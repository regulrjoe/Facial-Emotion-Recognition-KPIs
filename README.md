# FER_KPIs
Visualización de los KPIs del proyecto FER (Facial Emotion Recognition) de la clase de Business Intelligence.

## Instalación de Python, Virtualenv, y MongoDB
### MacOS
#### 1. Instala Python3 desde Homebrew.

```
brew install python3
```

Esto también instala pip3.

Verifica que `which python3` regresa 
```
/usr/local/bin/python3
```

Si no, ni pedos.

### 2. Instala virtualenv y virtualenvwrapper con pip3
`pip3 install virtualenv virtualenwrapper`

Virtualenv crea ambientes en python que mantienen a las dependencias y librerías de python aisladas del resto de las librerías. Esto para evitar conflictos en en versión de dependencias por parte de diferentes librerías.

Virtualenvwrapper gestiona tus ambientes y hace sencillo el poder crear, borrar, copiar.

### 3.Configura tu virtualenvwrapper
Crea el directorio `~/.virtualenvs`. con `mkdir ~/.virtualenvs`.

En tu `~/.bash_config` (si usas bash) o `~/.zsrhc` (si usas zsh), agrega el siguiente código
```
# Virtualenv / VirtualenvWrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh
```

Se crea el directorio donde se guardarán los ambientes virtuales, en este caso `~/.virtualenvs`.

The last two steps is to create a directory where you would like to keep your virtual environments, in my case I've created a hidden folder inside ~ directory and is called .virtualenvs with mkdir .virtualenvs. Second is to add virtualenv variables to .bash_profile. In the end your .bash_profile should contain this information to work properly with installed packages:

### 4. Crea un virtualenv
```
mkvirtualenv FER
```
Esto crea el ambiente y te lo activa.

Para desactivarlo simplemente escribe:
```
deactivate
```

Y para volver a ingresar escribe:
```
workon FER
```

### 5. Instala mongoDB
```
brew install mongodb
```
