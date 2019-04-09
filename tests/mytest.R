app <- ShinyDriver$new("../")
app$snapshotInit("mytest")

app$setInputs(sidebarCollapsed = FALSE)
app$setInputs(wt = 69.1)
app$setInputs(`._bookmark_` = "click")
app$setInputs(sidebarCollapsed = TRUE)
app$snapshot()
