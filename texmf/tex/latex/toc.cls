%% toc.cls.1.005   2-1-2006    ToC style file
%------------------------------------------------------------------

% Filename: toc.cls
%
% This documentclass is intended for typesetting articles for the
%
%                        Theory of Computing.
%
% See http://theoryofcomputing.org for further details.
%
% Search for ``%%% PART'' to find the main parts of this class file.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Declare class and load external packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need this version of LaTeX atleast (for ClassWarning commands)
\NeedsTeXFormat{LaTeX2e}[1994/06/01] 
\ProvidesClass{toc}[2006/02/01 v1.005 Theory of Computing]


% Do not pass the following options down to the article class
\def\toc@dontpassoptions{10pt,11pt,12pt,oneside,twoside}
\@for\toc@tmpe:=\toc@dontpassoptions\do{%
   \DeclareOption{\toc@tmpe}{}
}

\ProcessOptions\relax
% Now load article class and handle options.
\LoadClass[11pt,twoside]{article}

% Insure that we use postscript type 1 times.
\RequirePackage{mathptmx}

% Load amsmath and amsthm packages
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}

% Load color, eucal.
\RequirePackage{color}
\RequirePackage{eucal}

% We'll require the page number of the last page in the title and
% running footers.
\RequirePackage{refcount}
\RequirePackage{lastpage}

% Load in keyval package. Used for handling parsing of \tocdetails
% This does not provide an overhead as hyperref loads keyval anyway.
% and keyval is just 15 lines of code!
\RequirePackage{keyval}

% Load the hyperref package. As loaded, it uses the default hpdftex
% driver code; this appears to be fine.  The colors selected are
% chosen so that internal document links (the citations, section
% headings, ...) are orange and external document links (e.g.,
% files and distant urls) are blue.
\RequirePackage[%
  hyperfootnotes=false,
  colorlinks=true,
  urlcolor=weborange,
  linkcolor=webblue,
  filecolor=weborange,
  citecolor=webblue,
  breaklinks=true,
  backref,
  pdfstartview=FitH,
  pdfpagelayout=OneColumn]{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Useful macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if the two arguments expand to the same thing
% MAGIC happens in the \edef which expands #1 and #2 completely first
% Mainly used to check equality of strings
\newcommand{\ifex}[2]{%
   \edef\toc@tmpa{#1}%
   \edef\toc@tmpb{#2}%
   \ifx\toc@tmpa\toc@tmpb
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Define the layout of the page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Our current strategy is maximize text layout area, subject to a
% one-inch lower bound on all margins. A4 pages are 210mmx297mm =
% 597.5ptx845pt; letter pages are 8.5inx11in = 614.3ptx795pt.
% Accounting for 2in=144.5pt total left and right margins leaves 
% us with min(597.5pt,614.3pt)-144.5pt = 453pt of total textwidth. 
% Similarly, we can afford min(845pt,795pt)-144.5pt = 650.5pt of 
% total text height, into which we must pack headers, text, and 
% footers.
\setlength{\voffset}{0pt}
\setlength{\hoffset}{0pt}
\setlength{\textwidth}{453pt}
\setlength{\headheight}{24pt}
\setlength{\headsep}{18pt}
\setlength{\footskip}{30pt}
\setlength{\textheight}{578.5pt}
\setlength{\marginparwidth}{62.27pt}

% Compute side margins to center text horizontally in page.
\newlength{\toc@hpadding}
\setlength{\toc@hpadding}{\paperwidth}
\addtolength{\toc@hpadding}{-2in}
\addtolength{\toc@hpadding}{-\textwidth}
\setlength{\evensidemargin}{.5\toc@hpadding}
\setlength{\oddsidemargin}{.5\toc@hpadding}

% Compute top margin to center virtual header/footer textbox.
\newlength{\toc@documentheight}
\newlength{\toc@vpadding}
\setlength{\toc@documentheight}{\textheight}
\addtolength{\toc@documentheight}{\footskip}
\addtolength{\toc@documentheight}{\headsep}
\addtolength{\toc@documentheight}{\headheight}
\setlength{\toc@vpadding}{\paperheight}
\addtolength{\toc@vpadding}{-\toc@documentheight}
\addtolength{\toc@vpadding}{-2in}
\setlength{\topmargin}{.5\toc@vpadding}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Values of parameters related to the journal, section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - All commands of the form \toc@<section>@xyz are section 
%   specific.
% - Once the section specific versions are declared run 
%   \toc@makemacro{xyz}. This will create a \toc@xyz which 
%   evaluates to the correct \toc@<section>@xyz macro.

\newcommand\toc@homepage{http://theoryofcomputing.org}
\newcommand\toc@journalname{Theory of Computing}
\newcommand\toc@journaladdress{\toc@homepage} 

% Initialize properties to default value
\newcommand{\toc@year}{\@empty}
\newcommand{\toc@number}{\@empty}
\newcommand{\toc@volume}{\@empty}
\newcommand{\toc@received}{\@empty}
\newcommand{\toc@published}{\@empty}
\newcommand{\toc@revised}{\@empty}
\newcommand{\toc@declaredfirstpage}{\@empty}

%%% The rest of this part is about \tocdetails command.

\define@key{tocdet}{year}{\renewcommand{\toc@year}{#1}}
\define@key{tocdet}{number}{\renewcommand{\toc@number}{#1}}
\define@key{tocdet}{volume}{\renewcommand{\toc@volume}{#1}}
\define@key{tocdet}{received}{\renewcommand{\toc@received}{#1}}
\define@key{tocdet}{published}{\renewcommand{\toc@published}{#1}}
\define@key{tocdet}{revised}{\renewcommand{\toc@revised}{#1}}
\define@key{tocdet}{firstpage}{\renewcommand{\toc@declaredfirstpage}{#1}}

% argument is a comma seperated list of the type "volume=6,year=8,..."
% If we have details of section we are interested in, process it
\newcommand{\tocdetails}[1]{\setkeys{tocdet}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Default values for Article META Information 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\toc@copyrightauthor{by the author(s)}
\newcommand\toc@runningauthor{}
\newcommand\toc@runningtitle{}
\newcommand\toc@firstpage{\getpagerefnumber{FirstPage}}
\newcommand\toc@lastpage{\getpagerefnumber{LastPage}}
% The next four are set in frontmatter environment
\newcommand\toc@authors\@empty
\newcommand\toc@acmclassification{{\color{red} ADD ACM
CLASSIFICATIONS!}}
\newcommand\toc@amsclassification{{\color{red} ADD AMS
CLASSIFICATIONS!}}
\newcommand\toc@keywords{{\color{red} ADD KEYWORDS!}}
\newcommand\toc@pdftitle{}
\newcommand\toc@pdfauthor{}

% New Boxes
\newbox\toc@abstract % To store the abstract

% New counter
\newcounter{toc@numauthors}
\setcounter{toc@numauthors}{0}

% Define parameter passing functions.
\newcommand*{\copyrightauthor}[1]{%
    \renewcommand\toc@copyrightauthor{#1}}
\newcommand*{\runningauthor}[1]{%
    \renewcommand\toc@runningauthor{#1}}
\newcommand*{\runningtitle}[1]{%
    \renewcommand\toc@runningtitle{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Copyright and related stuff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define copyright text.
%% Determine exterior and interion widths for the copyright box.
\newlength\toc@framewidth
\setlength\toc@framewidth{\fboxrule}
\addtolength\toc@framewidth{\fboxsep}

\newlength\toc@footerboxheight
\setlength\toc@footerboxheight{17mm}

\newlength\toc@jcrextwidth
\newlength\toc@jcrintwidth
\newlength\toc@crboxheight
\setlength\toc@crboxheight\toc@footerboxheight
\setlength\toc@jcrextwidth{87mm}
\setlength\toc@jcrintwidth{\toc@jcrextwidth}
\addtolength\toc@jcrintwidth{-2\toc@framewidth}

\newcommand{\toc@jcopyrighttext}{Authors retain copyright to their
  papers and grant ``\toc@journalname'' unlimited rights to publish
  the paper electronically and in hard copy.  Use of the article is
  permitted as long as the author(s) and the journal are properly
  acknowledged.  For the detailed copyright statement, see
  \url{http://theoryofcomputing.org/copyright.html}.}
\newcommand{\toc@acopyrighttext} {\copyright\ \toc@year\ 
  \toc@copyrightauthor} 
\newcommand{\toc@jcopyrightlayout}[1]
  {\fontsize{7}{8}\usefont{OT1}{ptm}{m}{n}\selectfont{#1}}
\newcommand{\toc@copyrightlayout}[1]
  {\fontsize{9}{10}\usefont{OT1}{ptm}{m}{n}\selectfont{#1}}
\newcommand{\toc@jcopyrightbox} {\framebox[\toc@jcrextwidth][t]
  {\centering \parbox[t]{\toc@jcrintwidth}
    {\toc@jcopyrightlayout{\toc@jcopyrighttext}}}}
\newcommand{\toc@copyrightbox}
{\parbox[b][\toc@crboxheight]{\textwidth} {\toc@jcopyrightbox\\ 
    \vfill \toc@copyrightlayout{\toc@acopyrighttext}}}
\newcommand{\toc@copyrightboxsmash}
{\parbox[b][0pt][b]{\toc@jcrextwidth}{\toc@copyrightbox}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Hyperlinking setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set up hyperlink colors.
\definecolor{weborange}{rgb}{.8,.3,.3}
\definecolor{webblue}{rgb}{0,0,.8}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Title page components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\toc@bannerjournalname}
           {\fontsize{11}{13}\usefont{OT1}{ptm}{m}{sc}
            \selectfont{\toc@journalname}}

\newcommand{\toc@bannerpubdata}
           {\fontsize{11}{13}\usefont{OT1}{ptm}{m}{n}\selectfont
            {,\ Volume \toc@volume\ (\toc@year), 
              pp. \toc@firstpage--\toc@lastpage}}

\newcommand\toc@bannertexta%
{\ifex\toc@volume\@empty
  \toc@bannerjournalname
 \else
  \toc@bannerjournalname\toc@bannerpubdata
 \fi}

\newcommand\toc@bannertextb
           {\fontsize{11}{13}\usefont{OT1}{ptm}{m}{it}
            \selectfont{\toc@journaladdress}}

\newlength{\toc@bannerwidth}
\setlength{\toc@bannerwidth}{\textwidth}
\addtolength{\toc@bannerwidth}{-2cm}
\newcommand{\toc@banner}{\toc@titlepagehook%
  \begin{minipage}{\toc@bannerwidth}%
    \centering \toc@bannertexta\\ \toc@bannertextb\\
    \vspace{2mm} \hrule\vspace{1pt}\hrule
  \end{minipage}}
                  % Define the date box. If \toc@received is
                  % undefined, this will simply print
                  % the current date, as does the article class.

\newcommand\toc@datelayout%
{\fontsize{10}{12}\usefont{OT1}{ptm}{m}{sl}\selectfont%
  \ifex\toc@received\@empty
  {\@date}
  \else
  {Received: \toc@received; %
    {\ifex\toc@revised\@empty{}\else{revised: \toc@revised; }\fi}%
    published: \toc@published.}
  \fi}
% Define the publication information box.
% If volume is undefined, this will simply
% print the journal address. Otherwise,
% volume, number, and article address will
% appear.

%% Setup classification box.

\newcommand\toc@classificationbox{%
 \parbox[t]{\textwidth}{%
  \noindent \textbf{ACM Classification: }\toc@acmclassification 
  \par \medskip
  \noindent \textbf{AMS Classification: }\toc@amsclassification 
  \par \medskip
  \noindent \textbf{Key words and phrases: }\toc@keywords \par}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Header and footer initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\toc@runningcitation%
{\ifex\toc@volume\@empty
  \textsc{\toc@journalname}
 \else
  \textsc{\toc@journalname}, Volume \toc@volume\ (\toc@year),
    pp. \toc@firstpage--\toc@lastpage
 \fi
}

% Header layout wrapper.
\newcommand\toc@headerlayout[1]
   {\fontsize{10}{12}\usefont{OT1}{ptm}{m}{sc}\selectfont{#1}}
\newcommand\toc@footerlayout[1]
   {\fontsize{10}{12}\usefont{OT1}{ptm}{m}{n}\selectfont{#1}}

% Set up title page style.
\newcommand{\ps@titlepage}{%
  \renewcommand{\@oddhead}{\@empty}%
  \renewcommand{\@evenhead}{\@empty}%
  \renewcommand{\@oddfoot}{\toc@copyrightboxsmash\hfil}%
  \renewcommand{\@evenfoot}{\toc@copyrightboxsmash\hfil}%
}

% Set up the 2ff. page style.
\renewcommand{\ps@headings}{%
\renewcommand{\@oddhead}
             {\hfil\toc@headerlayout{\toc@runningtitle}\hfil}%    
\renewcommand{\@evenhead}
             {\hfil\toc@headerlayout{\toc@runningauthor}\hfil}%
\renewcommand{\@oddfoot}
             {\hfil\toc@footerlayout{\toc@runningcitation}\hfil
\normalfont\thepage}%
\renewcommand{\@evenfoot}
             {\hfil\toc@footerlayout{\toc@runningcitation}\hfil
\normalfont\thepage}%
}

%% Determine actual footer height.
\newlength\toc@footerheight
\settoheight\toc@footerheight{\toc@footerlayout{\toc@runningcitation}}

%% Determine titlepage text area.
\newlength\toc@titlepagecorrection
\setlength\toc@titlepagecorrection\toc@crboxheight
\addtolength\toc@titlepagecorrection{-\toc@footerheight}

%% Adjust the textheight of first page to allow for the large footer
%% that we will place.
\newcommand{\toc@titlepagehook}{\label{FirstPage}%
  \enlargethispage{-\toc@titlepagecorrection}}

% Define the default page style to be headings.
\pagestyle{headings}
\pagenumbering{arabic}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: New Maketitle macro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (Re)define maketitle for ToC. These are lifted
% directly from article.cls.
\if@titlepage
\newcommand\toc@maketitle{\begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \begin{center}%
      \toc@banner%
    \end{center}%
    \null\vfil
    \vskip 40\p@
    \begin{center}%
      {\Huge \@title \par}%
      \vskip 3em%
      {\Large
        \lineskip .75em%
        \begin{tabular}[t]{c}%
          \@author
        \end{tabular}\par}%
      \vskip 1.5em%
      {\toc@datelayout \par}%
    \end{center}\par
    \@thanks
    \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\toc@maketitle{\par
  \begingroup
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\parindent 1em\noindent
    \hb@xt@1.8em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  \if@twocolumn
  \ifnum \col@number=\@ne
  \@maketitle
  \else
  \twocolumn[\@maketitle]%
  \fi
  \else
  \newpage
  \global\@topnum\z@   % Prevents figures from going at top of page.
  \@maketitle
  \fi
  \thispagestyle{titlepage}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \begin{center}%
    \toc@banner%
  \end{center}%
  \null
  \vskip 2em%
  \begin{center}%
    \let \footnote \thanks
    {\Huge \@title \par}%
    \vskip 1.5em%
    {\Large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
       \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\toc@datelayout}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Frontmatter and related macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{frontmatter}[1][]{
 
 % Default position is to float
 \newcommand{\toc@floatclass}{float} 
 \define@key{frontmatter}{classification}{\renewcommand{\toc@floatclass}{##1}}
 \setkeys{frontmatter}{#1}

 %Define abstract environment
 \renewenvironment{abstract}{%
  \global\setbox\toc@abstract=\vbox\bgroup
  \leftskip 1cm \rightskip 1cm
  \noindent {\bfseries Abstract:}  % caption `Abstract' (bold)
 }{\par \bigskip\egroup} % End of definition of abstract

 %(Re)Define Author environment
 \let\orig@author\author % Store original \author commannd
 \renewcommand{\author}[2][\@empty]{% Optional Nick name
   \addtocounter{toc@numauthors}{1} % Increment number of authors
   \ifnum 1=\value{toc@numauthors} % This is the first author
     \ifx##1\@empty
       \gdef\toc@authors{##2}
     \else
       \gdef\toc@authors{\hyperlink{author.info.##1}{##2}}
     \fi
   \else
     \ifx##1\@empty
       \g@addto@macro\toc@authors{\and ##2}
     \else
       \g@addto@macro\toc@authors{%
         \and \hyperlink{author.info.##1}{##2}}
     \fi
   \fi
 }

 % Define tocacm, tocams, tockeywords commands
 \newcommand{\tocams}[1]{\renewcommand{\toc@amsclassification}{##1}}
 \newcommand{\tocacm}[1]{\renewcommand{\toc@acmclassification}{##1}}
 \newcommand{\tockeywords}[1]{\renewcommand{\toc@keywords}{##1}}
 \newcommand{\tocpdftitle}[1]{\renewcommand{\toc@pdftitle}{##1}}
 \newcommand{\tocpdfauthor}[1]{\renewcommand{\toc@pdfauthor}{##1}}
}{ %
\ifnum \value{toc@numauthors}=0
    \renewcommand{\toc@authors}{{\color{red} No Authors Defined}}
\fi

\orig@author{\toc@authors}
\toc@maketitle
\bigskip
\ifex\toc@floatclass{float} % Typeset classification as float
  \begin{figure}[!b]
    \toc@classificationbox
  \end{figure}
\fi

\unvbox\toc@abstract

%%% ACR 4/12/05 added noindent here.
\ifex\toc@floatclass{text} % Typeset as usual
\noindent
  \toc@classificationbox
\fi

\hypersetup{%
pdfkeywords={\toc@keywords},
pdftitle={\toc@pdftitle},
pdfauthor={\toc@pdfauthor},
pdfsubject={\toc@journalname}
}

% Undefine keywords, abstract
\let\author\relax
\let\abstract\relax
\let\tocacm\relax
\let\tocams\relax
\let\tockeywords\relax
} % End of Frontmatter

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Theorem Environments and \ref-like macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hyperref variants
\newcommand{\secref}[1]{\hyperref[#1]{Section~\ref{#1}}}
\newcommand{\subsecref}[1]{\hyperref[#1]{Section~\ref{#1}}}

% Theorems, lemmata, corollaries, etc. are interleaved 
% and numbered by section.
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newcommand{\thmref}[1]{\hyperref[#1]{Theorem~\ref*{#1}}}

\newtheorem{lemma}[theorem]{Lemma}
\newcommand{\lemref}[1]{\hyperref[#1]{Lemma~\ref*{#1}}}

\newtheorem{corollary}[theorem]{Corllary}
\newcommand{\corref}[1]{\hyperref[#1]{Corollary~\ref*{#1}}}
\let\corrref\corref % Allow misspelling

\newtheorem{claim}[theorem]{Claim}
\newcommand{\clmref}[1]{\hyperref[#1]{Claim~\ref*{#1}}}
\let\claimref\clmref % Allow misspelling

\newtheorem{proposition}[theorem]{Proposition}
\newcommand{\propref}[1]{\hyperref[#1]{Proposition~\ref*{#1}}}

% More theorem like environments
\newtheorem{acknowledgement}[theorem]{Acknowledgement}
\newcommand{\ackref}[1]{\hyperref[#1]{Acknowledgement~\ref*{#1}}}

\newtheorem{algorithm}[theorem]{Algorithm}
\newcommand{\algoref}[1]{\hyperref[#1]{Algorithm~\ref*{#1}}}
\let\algref\algoref % Alternate spelling

\newtheorem{axiom}[theorem]{Axiom}
\newcommand{\axmref}[1]{\hyperref[#1]{Axiom~\ref*{#1}}}
\let\axiomref\axmref % Alternate spelling

\newtheorem{case}[theorem]{Case}
\newcommand{\caseref}[1]{\hyperref[#1]{Case~\ref*{#1}}}

\newtheorem{conclusion}[theorem]{Conclusion}
\newcommand{\concref}[1]{\hyperref[#1]{Conclusion~\ref*{#1}}}

\newtheorem{condition}[theorem]{Condition}
\newcommand{\condref}[1]{\hyperref[#1]{Condition~\ref*{#1}}}

\newtheorem{criterion}[theorem]{Criterion}
\newcommand{\critref}[1]{\hyperref[#1]{Criterion~\ref*{#1}}}

\newtheorem{exercise}[theorem]{Exercise}
\newcommand{\exerref}[1]{\hyperref[#1]{Exercise~\ref*{#1}}}

\newtheorem{notation}[theorem]{Notation}
\newcommand{\notnref}[1]{\hyperref[#1]{Notation~\ref*{#1}}}

\newtheorem{problem}[theorem]{Problem}
\newcommand{\probref}[1]{\hyperref[#1]{Problem~\ref*{#1}}}

\newtheorem{solution}[theorem]{Solution}
\newcommand{\solnref}[1]{\hyperref[#1]{Solution~\ref*{#1}}}
\let\solref\solnref  % Alternate spelling

\newtheorem{summary}[theorem]{Summary}
\newcommand{\summref}[1]{\hyperref[#1]{Summary~\ref*{#1}}}
\let\sumref\summref % Alternate spelling

\newcommand{\figref}[1]{\hyperref[#1]{Figure~\ref*{#1}}}

% Definition style theorem like environments
\theoremstyle{definition}
\newtheorem{fact}[theorem]{Fact}
\newcommand{\factref}[1]{\hyperref[#1]{Fact~\ref*{#1}}}

\newtheorem{conjecture}[theorem]{Conjecture}
\newcommand{\conjref}[1]{\hyperref[#1]{Conjecture~\ref*{#1}}}

\newtheorem{definition}[theorem]{Definition}
\newcommand{\defnref}[1]{\hyperref[#1]{Definition~\ref*{#1}}}
\let\defref\defnref % Alternate spelling

\newtheorem{example}[theorem]{Example}
\newcommand{\egref}[1]{\hyperref[#1]{Example~\ref*{#1}}}

\newtheorem{remark}[theorem]{Remark}
\newcommand{\remref}[1]{\hyperref[#1]{Remark~\ref*{#1}}}

% Set equation numbering to be of form Section.Number.
\numberwithin{equation}{section}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Predefined Math Symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Predefined common number systems.
\newcommand{\C}{{\mathbb C}}
\newcommand{\R}{{\mathbb R}}
\newcommand{\Q}{{\mathbb Q}}
\newcommand{\Z}{{\mathbb Z}}
\newcommand{\N}{{\mathbb N}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: \tocauthor and \tocaboutauthor environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Predefined e-mail punctuation.
\newcommand{\tocat}{ [at] }              %%%%% was \mailat
\newcommand{\tocdot}{ [dot] }            %%%%% was \maildot

\newcommand{\toc@emailfootnote}{\footnote{To reduce exposure 
to spammers, \textsc{Theory of Computing} uses various 
self-explanatory codes to represent ``AT'' and ``DOT'' in 
email addresses.}}

% Only have the plural version. Singular version will be an
% alternate name for the plural version. Environment will know
% whether to use plural or not based on the number of authors
% given

\newenvironment{tocauthors}{ % Beginning of environment

                     % Initialise an empty tocabout command
\newcommand{\tocabout}{\@empty}  

% Define tocinfo environment
 \newenvironment{tocinfo}[1][\@empty]{%
  \begin{verse}
  % Redefine \tocabout command for the author if nickname given
  \ifx##1\@empty
     \renewcommand{\tocabout}{\@empty}
  \else
     \renewcommand{\tocabout}%
                  {\hyperlink{author.about.##1}%
                  {\small [About the author]}}
  \fi
  \ifx##1\@empty\relax\else\hypertarget{author.info.##1}{}\fi
 }{% End of environment
\end{verse} \filbreak
} % End of tocinfo

\filbreak % Prefer a page break here rather than later
\bigskip\noindent
\ifnum \value{toc@numauthors}>1
   \textsf{AUTHORS}\toc@emailfootnote
\else
   \textsf{AUTHOR}\toc@emailfootnote
\fi
}{%
\let\tocinfo\relax % Undefine tocinfo
\let\tocabout\relax
}
%  end tocauthors environment

% singular is another name for plural
\newenvironment{tocauthor}{\begin{tocauthors}}{\end{tocauthors}}

\newenvironment{tocaboutauthors}{ % Beginning of environment
 \newenvironment{tocabout}[1][\@empty]{%
  \begin{verse}
  \if##1\@empty\relax\else\hypertarget{author.about.##1}{}\fi
 }{%
\end{verse}\filbreak
}

\filbreak % Prefer a page break here rather than later
\bigskip\noindent
\ifnum \value{toc@numauthors}>1
  \textsf{ABOUT THE AUTHORS}
\else
  \textsf{ABOUT THE AUTHOR}
\fi
}{% end tocaboutauthors environment
\let\tocabout\relax
}
%  end tocaboutauthors environment

\newenvironment{tocaboutauthor}
               {\begin{tocaboutauthors}}{\end{tocaboutauthors}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PART: Things to do at the start and end of document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndOfClass{% Load ToC logo and such
\IfFileExists{tocadjust.sty}{\RequirePackage{tocadjust}}{} 
}

\AtEndOfClass{% Include eprint support
\IfFileExists{eprint.sty}{\RequirePackage{eprint}}{} 
}

\AtBeginDocument{%
  \ifex\toc@declaredfirstpage\@empty
  \else
  \setcounter{page}{\toc@declaredfirstpage}
  \fi
}

\AtEndDocument{%
  \ifex\toc@declaredfirstpage\@empty
  {\ClassWarningNoLine{toc}{Use the firstjournalpage command to
      insure that page numbers match journal}}
  \else  % If not empty we assume it is a number
  \ifodd\toc@declaredfirstpage
  \else
  {\ClassWarningNoLine{toc}{Starting page number
      (\toc@declaredfirstpage) is not odd}}
  \fi   
  \fi
}





