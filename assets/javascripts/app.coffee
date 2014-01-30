Bacon = require("bacon")
d3 = require("d3")

win = document.body
hero = d3.select("#hero")[0][0]
nav = d3.select("#nav-sticky")
staticNav = d3.select("#nav")
navList = d3.selectAll(".nav-list")
sticky = false
doc = document.documentElement

toggleSticky = ->
  top = (window.pageYOffset || doc.scrollTop)  - (doc.clientTop || 0)
  if not sticky and top > hero.offsetHeight
    nav.classed "hidden", false
    sticky = true
  else if sticky and top <= hero.offsetHeight
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

getOffsetLeft = (elem) ->
  offsetLeft = 0
  if !isNaN(elem.offsetLeft)
    offsetLeft += elem.offsetLeft
  while(elem = elem.offsetParent)
    if !isNaN(elem.offsetLeft)
      offsetLeft += elem.offsetLeft
  return offsetLeft

toggleCurrentSection = (sectionId) ->
  sections.filter("[rel=#{sectionId}]").classed "seen", true
  d3.selectAll(".nav-list .current").classed "current", false
  d3.selectAll(".nav-list [href='##{sectionId}']").classed "current", true

getSectionId = ->
  winHeight = win.offsetHeight
  midScroll = (window.pageYOffset || doc.scrollTop)  - (doc.clientTop || 0) + winHeight * 0.5
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

# Render countdown ring
start = new Date("November 29, 2013 14:40:00")
now = new Date().getTime()
end = new Date("February 01, 2014 00:00:00")
ratio = (now - start) / (end - start)

days = [100 * ratio, 100 - 100 * ratio]

width = 350
height = 300
radius = Math.max(width, height) / 2
colors = ["#333333", "#33CC99"]
pie = d3.layout.pie().sort(null)
arc = d3.svg.arc().innerRadius(radius - 65).outerRadius(radius - 50)
svg = d3.select("#countdown").append("svg")
  .attr("id", "countdown-graph")
  .attr("width", width)
  .attr("height", height)
  .append("g")
  .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")

path = svg.selectAll("path")
  .data(pie(days))
  .enter()
  .append("path")
  .attr("fill", (d, i) -> colors[i])
  .attr("d", arc)

d3.select(".days").text(Math.ceil((end - now) / (24 * 60 * 60 * 1000)))

d3.select("#scroll-button").on "click", ->
  navPos = getOffsetTop(d3.select("#nav")[0][0])
  scrollTo(navPos)

scrollTo = (pos) ->
  if (window.pageYOffset || doc.scrollTop)  - (doc.clientTop || 0) < pos
    window.scrollBy(0, 20)
    setTimeout ->
      scrollTo(pos)
    , 5
