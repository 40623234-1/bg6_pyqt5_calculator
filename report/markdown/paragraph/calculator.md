Calculator 程式
===

Calculator 程式細部說明

計算機程式內容
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

 
