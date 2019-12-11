import {select as d3Select} from 'd3-selection'
import cloud from 'd3-cloud'

var skillset = document.getElementsByClassName('skillset')[0]
var wordsSource = JSON.parse(skillset.dataset.skills)

var wordSizeIndex = {}
var words = []
for (const size in wordsSource) {
  wordsSource[size].forEach((word) => {
    wordSizeIndex[word] = size
    words.push(word)
  })
}

var toRemove = [
  skillset.getElementsByClassName('skillset-body')[0],
  document.getElementsByClassName('skillset-title')[0]
]


var layout = cloud()
    .size([skillset.clientWidth * 0.8, skillset.clientHeight])
    .words(words.map(function(d) {
      return {text: d, size: wordSizeIndex[d] * 10};
    }))
    .padding(5)
    .rotate(0)
    .font("serif")
    .fontSize(function(d) { return d.size; })
    .on("end", draw);

function draw(words) {
  d3Select("div.skillset").append("svg")
      .attr('viewBox', `0 0 ${layout.size()[0]}  ${layout.size()[1]}`)
      .attr("preserveAspectRatio", "xMinYMin meet")
    .append("g")
      .attr("transform", "translate(" + layout.size()[0] / 2 + "," + layout.size()[1] / 2 + ")")
    .selectAll("text")
      .data(words)
    .enter().append("text")
      .style("font-size", function(d) { return d.size + "px"; })
      .style("font-family", "Arimo")
      .style("font-weight", "500")
      .attr("text-anchor", "middle")
      .style("fill", function(d) {
        return 'rgb(' + wordSizeIndex[d.text] * 20  + ', 24, 24)'
      })
      .attr("transform", function(d) {
        return "translate(" + [d.x * 1.05, d.y] + ")rotate(" + d.rotate + ")";
      })
      .text(function(d) { return d.text; });
}

export default function () {

  layout.start();

  toRemove.forEach((remove) => remove.remove())

}