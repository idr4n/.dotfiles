% Latex class to write simple documents in spanish.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mydoc_eng}[2024/02/27 v1.0 Simple Documents latex class (I. Duran)]

% Inherits from article class, using the current options
\LoadClassWithOptions{article}

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage[applemac]{inputenc}
\usepackage{lscape}
\usepackage{harvard}
\renewcommand{\harvardand}{y}
\setlength{\parindent}{0pt}

\newcommand{\num}{\begin{compactenum}[1.]}
\newcommand{\alfa}{\begin{compactenum}[A)]}
\newcommand{\myend}{\end{compactenum}}

% Custom title
\renewcommand{\maketitle}{
\begin{center}
\textbf{\@title}\\
\ifx\@author\@empty
      \relax
      \else
      {\@author\\}
\fi
\ifx\@date\@empty
      \relax
      \else
      {\@date}
\fi
\end{center}
}
\global\let\@author\@empty
\global\let\@date\@empty
