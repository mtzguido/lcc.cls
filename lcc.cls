\ProvidesClass{lcc}[
2022/4/27 v0.1,
Clase LaTeX para la LCC,
Por cualquier problema/mejora, ir a https://github.com/mtzguido/lcc.cls]

\newif\ifdatos\datosfalse

\def\datosalumno{
    \begin{mdframed}[]
        Nombre y Apellido:
    \end{mdframed}
    % Pedir legajo?
}

\def\@tipo{} % Tipo de documento
\def\@tipop{} % Tipo, ``pretty-printed''

\DeclareOption{apunte}{
    \def\@tipo{apunte}
    \def\@tipop{Apunte}
    \date{}
}
\DeclareOption{practica}{
    \def\@tipo{practica}
    \def\@tipop{Práctica}
    \date{}
}
\DeclareOption{tp}{
    \def\@tipo{tp}
    \def\@tipop{Trabajo Práctico}
    \date{}
}
\DeclareOption{parcial}{
    \def\@tipo{parcial}
    \def\@tipop{Examen Parcial}
    \datostrue
}
\DeclareOption{recuperatorio}{
    \def\@tipo{recuperatorio}
    \def\@tipop{Examen Recuperatorio}
    \datostrue
}
\DeclareOption{final}{
    \def\@tipo{final}
    \def\@tipop{Examen Final}
    \datostrue
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt,a4paper]{article}

\RequirePackage[spanish]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[left=2cm,top=3cm,right=1.5cm,bottom=2.5cm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{mdframed}
\RequirePackage{environ}
\RequirePackage{amssymb}
\RequirePackage{parskip}
\RequirePackage{hyperref}

% tikz no es necesario. Pero, si alguien quiere usarlo, necesita agregar
% la % librería babel para que ande junto al paquete babel. Sin ello,
% tenemos un error horrible de compilación. Así que lo agrego para
% evitar potenciales dolores de cabeza.
\RequirePackage{tikz}
\usetikzlibrary{babel}

% Entorno para cosas ocultas.
\NewEnviron{hide}{}{}

\renewcommand{\figurename}{Figura}
\renewcommand{\tablename}{Tabla}
\renewcommand{\theenumi}{\bf\alph{enumi}}
\renewcommand{\theenumii}{\roman{enumii}}
\renewcommand{\labelenumi}{\theenumi)}
\renewcommand{\labelenumii}{\theenumii.}

\renewcommand{\footrulewidth}{0.4pt}
\renewcommand{\headrulewidth}{0.4pt}
\addtolength{\textheight}{-40pt}
\addtolength{\headheight}{59pt}

% TODO: Uniformidad. Definir entornos para no usar contador, etc.

\newcounter{problema}

\newenvironment{problema}[1][\unskip]
{\stepcounter{problema}
\textbf{\arabic{problema} #1.~}}
{}

\newenvironment{problemaOff}[1][\unskip]
{\hide}
{\endhide}

\newenvironment{solucionOff}
{\hide}
{\endhide}

\newenvironment{solucionOn}[1][\unskip]
{\begin{mdframed}\textbf{Solución #1.}~}
{\end{mdframed}}

\newenvironment{solucion}
{\solucionOff}
{\endsolucionOff}

\newenvironment{ejemplo}[1][\unskip]
{\textbf{Ejemplo} #1.~}
{}

\newenvironment{nota}[1][\unskip]
{\textbf{Nota #1:}~}
{}

\newcounter{ejercicio}
\newenvironment{ejercicio}
{\stepcounter{ejercicio}\textbf{Ejercicio \arabic{ejercicio}.~}}
{}

% Comentarios
\newif\ifcomments\commentsfalse
\newcommand{\comm}[3]{\ifcomments{{\color{#1}[#2: #3]}}\fi}

% Ejemplo para definir a alguien que comenta.
\def\guido{\comm{blue}{Guido}}

% Correr este comando en el .tex para hacer visibles a los entornos solucion
\newcommand{\soluciones}[0]{
    \renewenvironment{solucion}
        {\solucionOn}
        {\endsolucionOn}
}

% TODO: embeber imagen en este tex, de alguna manera?
\def\@logo{unr.jpg}
\newcommand{\logo}[1]{\def\@logo{#1}}

\def\@codigo{}
\newcommand{\codigo}[1]{\def\@codigo{#1}}

\def\@materia{\textit{Materia}}
\newcommand{\materia}[1]{\def\@materia{#1}}

\def\@materiafull{%
    \ifx\@codigo\empty
    \else
    {\@codigo} ---
    \fi
    {\@materia}
}

\def\@num{}
\newcommand{\num}[1]{\def\@num{#1}}

\def\@titulo{}
\newcommand{\titulo}[1]{\def\@titulo{#1}}

\def\@leyA{Facultad de Ciencias Exactas, Ingeniería y Agrimensura}
\def\@leyB{Escuela de Ciencias Exactas y Naturales}
\def\@leyC{Departamento de Ciencias de la Computación}
\def\@leyD{\@materiafull}
\def\@leyE{}

\newcommand{\leyenda}[0]{
    \begin{tabular}{l}
        \ifx\@leyA\empty\else \textsc{\@leyA}\\ \fi
        \ifx\@leyB\empty\else \textsc{\@leyB}\\ \fi
        \ifx\@leyC\empty\else \textsc{\@leyC}\\ \fi
        \ifx\@leyD\empty\else \textsc{\@leyD}\\ \fi
        \ifx\@leyE\empty\else \textsc{\@leyE}\\ \fi
    \end{tabular}
}

\def\@fancyfooter{
    \lfoot{\small \@shorttitle}
    \cfoot{\small \@date}
    \rfoot{\small Página \thepage}
}

% Estilo primer página, con header
\fancypagestyle{ps_primera}{
    \ifx\@logo\empty
        \lhead{\leyenda}
    \else
        \lhead{
            \begin{minipage}{3cm}
                \includegraphics[width=2.7cm,height=2.7cm]{\@logo}
            \end{minipage}
        }
        \rhead{\leyenda}
    \fi
    \@fancyfooter
}

% Estilo de página 2 en adelante.
\fancypagestyle{ps_resto}{
    \lhead{\small \@materia}
    \chead{}
    \rhead{}

    \@fancyfooter
}

\def\@fulltitle{%
    {\@tipop}
    \ifx\@num\empty
    \else
     {\@num}
    \fi
    \ifx\@titulo\empty
    \else
    --
    {\@titulo}
    \fi
}
\newcommand{\fulltitle}[1]{\def\@fulltitle{#1}}

\def\@fancytitle{
    \parskip=1pt

    {
        \Large\bf
        {\@tipop}
        \ifx\@num\empty
        \else
        {\@num}
        \fi
    }

    {\large\sc
        \@titulo
    }
}
\newcommand{\fancytitle}[1]{\def\@fancytitle{#1}}

\def\@shorttitle{\@fulltitle}
\newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}

\pagestyle{ps_resto}
\def\maketitle{
    \thispagestyle{ps_primera}

    \ifdatos
      \datosalumno
    \fi

    \begin{center}
        \@fancytitle
    \end{center}
}

\RequirePackage{listings}
\lstset{
    basicstyle=\ttfamily,
    keywordstyle = \color{blue},
    keepspaces=true,
    showstringspaces=false,
    columns=flexible,
    belowskip=0pt,
}

% Código C
\lstdefinestyle{C}{
    language=C,
    morekeywords=inline,
    morekeywords=bool,
}
\lstnewenvironment{C}[1][]{\lstset{style=C}}{}
\newcommand{\cc}[1]{\lstinline[style=C]`#1`}
\newcommand{\csource}[1]{\lstinputlisting[style=C,basicstyle=\ttfamily\small]{#1}}

% Código Bash
\lstdefinestyle{Bash}{
    language=bash,
}
\lstnewenvironment{Bash}[1][]{\lstset{style=bash}}{}
\newcommand{\bash}[1]{\lstinline[style=bash]`#1`}
\newcommand{\bashsource}[1]{\lstinputlisting[style=bash,basicstyle=\ttfamily\small]{#1}}

% Opcional: título y autor para metadata del PDF.
% símbolos especiales que no aparecen.
\def\@pdftitle{}
\newcommand{\pdftitle}[1]{\def\@pdftitle{#1}}
\def\@pdfauthor{}
\newcommand{\pdfauthor}[1]{\def\@pdfauthor{#1}}

\AtBeginDocument{
    % Metadata PDF

    % Si pdftitle es vacío, usar titulo
    \ifx\@pdftitle\empty\def\@pdftitle{\@fulltitle}\fi

    % Si pdfauthor es vacío, usar author. Si sigue vacío, usar materia.
    % (FIXME: no toma materia, \@author no está vacío?)
    \ifx\@pdfauthor\empty\def\@pdfauthor{\@author}\fi
    \ifx\@pdfauthor\empty\def\@pdfauthor{\@materia}\fi

    \hypersetup{
        pdfinfo={
            Title={\@pdftitle},
            Author={\@pdfauthor},
        }
    }
}
