extends ColorRect

onready var draggableHolder = $DraggableHolder
onready var lblReport = $lblReport
onready var lblItem = $lblItem

onready var lblCountries = $lblCountries
onready var lblImpact = $lblImpact
onready var lblReaderChanges = $lblReaderChanges
onready var lblTotalReaderChange = $lblTotalReaderChange
onready var lblNotes = $lblNotes

var dayEndScreen

func init(dayEndScreen, draggable, report_num, item_num, item_max_num, countries, country_reader_changes, total_reader_change, financial_impact, note):
    self.dayEndScreen = dayEndScreen
    
    draggable.rect_position = draggableHolder.rect_size / 2 - draggable.rect_size / 2
    draggable.enabled = false
    draggableHolder.add_child(draggable)
    
    
    lblReport.set_text("Report #" + str(report_num))
    lblItem.set_text("Item " + str(item_num) + "/" + str(item_max_num))
    
    # Show country names
    var countries_str = ""
    for country in countries:
        countries_str += country.name + "\n"
    lblCountries.set_text(countries_str)
    
    # Show financial impact
    lblImpact.set_text(relativy(financial_impact, ""))
    
    # Show reader changes per country
    var readerChanges_str = ""
    for change in country_reader_changes:
        readerChanges_str += relativy(change, "k", "-") + "\n"
    lblReaderChanges.set_text(readerChanges_str)
    
    # Show total summation of reader changes
    lblTotalReaderChange.set_text(relativy(total_reader_change, "k"))
    
    # Show Notes
    lblNotes.set_text(note)
        
func relativy(value, suffix, alternative = "None"):
    var result = ""
    if value < 0:
        result = str(value) + suffix
    elif value > 0:
        result = "+" + str(value) + suffix
    else:
        result = alternative
    return result

func on_click():
    dayEndScreen.on_click()


func on_button_down():
    pass 
