$(document).on('turbolinks:load', function() {
  if ($('#graph_canvas').attr('data-src') != undefined) {
    $.ajax({
      url: $('#graph_canvas').attr('data-src'),
      dataType: 'json',
      success: function(data) { draw_graph(data); },
      error: function(data) { alert('error'); }
    });
  }
});

function draw_graph(data) {
    "use strict"
    var width, height
    var chartWidth, chartHeight
    var margin

    d3.select("#svg").remove()
    var svg = d3.select("#graph_canvas").append("svg").attr("id", "svg")
    var chartLayer = svg.append("g").classed("chartLayer", true)
    
    setSize()
    drawChart(convertData(data))    
    
    function convertData(data) {
        var nodes = data.shift()
        var n_ary = nodes.map(function(d) { d['r'] = d.freq / 4 + 15; return d })
        var l_hash = {}
        var ctr = 0

        for (var n_links of data) {
          for (var link of n_links) {
            if (l_hash[link.id] == undefined) {
              l_hash[link.id] = { line_width: link.corr / 20, source: nodes[ctr] }
            } else { l_hash[link.id]['target'] = nodes[ctr] }
          }
          ctr++
        }
        return { nodes: n_ary, links: Object.values(l_hash) }
    }

    function setSize() {
        width = document.querySelector("#graph_canvas").clientWidth
        height = document.querySelector("#graph_canvas").clientHeight
    
        margin = { top:0, left:0, bottom:0, right:0 }
        chartWidth = width - (margin.left+margin.right)
        chartHeight = height - (margin.top+margin.bottom)
        
        svg.attr("width", width).attr("height", height)
        
        chartLayer
            .attr("width", chartWidth)
            .attr("height", chartHeight)
            .attr("transform", "translate("+[margin.left, margin.top]+")")
    }
    
    function drawChart(data) {
        var STEM_LENGTH=30 // the default length for links
        var simulation = d3.forceSimulation()
            .force("link", d3.forceLink().id(function(d) { return d.index }))
            .force("collide",d3.forceCollide(function(d) { return d.r + STEM_LENGTH }).iterations(16) )
            .force("charge", d3.forceManyBody())
            .force("center", d3.forceCenter(chartWidth / 2, chartHeight / 2))
            .force("y", d3.forceY(0))
            .force("x", d3.forceX(0))
    
        var link = svg.append("g")
            .attr("class", "links")
            .selectAll("line")
            .data(data.links)
            .enter()
            .append("line")
            .attr("stroke", "brown")
            .attr("stroke-width", function(d) { return d.line_width })
        
        var node_label = svg.append("g")
            .attr("class", "nodes")
            .selectAll("g")
            .data(data.nodes)
            .enter().append("g")
            .call(d3.drag()
                .on("start", dragstarted)
                .on("drag", dragged)
                .on("end", dragended));    

        var node = node_label.append("circle")
            .attr("r", function(d) { return d.r })
            .attr("fill", function(d) { return (d.freq > 60.0) ?
                                   "moccasin" : (d.freq > 20.0) ?
                                   "lemonchiffon" : (d.freq > 5.0) ?
                                   "beige" : "lavender" });

        var label = node_label.append("text")
            .attr("text-anchor", "middle")
            .attr("font-family", "Arial")
            .attr("dy", "0.5em")
            .attr("font-size", function(d) {return d.r / 1.5; })
            .text(function(d) { return d.word; })

        var ticked = function() {
            link
                .attr("x1", function(d) { return d.source.x; })
                .attr("y1", function(d) { return d.source.y; })
                .attr("x2", function(d) { return d.target.x; })
                .attr("y2", function(d) { return d.target.y; });

            node_label
                .attr("transform", 
                  function(d) { 
                    return "translate("+d.x+","+d.y+")";
                  })
        }  
        
        simulation
            .nodes(data.nodes)
            .on("tick", ticked);
    
        simulation.force("link")
            .links(data.links);    
        
        function dragstarted(d) {
            if (!d3.event.active) simulation.alphaTarget(0.1).restart();
            d.fx = d.x;
            d.fy = d.y;
        }
        
        function dragged(d) {
            d.fx = d3.event.x;
            d.fy = d3.event.y;
        }
        
        function dragended(d) {
            if (!d3.event.active) simulation.alphaTarget(0);
            d.fx = null;
            d.fy = null;
        } 
    }
}
