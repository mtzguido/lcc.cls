Clase de LaTeX de la LCC
========================

Para prácticas, apuntes, exámenes, o cualquier documento. Puntos
clave:

- No hace falta editar `lcc.cls`. Todo se modifica desde afuera.

- Es un único archivo. El logo de la UNR está embebido. Este repo
siempre va a tener la versión actualizada (si hiciste algún cambio:
mandalo!).

- Se puede escribir en UTF-8 (tildes, ñ, etc) incluso en bloques de
código. Trae algunos lenguajes ya configurados (C, Erlang, Haskell,
Python).

- Hay un entorno `solucion` para las soluciones de ejercicios. Están
_ocultas_ por defecto. Se pueden mostrar pasando la opción `sol` a la
clase (o `debug`).

- También se pueden agregar comentarios, por defecto ocultos, para
discutir y/o dejar notas. Se pueden mostrar pasando la opción `comm` a
la clase (o `debug`).

- El archivo PDF tiene incluidos metadatos con el título y autor (= la
materia).

Mini Manual
===========

- Con `\documentclass{lcc}`, y el archivo `lcc.cls` en el mismo
directorio, ya casi está.

- Al paquete se le puede pasar una opción, como
`\documentclass[practica]{lcc}` para que active las opciones por defecto
de una práctica. Las otras opciones son `apunte`, `tp`, `parcial`,
`recuperatorio`, `final`.

- Las configuraciones principales son:
```
\codigo{R-000}
\materia{Tipografía en \LaTeX}
\num{1} % número de práctica
\titulo{Práctica de Ejemplo}
```
Todas se pueden omitir.

- Para agregar el año de dictado, usar `\date{2022}` o similar. Se
muestra al fondo de cada página.

- Para escribir código, cada lenguaje tiene definido un entorno para
bloques, un comando para código inline, y un comando para importar
un archivo. Por ejemplo, para C, se puede escribir código entre
`\begin{C}..\end{C}`, o escribir código inline con `\cc{free(malloc(1))}`,
o importar un archivo usando `\csource{main.c}`.

| Lenguaje     | Entorno       | Inline         | Importar          |
|--------------|---------------|----------------|-------------------|
| C            | `C`           | `\cc{}`        | `\csource{}`      |
| Erlang       | `Erl`         | `\erl{}`       | `\erlsource{}`    |
| Python       | `Py`          | `\py{}`        | `\pysource{}`     |
| Haskell      | `Hask`        | `\hask{}`      | `\hasksource{}`   |
| Bash         | `Bash`        | `\bash{}`      | `\bashsource{}`   |
| FD4          | `FDD`         | `\fdd{}`       | `\fddsource{}`    |

El soporte de lenguajes es básico. Se aceptan mejoras.
- mathescape?

*NOTA*: LaTeX implementa los entornos como comandos del mismo nombre.
Entonces, definir un comando `\C` va a fallar, o pisar la definición
del entorno.

- La clase importa el parquete TiKZ por defecto (se usa para el logo).

- Se puede usar `\pdfauthor{..}` y `\pdftitle{..}` para los metadatos
del PDF directamente. A veces las tildes y símbolos andan mal.

- Con `\logofile{..}` se puede elegir cualquier archivo de imagen
como logo. Debería ocupar el mismo tamaño que ahora, si necesitás
achicar/agrandar hay que editar la clase.

Bugs/TODO
=========

- En un documento que use `lcc.cls`, hay que hacer `\maketitle` sí o
sí o el espaciado al fondo de las páginas 2 en adelante queda mal.
Esto es por un hack que hay en `lcc.cls`. Si bien no imagino que alguien
no quiera hacer `\maketitle`, vendría bien arreglarlo.

- Después de un entorno de código (`lstlistings`, `C`, etc.) se deja
demasiado espacio. Tiene algo que ver con el paquete parskip (pero
queremos ese paquete, en mi opinión).

- En mi visor de PDF (evince) no funciona buscar palabras con tilde...
por qué?

- Refactorizar para no usar opciones de clase..? Ayudan o estorban? Las
versiones anteriores de esta clase usaban comandos como `\apunte` en vez
de opciones.

- El header de cada página no muestra la sección del documento. No sé
si es mejor o peor.

- Agregar lugar para nombres de docentes?
