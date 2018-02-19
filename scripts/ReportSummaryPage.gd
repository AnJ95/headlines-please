extends ColorRect

onready var lblReport = $lblReport

onready var lblIncomeValue = $Income/lblValue
onready var lblIncomeTotalValue = $Income/lblTotalValue
onready var lblExpensesValue = $Expenses/lblValue
onready var lblExpensesTotalValue = $Expenses/lblTotalValue
onready var lblMoneyValue = $Money/lblValue
onready var lblMoneyTotalValue = $Money/lblTotalValue
onready var lblNotes = $lblNotes
var dayEndScreen


func init(dayEndScreen, report_num, readers_before, readers_now, income_per_paper, costs_per_day, headlines_num, costs_per_headline, money_before, note):
    self.dayEndScreen = dayEndScreen
    
    # Calculate some stuff
    var income = readers_now * income_per_paper
    var expenses_per_day = costs_per_day
    var expenses_per_headline = headlines_num * costs_per_headline
    var expenses = expenses_per_day + expenses_per_headline
    var money_now = money_before + income - expenses_per_day - expenses_per_headline
    
    # Format headline
    lblReport.text = "Report #%d" % report_num
    
    # Format income
    var incomeValueForm = "%.1fk\n+ %.1fk\n\nx     $%.0f"
    var incomeValue = incomeValueForm % [readers_before, (readers_now - readers_before), income_per_paper]
    var incomeTotalValueForm = "+ $%.1fk"
    var incomeTotalValue = incomeTotalValueForm % [income]
    lblIncomeValue.text = incomeValue
    lblIncomeTotalValue.text = incomeTotalValue
    
    # Format expenses
    var expensesValueForm = "- %dk\n%d\nx     - $%dk"
    var expensesValue = expensesValueForm % [expenses_per_day, headlines_num, costs_per_headline]
    var expensesTotalValueForm = "- $%dk"
    var expensesTotalValue = expensesTotalValueForm % [expenses]
    lblExpensesValue.text = expensesValue
    lblExpensesTotalValue.text = expensesTotalValue
    
    # Format money
    var moneyValueForm = "$%.1fk\n+ $%.1fk\n- $%.1fk"
    var moneyValue = moneyValueForm % [money_before, income, expenses]
    var moneyTotalValueForm = "$%.1fk"
    var moneyTotalValue = moneyTotalValueForm % [money_now]
    lblMoneyValue.text = moneyValue
    lblMoneyTotalValue.text = moneyTotalValue
    
    lblNotes.text = note
    

func on_click():
    dayEndScreen.on_click()


func on_button_down():
    pass 
