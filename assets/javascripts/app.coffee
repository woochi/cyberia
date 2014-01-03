Bacon = require("bacon")
d3 = require("d3")

win = document.body
hero = d3.select("#hero")[0][0]
nav = d3.select("#nav-sticky")
navList = d3.selectAll(".nav-list")
sticky = false

toggleSticky = ->
  if not sticky and win.scrollTop > hero.offsetHeight
    nav.classed "hidden", false
    sticky = true
  else if sticky and win.scrollTop <= hero.offsetHeight
    nav.classed "hidden", true
    sticky = false

sections = d3.selectAll(".featurette")

getOffsetTop = (elem) ->
  offsetTop = 0
  if !isNaN(elem.offsetTop)
    offsetTop += elem.offsetTop
  while(elem = elem.offsetParent)
    if !isNaN(elem.offsetTop)
      offsetTop += elem.offsetTop
  return offsetTop

toggleCurrentSection = (sectionId) ->
  console.log sectionId
  sections.filter("[rel=#{sectionId}]").classed "seen", true
  d3.selectAll(".nav-list .current").classed "current", false
  d3.selectAll(".nav-list [href='##{sectionId}']").classed "current", true

getSectionId = ->
  winHeight = win.offsetHeight
  midScroll = win.scrollTop + winHeight * 0.5
  offset = null
  section = "cyberpunk"
  for el in sections[0]
    elPos = getOffsetTop(el)
    padding = parseInt(window.getComputedStyle(el, null).getPropertyValue('padding-top'))
    if elPos <= midScroll and elPos + el.offsetHeight + padding*2 >= midScroll
      section = d3.select(el).attr("rel")
  section

scroll = Bacon.fromEventTarget(window, "scroll")
scroll.throttle(50).onValue toggleSticky
currentSectionId = scroll.throttle(100)
  .map(getSectionId)
  .toProperty()
  .skipDuplicates()

currentSectionId.onValue toggleCurrentSection
$(".nav-list a").click (e) ->
  toggleCurrentSection $(e.target).attr("href").substring(1)
