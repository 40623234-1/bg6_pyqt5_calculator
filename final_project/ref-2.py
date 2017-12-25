# -*- coding: utf-8 -*-
 
"""
Module implementing Dialog.
"""
 
from PyQt5.QtCore import pyqtSlot
from PyQt5.QtWidgets import QDialog
 
from .Ui_Dialog import Ui_Dialog
 
 
# Dialog 類別同時繼承 QDialog 與 Ui_Dialog 類別
class Dialog(QDialog, Ui_Dialog):
    """
    Class documentation goes here. (若有類別相關說明文件內容, 放在此處)
    """
    def __init__(self, parent=None):
        """
        Constructor (類別建構子)
 
        @param parent reference to the parent widget
        @type QWidget
        """
        # 利用 super 類別調用 parent 類別中的建構子
        super(Dialog, self).__init__(parent)
        # 上一行在 Python3 可以寫為 super().__init__()
        # 利用 Ui_Dialog 類別中的 setupUi 方法, 以 self 視窗部件建立使用者介面
        self.setupUi(self)
        # 以上程式碼由 Eric6 表單頁面中的滑鼠右鍵, Generate Dialog Code 指令產生
        # 當多個 signal 同時指向同一個 slot 處理時, 採用 for loop
        num_button = [self.one,  self.two,  \
        self.three,  self.four,  self.five,  self.six,  self.seven,  self.eight,  self.nine,  self.zero]
        # 用於產生加號與減號 signals 與 slots 用的數列
        plus_minus = [self.plus,  self.minus]
        # 用於產生乘號與除號 signals 與 slots 用的數列
        multiply_divide = [self.multiply,  self.divide]
        #self.one.clicked.connect(self.number)
        # 數字按鍵的 signals 與 slots 設定
        for i in num_button:
            i.clicked.connect(self.number)
 
        # 加減鍵的 signals 與 slogts 設定
        for i in plus_minus:
            i.clicked.connect(self.additiveOperatorClicked)
 
        # 等於按鍵的 signal 與 slot 設定
        self.equal.clicked.connect(self.equalClicked)
 
        # 乘與除按建的 signals 與 slots 設定
        for i in multiply_divide:
            i.clicked.connect(self.multiplicativeOperatorClicked)
 
        # 等待運算的加或減
        self.pendingAdditiveOperator = ''
 
        # sumSoFar 儲存運算流程中所累計的數值
        # 當使用者按下 = 後, sumSoFar 重新計算並將數字顯示在 display 區
        # 當使用者按下 Clear All, sumSoFar 將重置回 0
        self.sumSoFar = 0.0
        # 起始時, 等待使用者輸入運算數值變數為真
        self.waitingForOperand = True
 
        # sumInMemory 儲存計算機記憶體中的值, 配合 MS, M+, 或 MC 按鈕使用
        self.sumInMemory = 0.0
        # factorSoFar 暫存按下乘或除運算時的數值
        self.factorSoFar = 0.0
        # 等待運算的乘或除
        self.pendingMultiplicativeOperator = ''
 
    def number(self):
        # sender() 為使用者點擊按鈕時送出的按鈕指標類別, 在此利用此按鍵類別建立案例
        # 所建立的 clickedButton 即為當下使用者所按下的按鈕物件
        clickedButton = self.sender()
        # text() 為利用按鈕物件的 text 方法取得該按鈕上所顯示的 text 字串
        digitValue = int(clickedButton.text())
        # when user clicks 0.0
        if self.display.text() == '0' and digitValue == 0.0:
            return
 
        # if under digit input process, clear display for the very first beginning
        # waitingForOperand 為 True 已經點按運算數值按鈕
        if self.waitingForOperand:
            # 清除 display 
            self.display.clear()
            # 將判斷是否已經點按運算數值按鈕的判斷變數重新設為  False
            self.waitingForOperand = False
        # 利用 setText() 設定 LineEdit 元件顯示字串, 利用 text() 取出目前所顯示的字串, 同時也可利用 text() 擷取按鈕物件上顯示的字串
        #self.display.setText(self.display.text() + self.sender().text())
        self.display.setText(self.display.text() + str(digitValue))
 
    def additiveOperatorClicked(self):
        # 確定按下加或減
        clickedButton = self.sender()
        # 確定運算子, 為加或減
        clickedOperator = clickedButton.text()
        # 點按運算子之前在 display 上的數字, 為運算數
        operand = float(self.display.text())
 
        # 納入乘與除之後的先乘除後加減運算邏輯, 且納入連續按下乘或除可累計運算
        if self.pendingMultiplicativeOperator:
            if not self.calculate(operand, self.pendingMultiplicativeOperator):
                self.abortOperation()
                return
 
            self.display.setText(str(self.factorSoFar))
            operand = self.factorSoFar
            self.factorSoFar = 0.0
            self.pendingMultiplicativeOperator = ''
 
 
        # 假如有等待運算的加或減, 進入執行運算
        # 且納入連續按下加或減時, 可以目前的運算數及運算子累計運算
        if self.pendingAdditiveOperator:
            if not self.calculate(operand, self.pendingAdditiveOperator):
                self.abortOperation()
                return
            # 顯示目前的運算結果
            self.display.setText(str(self.sumSoFar))
        else:
            # 假如 self.pendingAdditiveOperator 為 False, 則將運算數與 self.fumSoFar 對應
            self.sumSoFar = operand
 
        # 能夠重複按下加或減, 以目前的運算數值執行重複運算
        self.pendingAdditiveOperator = clickedOperator
        # 進入等待另外一個運算數值的階段, 設為 True 才會清空 LineEdit
        self.waitingForOperand = True
 
    # 處理使用者按下乘或除按鍵時的 slot 方法
    def multiplicativeOperatorClicked(self):
        clickedButton = self.sender()
        clickedOperator = clickedButton.text()
        # 將按鈕顯示的 text 轉為浮點數
        operand = float(self.display.text())
 
        # 若連續按下乘或除, 則以目前的運算數與運算子執行運算
        if self.pendingMultiplicativeOperator:
            if not self.calculate(operand, self.pendingMultiplicativeOperator):
                self.abortOperation()
                return
 
            # 將目前乘或除的累計運算數顯示在 display 上
            self.display.setText(str(self.factorSoFar))
        else:
            self.factorSoFar = operand
 
        # 能夠重複按下乘或除, 以目前的運算數值執行重複運算
        self.pendingMultiplicativeOperator = clickedOperator
        self.waitingForOperand = True
 
    def equalClicked(self):
        # 從 display 取的運算數值
        operand = float(self.display.text())
 
        # 先乘除的運算處理
        if self.pendingMultiplicativeOperator:
            if not self.calculate(operand, self.pendingMultiplicativeOperator):
                self.abortOperation()
                return
            # factorSoFar 為乘或除運算所得之暫存數值
            operand = self.factorSoFar
            self.factorSoFar = 0.0
            self.pendingMultiplicativeOperator = ''
 
        # 若有等待加或減的運算子, 執行運算
        if self.pendingAdditiveOperator:
            if not self.calculate(operand, self.pendingAdditiveOperator):
                self.abortOperation()
                return
 
            self.pendingAdditiveOperator = ''
        else:
            self.sumSoFar = operand
 
        self.display.setText(str(self.sumSoFar))
        self.sumSoFar = 0.0
        self.waitingForOperand = True
 
    # 右運算數與等待運算子當作輸入
    def calculate(self, rightOperand, pendingOperator):
        # 進入計算流程時, 用目前輸入的運算數值與 self.sumSoFar 執行計算
        if pendingOperator == "+":
            self.sumSoFar += rightOperand
        elif pendingOperator == "-":
            self.sumSoFar -= rightOperand
 
        elif pendingOperator == "*":
            self.factorSoFar *= rightOperand
        elif pendingOperator == "/":
            if rightOperand == 0.0:
                return False
 
            self.factorSoFar /= rightOperand
 
        return True