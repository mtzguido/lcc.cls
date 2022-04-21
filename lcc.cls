% Clase LaTeX para LCC
% Por cualquier problema/mejora, ir a
%  https://github.com/mtzguido/lcc.cls

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lcc}[]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{article}

\RequirePackage[spanish]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{mdframed}
\RequirePackage{environ}
\RequirePackage{amssymb}
\RequirePackage{enumerate}
\RequirePackage{parskip}

% No siempre es necesaria, pero si se requiere tikz,
% hay que usar la librería babel para que ande junto al
% paquete babel. Así que lo agrego para evitar dolores
% de cabeza.
\RequirePackage{tikz}
\usetikzlibrary{babel}

% Entorno para cosas ocultas.
\NewEnviron{hide}{}{}

\RequirePackage[left=2cm,top=3cm,right=1.5cm,bottom=2.5cm]{geometry}

\renewcommand{\figurename}{Figura}
\renewcommand{\tablename}{Tabla}
\renewcommand{\theenumi}{\bf\alph{enumi}}
\renewcommand{\theenumii}{\roman{enumii}}
\renewcommand{\labelenumi}{\theenumi)}
\renewcommand{\labelenumii}{\theenumii.}

\def\today{\number\day/\number\month/\number\year}
\setlength{\parindent}{0pt}
\renewcommand{\footrulewidth}{0.4pt}
\addtolength{\textheight}{-40pt}
\addtolength{\headheight}{59pt}

\newcounter{problema}

% TODO: Uniformidad. Definir entornos para no usar contador, etc.

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
\newcommand{\guido}[1]{\comm{blue}{Guido}{#1}}

% Correr este comando en el .tex para hacer visibles a los entornos solucion
\newcommand{\soluciones}[0]{
	\renewenvironment{solucion}
		{\solucionOn}
		{\endsolucionOn}
}

\def\logofile{}
\newif\iflogo
\logofalse
\newcommand{\logo}[1]{\def\logofile{#1}\logotrue}

\newif\ifdatos
\datostrue
\def\datosalumno{Nombre y Apellido:\hspace{200pt}\hrule\medskip}

\def\materiastr{}
\newcommand{\materia}[1]{\def\materiastr{#1}}

\title{}

\newcommand{\parcial}[1]{
	\title{Examen Parcial {#1}}
	\datostrue
}

\newcommand{\recuperatorio}[1]{
	\title{Examen Recuperatorio de Parcial {#1}}
	\datostrue
}

\newcommand{\final}{
	\title{Examen Final}
	\datostrue
}

\newcommand{\practica}[1]{
	\title{Práctica #1}
	\date{}
	\datosfalse
}

\newcommand{\trabajopractico}[1]{
	\title{Trabajo práctico #1}
	\date{}
	\datosfalse
}

% Si no hay shorttitle, usar title (arreglar: proveer comando para definirlo)
\providecommand{\shorttitle}{\@title}

\newcommand{\leyenda}[0]{
	\begin{tabular}{l}
		\textsc{Facultad de Ciencias Exactas, Ingeniería y Agrimensura}\\
		\textsc{Escuela de Ciencias Exactas y Naturales}\\
		\textsc{Departamento de Ciencias de la Computación}\\
		\textsc{\materiastr}\\
	\end{tabular}
}

% Estilo primer página, con header
\fancypagestyle{ps_primera}{
	\iflogo
		\lhead{
			\begin{minipage}{3cm}
				\includegraphics[width=2.7cm,height=2.7cm]{\logofile}
			\end{minipage}
		}
		\rhead{\leyenda}
	\else
		\lhead{\leyenda}
	\fi

	\lfoot{\small \shorttitle}
	\cfoot{\small \@date}
	\rfoot{\small Página \thepage}
}

% Estilo de página 2 en adelante.
\fancypagestyle{ps_resto}{
	\lhead{\small \materiastr}
	\chead{}
	\rhead{}

	\lfoot{\small \shorttitle}
	\cfoot{\small \@date}
	\rfoot{\small Página \thepage}
}

\pagestyle{ps_resto}
\def\maketitle{
	\thispagestyle{ps_primera}
	\ifdatos\datosalumno\fi
	\begin{center}
		\Large\bf \@title
	\end{center}
}

\RequirePackage{listings}
\lstset{
	basicstyle=\ttfamily,
	keywordstyle=\color{blue},
	keepspaces=true,
	showstringspaces=false,
	columns=flexible,
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
