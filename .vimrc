
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
" When started as "evim", evim.vim will already have done these settings.

"以下のsettingは主に下のサイト
"http://spring-mt.tumblr.com/post/18484692629/vim%E3%81%AE%E8%A8%AD%E5%AE%9A-vol1-vimrc%E3%81%AE%E8%A8%AD%E5%AE%9A
"-----------------------------
"" base setting
"-----------------------------
""カラースキーマを設定
colorscheme desert
" 暗い配色にする
set background=dark
 "viとの互換性をとらない
" This must be first, because it changes other options as a side effect.
set nocompatible
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	" シンタックスハイライトを有効にする
	syntax on
	" 検索結果文字列のハイライトを有効にする
    set hlsearch
endif
" 全モードでマウスを有効化
set mouse=a
 
"backupの設定(mkdir ~/.vim mkdir ~/.vim/backup mkdir ~/.vim/swap)
"これしとかないとファイルある場所にbackupファイルを作られて邪魔になる
"ただしセキュリティには注意が必要になる
"swapfileとはアプリのクラッシュに備えて、編集情報の記録を保存するファイル
"(名無しのvim使いの記事がわかりやすい)[http://nanasi.jp/articles/howto/file/seemingly-unneeded-file.html]
set backup
set backupdir=~/.vim/backup
set swapfile
set directory=~/.vim/swap
set viminfo+=n~/.vim/.viminfo

"これなんのことか全然理解していない。
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")


"-----------------------------
" display 表示関連
"-----------------------------
" タイトルをウインドウ枠に表示する
set title
" タイトルの文字列
"set titlestring=haru
 
"バイナリファイルの非印字可能文字を16進数で表示
set display=uhex
 
" 行番号を表示する
set number
" ルーラーを表示。ルーラーとは行数とその行の文字数のこと。
set ruler
" ルーラの内容を指定する書式は 'statusline' のものと同様
" エラーに成ったのでとりあえずキャンセル
"set ruf=%45(%12f%= %m%{'['.(&fenc!=''?&fenc:&enc).']'} %l-%v %p%% [%02B]%)
"999 行, 888 文字" の代わりに "999L, 888C" を表示。
set shortmess+=I
 
" 入力中のコマンドをステータスに表示する
set showcmd
"コマンドラインに使われるスクリーン上の行数
set cmdheight=2
 
"カーソルの上または下に表示する最小限の行数
set scrolloff=2
 
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させるための指定
set laststatus=2
" ステータスラインに表示する情報の指定
"エラー出たのでキャンセルしておく
"set statusline=%<%f %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v %l/%L
" ステータスラインの色
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=white
 
" 括弧入力時の対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を2にする
set matchtime=2
 
" コメント文の色を変更
highlight Comment ctermfg=DarkCyan
" コマンドライン補完を拡張モードにする
set wildmenu
 
" 入力されているテキストの最大幅
" (行がそれより長くなると、この幅を超えないように空白の後で改行される)を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
"以下何をしているかよくわかっていない。。
" fileencodings の設定を前から順に試してはじめにマッチしたものが採用される
set fileencodings=utf-8,euc-jp,iso-2022-jp,utf-8,cp932
" fileencoding=utf-8で編集中、□や○があるとその行でカーソル位置がずれる問題があったのだが、解決する設定（ambiwidth=double）
if &encoding == 'utf-8'
  set ambiwidth=double
  " 全角スペースの表示
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
  match ZenkakuSpace /　/
endif

"if has('multi_byte_ime') || has('xim')
"    " 日本語入力ON時のカーソルの色を設定
"    highlight CursorIM guibg=Orange guifg=NONE
"endif

".gvimrc カラー設定 あ、これgvimだよ。
"カラー設定した後にCursorIMを定義する方法
"if has('multi_byte_ime')
"  highlight Cursor guifg=red guibg=red
"  highlight CursorIM guifg=red guibg=red
"endif

" カーソル行をハイライト
" 今ひとつどうなっているかわからん。。
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black


"-----------------------------
" edit
"-----------------------------
" 括弧にカーソルが移ると対括弧がハイライト表示
set showmatch
"バックスペースにてインデントを削除可能にする
" indent : 行頭の空白
" eol : 改行
" start : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
"クリップボードを使用(vimエディタが「+clipboard」でコンパイルされていること :versionで確認)
set clipboard=unnamed
"paste をオンにすれば autoindent がオフの状態のトグル
set pastetoggle=<F2>
"GUI用のオプション
"a:ビジュアルモードで選択した文字がシステムのクリップボードに入る。他のアプリケーションとクリップボードを共有するオプション。
set guioptions+=a
"補完候補を表示する。コマンドライン補完が拡張モードで行われる
set wildmenu
"Vimがテキストを整形する方法を決定するオプション
set formatoptions+=M

" ---indent---
" タブ文字を CTRL-I で表示し、行末に $ で表示する
"http://blog.remora.cx/2011/08/display-invisible-characters-on-vim.html
set list
set listchars=tab:>-,trail:-,nbsp:%,eol:$,extends:>,precedes:<
" オートインデントを有効にする（新しい行のインデントを現在の行と同じにする）
set autoindent
"C言語スタイルのインデント機能が有効
"set cindent
" タブが対応する空白の数
set tabstop=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使う
set expandtab
"tmux上で起動したvimのyankをクリップボードに送るための設定
set clipboard+=unnamed
set clipboard+=autoselect

" #### putline ####(lineと打つ)
"使い方も中身もわからなかったので飛ばす
"let putline_tw = 30
"
"inoremap <Leader>line <ESC>:call <SID>PutLine(putline_tw)<CR>A
"function! s:PutLine(len)
"  let plen = a:len - strlen(getline('.'))
"  if (plen > 0)
"    execute 'normal ' plen . 'A-'
"  endif
"endfunction


"-----------------------------
" keymap
"-----------------------------
" inoremap インサートモード
" vnoremap ビジュアルモード
" nnoremap normalモード
" 物理行をjとkで移動する
nnoremap j gj
nnoremap k gk
"ブラウザと同じ操作 スペースでダウンアップ
"nnoremap <S-Space> <C-u>これは有効化できなかった。理由わからず。
nnoremap <Space> <C-d>
" brackets
" なるほど。理解できた。{}
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>

"以下は初期に作成したもの
" jjでエスケープ
inoremap <silent> jj <ESC>
" っｊでもエスケープ
inoremap <silent> っｊ <ESC>
" 入力モードでのカーソル移動 tmuxとの兼ね合いもあり、やめることにする
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>
" 現在日時を入力
nmap <C-o><C-o> <ESC>i<C-r>=strftime("%Y-%m-%d %H:%M:%S ==========")<CR><CR>




