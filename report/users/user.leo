<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="ahshoe.20161120121808.1"><vh>@settings</vh>
<v t="ahshoe.20170315212615.1"><vh>@data qt-gui-plugin-style-sheet</vh></v>
<v t="ahshoe.20170315212626.1"><vh>@string initial_split_orientation = horizontal</vh></v>
</v>
<v t="40323230.20170123213451.1"><vh>@button Report pdf</vh></v>
<v t="yen.20170429132400.1"><vh>協同著作規劃</vh></v>
<v t="leo.20171218141522.1"><vh>報告章節規劃</vh></v>
<v t="yen.20170429103742.1" a="E"><vh>@path ./../</vh>
<v t="yen.20170429103940.1" a="E"><vh>@path markdown</vh>
<v t="ahshoe.20170322182713.1"><vh>@edit reference.md</vh></v>
<v t="ahshoe.20170322181453.1"><vh>@edit refer.bib</vh></v>
<v t="leo.20171119234752.1" a="E"><vh>封面以及摘要</vh>
<v t="ahshoe.20161120122151.1" a="E"><vh>@clean cover_and_abstract.md</vh>
<v t="ahshoe.20170317115820.1"><vh>摘要</vh></v>
</v>
</v>
<v t="leo.20171119234822.1" a="E"><vh>各章節內容</vh>
<v t="yen.20170429214845.1" a="E"><vh>@path paragraph</vh>
<v t="yen.20170429214838.1" a="E"><vh>@clean introduction.md</vh>
<v t="yen.20170429214838.3"><vh>前言內容</vh></v>
</v>
<v t="yen.20170429215041.1" a="E"><vh>@clean portable_system.md</vh>
<v t="yen.20170429215130.1"><vh>可攜程式系統介紹</vh></v>
</v>
<v t="yen.20170429215252.1" a="E"><vh>@clean python_introduction.md</vh>
<v t="yen.20170429215308.1"><vh>Python 程式語法介紹</vh></v>
</v>
<v t="yen.20170429215416.1" a="E"><vh>@clean pyqt5_introduction.md</vh>
<v t="yen.20170429215446.2"><vh>PyQt5 語法介紹</vh></v>
</v>
<v t="yen.20170429215617.1" a="E"><vh>@clean calculator.md</vh>
<v t="yen.20170429215851.1"><vh>計算機程式內容</vh></v>
</v>
<v t="yen.20170429215922.1" a="E"><vh>@clean discussion.md</vh>
<v t="yen.20170429220001.1"><vh>程式開發心得</vh></v>
</v>
<v t="yen.20170429220128.1" a="E"><vh>@clean results.md</vh>
<v t="yen.20170429220137.1"><vh>期末報告結論</vh></v>
</v>
<v t="yen.20170429220335.1" a="E"><vh>@clean appendix.md</vh>
<v t="yen.20170429220335.2"><vh>附錄</vh></v>
</v>
</v>
</v>
</v>
</v>
<v t="leo.20180108102524.2" a="E"><vh>Recovered Nodes</vh>
<v t="leo.20180108102524.3"><vh>Recovered node "程式開發心得" from @clean discussion.md</vh>
<v t="leo.20180108102524.4"><vh>old:程式開發心得</vh></v>
<v t="leo.20180108102524.5"><vh>new:程式開發心得</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="40323230.20170123213451.1">@language python
filename = "report"
import os, platform

# 更換目錄到 markdown 
os.chdir("./../markdown")

# 若在 Linux 環境則使用 ukai.ttc 系統字形
if platform.system().lower()=="linux": font = "ukai.ttc"
# 在 windows 環境使用 SimSun 字形
elif platform.system().lower()=="windows": font = "SimSun"
else: font = "Arial"
fontsize = "12"
margin = "1in"
# --pdf-engine 使用 xelatex
# lang 請參照 https://tools.ietf.org/html/bcp47, 這裡的 zh-cmn 為 Mandarin Chinese 國語
# -V lang=zh-cmn 為一組 key=value 對應的 Variable 設定
# -N 表示 Number section headings in LaTeX, ConTeXt, HTML, or EPUB output. By default, sections are not numbered.
settingFlag = "--pdf-engine=xelatex -V lang=zh-cmn -N --toc --highlight-style kate -V documentclass=report  --filter pandoc-fignos --filter pandoc-tablenos --template=template.tex -V \"CJKmainfont:{0}\" -V fontsize={1}pt -V geometry:margin={2} --bibliography=refer.bib --csl=ieee.csl".format(font, fontsize, margin)
g.es("---Pandoc---")

# 選擇所要納入的 Markdown 檔案, 不納入的檔案名稱前方加上  # 即可
chapter_list = " ".join("./paragraph/" + i for i in [
"introduction.md",
"portable_system.md", 
"calculator.md", 
"python_introduction.md", 
"pyqt5_introduction.md", 
"discussion.md", 
"results.md", 
])

# 若系統並未正確轉檔, 可以將 os.system 改為 g.es 表示要使用 Leo Editor 的 global 物件中的 echo string 將指令印在 log 區
# 然後複製指令, 然後在命令列視窗中的 markdown 目錄中執行, 就可以得到錯誤訊息
# 或許可以再從 https://stackoverflow.com/questions/26005583/return-value-of-x-os-system 中的建議改進此一指令
g.es(os.system("pandoc cover_and_abstract.md " + chapter_list + " reference.md -o ../pdf/report.pdf {}".format(settingFlag)))
g.es("pandoc cover_and_abstract.md " + chapter_list + " reference.md -o ../pdf/report.pdf {}".format(settingFlag))
g.es("PDF 轉換完畢")
g.es('-'*12)</t>
<t tx="ahshoe.20161120121808.1"></t>
<t tx="ahshoe.20161120122151.1">---
university_zh: '國立虎尾科技大學'
institute_zh: '機械設計工程系'
category_zh: '計算機程式 bg6 期末報告'
title_zh: 'PyQt5 事件導向計算器'
title_en: 'PyQt5 Event-Driven Calculator Project'
author:
- 設計一乙 40623225 卓昆峰
- 設計一乙 40623226 鄭清詮
- 設計一乙 40623227 張耀元
- 設計一乙 40623234 洪一木
- 設計一乙 40623235 黃昱誠
- 設計一乙 40623236 黃子峰
advisor_zh: '嚴家銘'
date: '2017.12.18'
---

@others
</t>
<t tx="ahshoe.20170315212615.1">QTreeWidget {
    /* These apply to the selected item, but not to editing items.*/
    background-color: #ffffec; /* Leo's traditional tree color */
    selection-color: black; /* was white */
    selection-background-color: lightgrey;
    /* font-family: SansSerif; */
    /*font-family: DejaVu Sans Mono;*/
    font-family:YaHei Mono;
    /* 標題字型大小設定 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
 }

/* Headline edit widgets */
QTreeWidget QLineEdit {
    background-color: cornsilk;
    selection-color: white;
    selection-background-color: blue;
    /*font-family: DejaVu Sans Mono;*/    
    font-family:YaHei Mono;
    /* 沒有特別對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The log panes */
QTextEdit {
    background-color: #f2fdff;
    selection-color: red;
    selection-background-color: blue;
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* log font 大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The body pane */
QTextEdit#richTextEdit {
    background-color: #fdf5f5; /* A kind of pink. */
    selection-color: white;
    selection-background-color: red;
    /*font-family: DejaVu Sans Mono;*/
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* 內文字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLabel {
    font-family:YaHei Mono;'CherryPy', 'pytz', 'mako', 'beautifulsoup4', 'pymysql', 'peewee'
    /* 下方的 Minibuffer 標題字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

/* Editor labels */
QLineEdit#editorLabel {
    background-color: #ffffec;
    font-family:YaHei Mono;
    /* 沒有直接對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
    border: 2px;
    margin: 2px;
}</t>
<t tx="ahshoe.20170315212626.1">horizontal: body pane to the left
vertical: body pane on the botton</t>
<t tx="ahshoe.20170317115820.1">---
abstract: |    
    本研究的重點在於每組寫一個計算機程式，並分配每組每個組員需要負責的按鍵，然後依照老師所給的範例寫入各按鍵的程式，這並非只是抄襲，而是在寫入每行程式之後，並且去理解每行的程式運作及方法，然後將遇到的問題組別一起討論，並將所遇到的問題解決，讓自己本身以及自己組員對計算機程式有更深的了解。
    
     + 我們使用eric6來做計算機程式  
     
   
     
   
   
     + 使用github來做協同  
     
     
   
  
---


</t>
<t tx="leo.20171119234752.1"></t>
<t tx="leo.20171119234822.1"></t>
<t tx="leo.20171218141522.1">標題頁 - 含報告標題、作者、日期與所屬單位
目錄 - 列出全文章節與所屬頁面連結
摘要 - 解釋報告編寫動機、報告重點、結論、建議與關鍵字

前言 - 簡要描述全文意旨與背景, 說明報告目標與報告內容組成架構

內文 - 依照章節標題, 詳細說明報告內容, 包括方法、操作步驟與所得結果的詳細說明

結論 - 條列所獲致的重要成果, 與摘要及導言中的目標互相呼應

討論與建議 - 說明後續值得進行的方向、方法與可能遭遇問題的討論

參考 - 詳列所引用的參考內容

附錄 - 附加值得參考的詳細內容</t>
<t tx="leo.20180108102524.2"></t>
<t tx="leo.20180108102524.3">(uncached) yen.20170429220001.1
Diff...
  Fossil SCM
  ---
  
  40623236:組成內容與狀態的配置, 因此軟體組態管理 就是針對軟體開發過程, 有關組成內容與狀態配置的管理
  
  40623235:
  
  40623234:一個相當簡單明瞭的程式，快速方便的就像一個大倉庫，隨時隨地的能將資料上傳與複製。
  
  40623227:
  
  40623226:
  
  40623225:一個簡單可以依賴的一個軟體配置管理，這個是非常重要的
  
  網誌心得
  ---
  
  40623236:更新網誌是一件很麻煩的事 但是在打的過程中可以回復今天上的東西 以後旺季的時候也可以回去觀看複習 走過必留下痕跡 在網誌中遇到的問題難保以後不會遇到 這樣多去看已定可以更加進步
  
  40623235:
  
  40623234:網誌能記錄一切所有的學習歷程，雖然在上傳時較不方便也較複雜，但整體上去相當的實用，尤其是最下面的討論區。
  
  40623227:
  
  40623226:
  
  40623225:一開始學如何修改網誌的時候，非常讓人頭疼，可是越來越常修改的時候，就覺得已經開始熟悉它的步驟

  
  
  Github 協同倉儲
  ---
  bg6 協同倉儲:https://github.com/40623234-1/bg6_pyqt5_calculator
  
  40623236:在推東西的時後要先記得pull 雖然協同很方便但是溝通是不可或缺的
  
  40623235:
  
  40623234:github是相當方便的倉儲，比fossil更進一步，能與他人進行同步，並用pull與push進行更新與上傳，方便許多。
  
  40623227:
  
  40623226:
  
  40623225:協同倉儲可以讓在不同地方的人進行修改推送等功能，非常的方便快速
  
  學員心得
  ---
  
  
  40623236:協同是一個很重要的東西 一個東西完成需要很多人的幫忙和修改
  
  40623235:
  
  40623234:在一開始時，我剛進這間學校後發現有計算機程式這堂課，
  那一瞬間想到高職時尚的計算機概論，
  差不多是了解電腦程式和灌灌程式，
  後來知道其實fossil與github的方便性與快速性，
  了解為何世界的科技能進步如此快速。
  
  40623227:因為是初學者，所以一個人製作是非常困難的，因此需要組員間的討論才能完成
  
- 40623226:每個人都分配到特定的工作，不像之前一樣一個人辛苦地慢慢做，有了團隊分工效率變得更快
+ 40623226:
  
  40623225:本來從一開始甚麼東西都是自己來，到現在變成一個團隊憶起分工合作，一起將一個計算機做出來別新奇
  
  
  
  說明各學員任務與執行過程
  
  40623236:數字鍵 等號 計算 清除 等號跟計算最麻煩 因為會影響到很多人當有問題時我都要去幫忙
  
  40623235:
  
  40623234:加減的運算 雖然加減運算的先乘除後加減的程式語言很難，但是問問同學後就會瞭解許多。
  
  40623227:+-號 報告 因為報告要集結大家意見，所以在寫的過程中幫忙我的其實很多
  
- 40623226:小數點、 變號鍵、回復鍵、清除鍵按下後的處理方法，最後做的雖然比較複雜但因為最後推不會發生衝突
+ 40623226:
  
- 40623225:任務分配是乘跟除，需要去了解各個字所代表的意思，覺得這個部分特別的難
?                                            -
+ 40623225:任務分配是乘跟除，需要去了解各個字所代表的意思，覺得這個部分特別的難</t>
<t tx="leo.20180108102524.4">Fossil SCM
---

40623236:組成內容與狀態的配置, 因此軟體組態管理 就是針對軟體開發過程, 有關組成內容與狀態配置的管理

40623235:

40623234:

40623227:

40623226:

40623225:

網誌心得
---

40623236:更新網誌是一件很麻煩的事 但是在打的過程中可以回復今天上的東西 以後旺季的時候也可以回去觀看複習 走過必留下痕跡 在網誌中遇到的問題難保以後不會遇到 這樣多去看已定可以更加進步

40623235:

40623234:

40623227:

40623226:

40623225:


Github 協同倉儲
---
bg6 協同倉儲:https://github.com/40623234-1/bg6_pyqt5_calculator

40623236:在推東西的時後要先記得pull 雖然協同很方便但是溝通是不可或缺的

40623235:

40623234:

40623227:

40623226:

40623225:

學員心得
---


40623236:協同是一個很重要的東西 一個東西完成需要很多人的幫忙和修改

40623235:

40623234:在一開始時，我剛進這間學校後發現有計算機程式這堂課，
那一瞬間想到高職時尚的計算機概論，
差不多是了解電腦程式和灌灌程式，
後來知道其實fossil與github的方便性與快速性，
了解為何世界的科技能進步如此快速。

40623227:因為是初學者，所以一個人製作是非常困難的，因此需要組員間的討論才能完成

40623226:

40623225:本來從一開始甚麼東西都是自己來，到現在變成一個團隊憶起分工合作，一起將一個計算機做出來別新奇



說明各學員任務與執行過程

40623236:數字鍵 等號 計算 清除 等號跟計算最麻煩 因為會影響到很多人當有問題時我都要去幫忙

40623235:

40623234:

40623227:+-號 報告 因為報告要集結大家意見，所以在寫的過程中幫忙我的其實很多

40623226:

40623225:任務分配是乘跟除，需要去了解各個字所代表的意思，覺得這個部分特別的難</t>
<t tx="leo.20180108102524.5">Fossil SCM
---

40623236:組成內容與狀態的配置, 因此軟體組態管理 就是針對軟體開發過程, 有關組成內容與狀態配置的管理

40623235:

40623234:

40623227:

40623226:

40623225:

網誌心得
---

40623236:更新網誌是一件很麻煩的事 但是在打的過程中可以回復今天上的東西 以後旺季的時候也可以回去觀看複習 走過必留下痕跡 在網誌中遇到的問題難保以後不會遇到 這樣多去看已定可以更加進步

40623235:

40623234:

40623227:

40623226:

40623225:


Github 協同倉儲
---
bg6 協同倉儲:https://github.com/40623234-1/bg6_pyqt5_calculator

40623236:在推東西的時後要先記得pull 雖然協同很方便但是溝通是不可或缺的

40623235:

40623234:

40623227:

40623226:

40623225:

學員心得
---


40623236:協同是一個很重要的東西 一個東西完成需要很多人的幫忙和修改

40623235:

40623234:在一開始時，我剛進這間學校後發現有計算機程式這堂課，
那一瞬間想到高職時尚的計算機概論，
差不多是了解電腦程式和灌灌程式，
後來知道其實fossil與github的方便性與快速性，
了解為何世界的科技能進步如此快速。

40623227:因為是初學者，所以一個人製作是非常困難的，因此需要組員間的討論才能完成

40623226:每個人都分配到特定的工作，不像之前一樣一個人辛苦地慢慢做，有了團隊分工效率變得更快

40623225:本來從一開始甚麼東西都是自己來，到現在變成一個團隊憶起分工合作，一起將一個計算機做出來別新奇



說明各學員任務與執行過程

40623236:數字鍵 等號 計算 清除 等號跟計算最麻煩 因為會影響到很多人當有問題時我都要去幫忙

40623235:

40623234:

40623227:+-號 報告 因為報告要集結大家意見，所以在寫的過程中幫忙我的其實很多

40623226:小數點、 變號鍵、回復鍵、清除鍵按下後的處理方法，最後做的雖然比較複雜但因為最後推不會發生衝突

40623225:任務分配是乘跟除，需要去了解各個字所代表的意思，覺得這個部分特別的難
</t>
<t tx="yen.20170429103742.1"></t>
<t tx="yen.20170429103940.1"></t>
<t tx="yen.20170429132400.1">每一位協同人員各在 users 目錄中建立一個 .leo 檔案

各自選擇要編輯的 .md 檔案, 可以使用 @edit 或 @clean 節點編輯指令

除非必要否則不更動 markdown 目錄下的 template.tex 檔案</t>
<t tx="yen.20170429214838.1">前言
===
 

@others</t>
<t tx="yen.20170429214838.3">前言

為了讓我們知道以後協同的慨念和整體運作的方法所以使用MIKTex做報告
把我們一學期學到的做出整合分配協同出一個可用的計算機

機械設計就是靈活運用六種表達, 明確說明如何透過固體、流體與軟體元件之互動運作, 而能達成預定結果之明確與具體表達.

設計是一種明確與具體的表達, 而且是在仔細思考、多方考量後所完成的表達, 表達具有六種形式, 包括口語、文字、2D、3D、數學與實體表達, 設計的結果可以讓執行者有所依循, 根據指示執行後, 可得預期之結果.

機械是一種器物, 而且是由固體、流體與軟體元件精巧組合而成, 可互動運作, 達成特定功能之器物

三種類型的電腦與相關交互輔助設計模式:

近端(local) - 工程師面前的電腦, 以及機械設計系內部網路上連線的電腦.

遠端(cloud) - 廣域網路上的電腦.

可攜系統(mobile) - 工程師可以隨身啟動, 在各近端與遠端間移動, 仍能保有客製化的設定環境.
</t>
<t tx="yen.20170429214845.1"></t>
<t tx="yen.20170429215041.1">可攜程式系統介紹
===

可攜程式系統介紹

@others</t>
<t tx="yen.20170429215130.1">啟動與關閉
---
start.bat 會開啟cover_and_abstract  cmd exe

可以從cover_and_abstract 中修改 start.bat讓他開啟時可以一起開啟leo

從cover_and_abstract 中修改 leo 讓他在 start.bat 開啟時可以找到要開的檔案

stop.bat 的作用關閉全部的檔案




可攜式系統介紹
---
可攜式系統的意義:為了能讓自己隨身隨地完成自己的工作 和建立自己習慣的開發方式

miktex:讓文字檔跟圖檔轉成PDF檔

GIMP2:修剪圖片裁切圖片

DiaPortable:可繪製圖形註解圖片

github:組態管理的一種  能讓多人協同 優點公開不用錢 

Python36:在不同電腦能進行Python程式開發

Share-X:錄製影片 截圖


</t>
<t tx="yen.20170429215252.1">Python 程式語法
===

Python 程式語法

@others</t>
<t tx="yen.20170429215308.1">變數命名
---

Python3 變數命名規則與關鍵字
Python 英文變數命名規格

變數必須以英文字母大寫或小寫或底線開頭
變數其餘字元可以是英文大小寫字母, 數字或底線
變數區分英文大小寫
變數不限字元長度
不可使用關鍵字當作變數名稱

Python3 的程式關鍵字, 使用者命名變數時, 必須避開下列保留字.

Python keywords: ['False', 'None', 'True', 'and', 'as', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']

使用有意義且適當長度的變數名稱， 例如: 使用 length 代表長度, 不要單獨使用 l 或 L, 也不要使用 this_is_the_length
程式前後變數命名方式盡量一致, 例如: 使用 rect_length 或 RectLength
用底線開頭的變數通常具有特殊意義


print 函式
---
---def hi ():
      print(hi)

重複迴圈
---
---for i in num_button:
     i.clicked.connect(self.digitClicked)

判斷式
---
---if self.pendingMultiplicativeOperator:
            if not self.calculate(operand, self.pendingMultiplicativeOperator):
                self.abortOperation()
                return

數列
---
---num_button = [self.one,  self.two,  \
        self.three,  self.four,  self.five,  self.six,  self.seven,  self.eight,  self.nine,  self.zero]</t>
<t tx="yen.20170429215416.1">PyQt5
===



@others</t>
<t tx="yen.20170429215446.2">PyQt5 架構
---
精巧的電子零件，是透過輸入 010101，稱為「機器碼 (Machine code)」的指令才能運作的。電子裝置可以直接辨識與執行機器碼的指令，而且不同的裝置使用的機器碼語言是不一樣的。

想當然爾，人類不可能一直查詢機器碼，再輸入給電子零件，因此才產生「程式 (Program)」。

組合語言 (Combination language) 是一種用於可編成組件的程式語言，一種組合語言專用於某種電腦的系統結構。換句話說，組合語言僅次於機器碼，可以以較簡單的方式命令，而且開發人員可以輕易辨別位址與數值

C 語言透過「編譯 (Compile)」這個流程，將程式碼轉為機器碼執行。不同作業系統存在相應的「編譯器 (Compiler)」，對應到硬體的機器碼執行，而某些編譯器正是組合語言撰寫的。

Python 語言是透過 C 語言編寫的直譯器進行轉譯與執行，因此不須經過編譯動作，甚至可以藉由伺服器在網路端執行，將結果回傳給客戶端。

低階語言(C)有以下特性：

處理範圍廣，而且可以直接影響運作效能。
較不易閱讀與開發，一件工作必須寫得較為詳細。

高階語言(Python)則反之：

處理範圍和運作效能端看基礎架構而定，大量運算時效能不如低階語言。
簡單且優化過的內建命令，往往會有簡單的表示法與程式庫、模組。

PyQt 幾乎支援 Qt 大部分的功能，並且將較專門的功能另外分成 PyQt Chart（2D 圖表）、PyQt Data Visualization（3D 圖表）、PyQt Purchasing（應用程式購買功能）。

另外 QScintilla 是一個將 Scintilla 連結至 PyQt 的套件（在 C++ 可以直接用 Qt 和 Scintilla 即可），用途是辨識文字中的程式語言，以亮顯 (highlight) 的方式呈現，可以用作程式語言的辨識功能。


導入 sys 模組

import sys

 導入 keyword 模組
 
import keyword

print() 函式用法

print() 為 Python 程式語言中用來列印數值或字串的函式, 其中有 sep 變數定義分隔符號, ｓep 內定為 ",", end 變數則用來定義列印結尾的符號, end 內定為跳行符號.


簡單的 for 迴圈範例

for i in range(10):
    print(i)
    
函式用法與呼叫
使用者可以利用下列程式, 練習 def 函式定義與呼叫的用法.

定義函式

def square_of_x(x):
    return x*x

 呼叫函式
 
y = square_of_x(3)
 print(y)

列印 y 對應內容
</t>
<t tx="yen.20170429215617.1">Calculator 程式
===

Calculator 程式細部說明

@others</t>
<t tx="yen.20170429215851.1">計算機程式內容
---

for i in num_button:
            i.clicked.connect(self.digitClicked)
            
迴圈數字鍵 點案的時候連結到 digitClicked

self.display.setText("0")

起始 display 為 0

class Dialog(QDialog, Ui_Dialog)

 Dialog 類別同時繼承 QDialog 與 Ui_Dialog 類別

 self.equalButton.clicked.connect(self.equalClicked)
 
 當你按到equalButton連結到equalClicked方法

self.waitingForOperand = True

 起始時, 等待使用者輸入運算數值變數為真

 def digitClicked(self)
 
使用者點擊按鈕時送出的按鈕指標類別, 在此利用此按鍵類別建立案例

clickedButton = self.sender()

clickedButton 即為當下使用者所按下的按鈕物件

if self.pendingAdditiveOperator:
            if not self.calculate(operand, self.pendingAdditiveOperator):
            
                self.abortOperation()
                
                return
                
            self.display.setText(str(self.sumSoFar))
            
        else:

        self.pendingAdditiveOperator = clickedOperator
       
        self.waitingForOperand = True

            顯示目前的運算結果
            
            假如 self.pendingAdditiveOperator 為 False, 則將運算數與 self.fumSoFar 對應
            
            self.sumSoFar = operand
            
        能夠重複按下加或減, 以目前的運算數值執行重複運算
      
        進入等待另外一個運算數值的階段, 設為 True 才會清空 LineEdit
 
 if self.waitingForOperand:
            return

       
        self.display.setText('0')
        
        self.waitingForOperand = True

在等待運算數階段, 直接跳出 slot, 不會清除顯示幕

清除顯示幕後, 重置等待運算數狀態變數

 
</t>
<t tx="yen.20170429215922.1">心得
===

期末報告心得

@others
</t>
<t tx="yen.20170429220001.1">Fossil SCM
---

40623236:組成內容與狀態的配置, 因此軟體組態管理 就是針對軟體開發過程, 有關組成內容與狀態配置的管理

40623235:對於在配置上，有個方便的儲存與檢視的地方，不怕被刪檔，可靠而且對於程式設計師而言，日常工作中最常使用的工具，可能會是編輯器，或專為某種程式語言所設計的整合開發環境；而對負責大型軟體開發工作的軟體團隊成員來說，版本控制系統則是另一套相當重要的軟體工具。

40623234:一個相當簡單明瞭的程式，快速方便的就像一個大倉庫，隨時隨地的能將資料上傳與複製。

40623227:

40623226:

40623225:一個簡單可以依賴的一個軟體配置管理，這個是非常重要的

網誌心得
---

40623236:更新網誌是一件很麻煩的事 但是在打的過程中可以回復今天上的東西 以後旺季的時候也可以回去觀看複習 走過必留下痕跡 在網誌中遇到的問題難保以後不會遇到 這樣多去看已定可以更加進步

40623235:到期中考之前，我都還在摸索，可是在那之後，我知道他的重要性，而在裡面的內容，是關於以前學習的歷程，還有碰到的問題，都一一的在各個部分都清清楚楚的表示出來，慢慢的，會更加的充實

40623234:網誌能記錄一切所有的學習歷程，雖然在上傳時較不方便也較複雜，但整體上去相當的實用，尤其是最下面的討論區。

40623227:

40623226:

40623225:一開始學如何修改網誌的時候，非常讓人頭疼，可是越來越常修改的時候，就覺得已經開始熟悉它的步驟


Github 協同倉儲
---
bg6 協同倉儲:https://github.com/40623234-1/bg6_pyqt5_calculator

40623236:在推東西的時後要先記得pull 雖然協同很方便但是溝通是不可或缺的

40623235:Github協同倉儲有多彈性，還有做新增與修改來說，它是一個相當實用的軟體，而裡面開發的東西，是一些人共同要達成的目標

40623234:github是相當方便的倉儲，比fossil更進一步，能與他人進行同步，並用pull與push進行更新與上傳，方便許多。

40623227:

40623226:

40623225:協同倉儲可以讓在不同地方的人進行修改推送等功能，非常的方便快速

學員心得
---


40623236:協同是一個很重要的東西 一個東西完成需要很多人的幫忙和修改

40623235:和別人一起合作與探討，然而完成一件事情，是很有成就感的，
組員間互相支援，互相的討論，而且也有展現自我的空間，陪著組員一步一步慢慢做，
可以發現自己跟別人都可以慢慢的進步，雖然犯了錯，也是進步的關鍵

40623234:在一開始時，我剛進這間學校後發現有計算機程式這堂課，
那一瞬間想到高職時尚的計算機概論，
差不多是了解電腦程式和灌灌程式，
後來知道其實fossil與github的方便性與快速性，
了解為何世界的科技能進步如此快速。

40623227:因為是初學者，所以一個人製作是非常困難的，因此需要組員間的討論才能完成

40623226:每個人都分配到特定的工作，不像之前一樣一個人辛苦地慢慢做，有了團隊分工效率變得更快

40623225:本來從一開始甚麼東西都是自己來，到現在變成一個團隊憶起分工合作，一起將一個計算機做出來別新奇



說明各學員任務與執行過程

40623236:數字鍵 等號 計算 清除 等號跟計算最麻煩 因為會影響到很多人當有問題時我都要去幫忙

40623235:根號 平方 以及分數是相較於其他部分來說是算簡單的，所以常去幫其他組員要做的部分，一起解決問題，或是集結大家來討論

40623234:加減的運算 雖然加減運算的先乘除後加減的程式語言很難，但是問問同學後就會瞭解許多。

40623227:+-號 報告 因為報告要集結大家意見，所以在寫的過程中幫忙我的其實很多

40623226:小數點、 變號鍵、回復鍵、清除鍵按下後的處理方法，最後做的雖然比較複雜但因為最後推不會發生衝突

40623225:任務分配是乘跟除，需要去了解各個字所代表的意思，覺得這個部分特別的難
</t>
<t tx="yen.20170429220128.1">結論
===

期末報告結論

@others</t>
<t tx="yen.20170429220137.1">結論與建議
---



要寫一個計算機比想像中的困難，程式的邏輯以及運用方法，都是非常的困難，但在製作過程中，有大家的參與，組員間的討論溝通，解決遇到的問題，這都讓在寫計算機的時候變得簡單許多，能夠完成自己組別的一個計算機。 
建議:需要隨時注意完成度</t>
<t tx="yen.20170429220335.1">附錄
===

附錄內容

@others</t>
<t tx="yen.20170429220335.2">專案執行會議紀錄
---

操作過程照片
---

操作過程照片</t>
</tnodes>
</leo_file>
