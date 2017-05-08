//Chart.js 

/////////////////
// Bar Graph 1 //
/////////////////

var barChartData = {
    labels: ["2016", "2017", "2018", "2019", "2020", "2021"],
    datasets: [{
        label: 'Current Investment Path EBITDA',
        backgroundColor: "#ff6976",
        data: [-0.1, 0.3, 1.8, 2.9, 4.3, 5.4]
    }, {
        label: 'Current Investment Path PBT',
        backgroundColor: "#0078b4",
        data: [-0.1, 0, 1.4, 6.2, 11.9, 19.7],
    }, {
        /* type: 'line',*/
        label: 'Strategic Investment Possibilities EBITDA',
        backgroundColor: "#ff1125",
        data: [-1.2, 0, 1.3, 2.4, 3.6, 4.4]
    }, {
       /* type: 'line',*/
        label: 'Strategic Investment Possibilities PBT',
        backgroundColor: "#262261",
        data: [-1.2, -0.9, 0.1, 4.2, 10.2, 18.8]
    }, ]

};

var canvas8 = function(){
        var ctx = document.getElementById("canvas1").getContext("2d");
        myBar = new Chart(ctx, {
            type: 'bar',
            data: barChartData,
            options: {
              responsive: true,
              maintainAspectRatio:true,
              scales: { 
                xAxes: [{
                  gridLines:{
                 /*  color:"#3e3e3e",
                   zeroLineColor:"#3e3e3e" */
                 }
                }],
                yAxes: [{
                  ticks: {
                   suggestedMax: 25,    // minimum will be 0, unless there is a lower value.
                  },
                  scaleLabel: {
                    display: true,
                    labelString: '$ in millions'
                  },
                  gridLines:{
                /*  color:"#3e3e3e",
                  zeroLineColor:"#FAFAFA" */
                }
                }]
              },  
               events: false,
               tooltips: {
                  enabled: false
                },
                hover: {
                  animationDuration: 0
                },
                animation: {
                  duration: 3000,
                  onComplete: function() {
                    this.chart.controller.draw();
                    drawValue(this, 1);
                  },
                  onProgress: function(state) {
                    var animation = state.animationObject;
                    drawValue(this, animation.currentStep / animation.numSteps);
                  }
                }
            }
  });

  var myBar = null;

  Chart.defaults.global.defaultFontColor = "#000";
  // Font color for values inside the bar
  var insideFontColor = '111,111,111';
  // Font color for values above the bar
  var outsideFontColor = '171,171,170';
  // How close to the top edge bar can be before the value is put inside it
  var topThreshold = 20;

  var modifyCtx = function(ctx) {
    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
    ctx.textAlign = 'center';
    ctx.textBaseline = 'bottom';
    return ctx;
  };

  var fadeIn = function(ctx, obj, x, y, black, step) {
    var ctx = modifyCtx(ctx);
    var alpha = 0;
    ctx.fillStyle = black ? 'rgba(' + outsideFontColor + ',' + step + ')' : 'rgba(' + insideFontColor + ',' + step + ')';
    ctx.fillText(obj, x, y);
  };

  var drawValue = function(context, step) {
    var ctx = context.chart.ctx;

    context.data.datasets.forEach(function (dataset) {
      for (var i = 0; i < dataset.data.length; i++) {
        var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
        var textY = (model.y > topThreshold) ? model.y - 3 : model.y + 20;
        fadeIn(ctx, dataset.data[i], model.x, textY, model.y > topThreshold, step);
      }
    });
  };

};




/////////////////
// Stacked Bar Graph 1 //
/////////////////

var stackData = {
    labels: ["2012", "2030"],
    datasets: [{
        label: 'Low',
        backgroundColor: "#1149a7",
        data: [1.3, 1.9]
    }, {
        label: 'Medium',
        backgroundColor: "#0078b4",
        data: [3.6, 4.1],
    }, {
        label: 'High',
        backgroundColor: "#79b7e2",
        data: [1.0, 1.2]
    }]
};

var canvas12 = function(){
      var ctx = document.getElementById("canvas2").getContext("2d");
        myBar = new Chart(ctx, {
            type: 'bar',
            data: stackData,
            options: {
              responsive: true,
              maintainAspectRatio: false,
              title:{
                display:true,
                text:"Population"
              },
              scales: { 
                xAxes: [{
                  stacked: true,
                  gridLines:{
                 }
                }],
                yAxes: [{
                  stacked: true,
                  ticks: {
                   suggestedMax: 9,    // minimum will be 0, unless there is a lower value.
                  },
                  scaleLabel: {
                    display: true,
                    labelString: 'In millions'
                  },
                  gridLines:{
                }
                }]
              },  
               events: false,
               tooltips: {
                  enabled: false
                },
                hover: {
                  animationDuration: 0
                },
                animation: {
                  duration: 2000,
                  onComplete: function() {
                    this.chart.controller.draw();
                    drawValue(this, 1);
                  },
                  onProgress: function(state) {
                    var animation = state.animationObject;
                    drawValue(this, animation.currentStep / animation.numSteps);
                  }
                }
            }
  });

  var myBar = null;

  //Chart.defaults.global.defaultFontColor = "#D4D4D4";
  // Font color for values inside the bar
  // Font color for values above the bar
  var FontColor = '255,255,255';
  // How close to the top edge bar can be before the value is put inside it
  var topThreshold = 10;

  var modifyCtx = function(ctx) {
    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    return ctx;
  };

  var fadeIn = function(ctx, obj, x, y, black, step) {
    var ctx = modifyCtx(ctx);
    var alpha = 0;
    ctx.fillStyle = 'rgba(' + FontColor + ',' + step + ')';
    ctx.fillText(obj, x, y);
  };

  var drawValue = function(context, step) {
    var ctx = context.chart.ctx;

    context.data.datasets.forEach(function (dataset) {
      for (var i = 0; i < dataset.data.length; i++) {
        var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
        var textY = model.y + 25;
        fadeIn(ctx, dataset.data[i], model.x, textY, model.y > topThreshold, step);
      }
    });
  };

};







/////////////////
// Bar Graph 2 //
/////////////////

var stackData2 = {
    labels: ["M", "F", "Both", "M", "F", "Both", "M", "F", "Both"],
    datasets: [{
        label: '2012 Estimates',
        backgroundColor: "#ff6976",
        data: [3.0, 2.7, 5.8, 1.1, 1.1, 2.1, 2.9, 2.4, 5.2, 0.4, 0.5, 0.9]
    }, {
        label: '2030 Projections',
        backgroundColor: "#ff1125",
        data: [5.0, 3.8, 8.8, 1.8, 1.7, 3.5, 4.7, 3.8, 8.6, 0.7, 1.0, 1.7]
    } ]

};

var canvas12two = function(){
        var ctx = document.getElementById("canvas12-2").getContext("2d");
        myBar = new Chart(ctx, {
            type: 'bar',
            data: stackData2,
            options: {
               responsive: true,
               maintainAspectRatio: false,
               title:{
                display: true,
                text:"Incidence"
              },
              scales: { 
                xAxes: [{
                  stacked: true
                }],
                yAxes: [{
                  stacked: true,
                  ticks: {
                   suggestedMax: 16,    // minimum will be 0, unless there is a lower value.
                  },
                  gridLines:{
                /*  color:"#3e3e3e",
                  zeroLineColor:"#FAFAFA" */
                }
                }]
              },  
              events: false,
              animation: {
                duration: 2000,
                onComplete: function() {
                    this.chart.controller.draw();
                    drawValue(this, 1);
                  },
                  onProgress: function(state) {
                    var animation = state.animationObject;
                    drawValue(this, animation.currentStep / animation.numSteps);
                  }
              }
            }
  });

  var myBar = null;
  // Font color for values above the bar
  var FontColor = '255,255,255';
  // How close to the top edge bar can be before the value is put inside it
  var topThreshold = 10;

  var modifyCtx = function(ctx) {
    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    return ctx;
  };

  var fadeIn = function(ctx, obj, x, y, black, step) {
    var ctx = modifyCtx(ctx);
    var alpha = 0;
    ctx.fillStyle = 'rgba(' + FontColor + ',' + step + ')';
    ctx.fillText(obj, x, y);
  };

  var drawValue = function(context, step) {
    var ctx = context.chart.ctx;

    context.data.datasets.forEach(function (dataset) {
      for (var i = 0; i < dataset.data.length; i++) {
        var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
        var textY = model.y + 20;
        fadeIn(ctx, dataset.data[i], model.x, textY, model.y > topThreshold, step);
      }
    });
  };


};






/////////////////
// Bar Graph 2 //
/////////////////

var horizChartData = {
    labels: ["Australia/New Zealand", "North America", "Western Europe", "More developed regions", "Northern Europe", "Southern Europe", "Central and Eastern Europe", "Polynesia", "Eastern Asia", "Southern Africa", "Caribbean","South America","World","Micronesia","Western Asia","Less developed regions","Melanesia","South-Eastern Asia","Northern Africa","Central America","Eastern Africa","South-Central Asia" ],
    datasets: [{
        label: 'Males',
        backgroundColor: "#fa1405",
        data: [365.3, 344.2, 334.7, 307.1, 298.4, 297.6, 260.2, 226.4, 225.1, 210.3, 207.7, 206.7, 204.9, 202.1, 192.8, 163, 152.1, 147.6, 133.5, 125.8, 120.7, 98.4]
    }, {
        label: 'Females',
        backgroundColor: "#0eadfd",
        data: [277.9, 295.4, 258.8, 239.9, 263.9, 220.4, 193.5, 181.6, 151.9, 161.1, 168, 180.6, 165.2, 146.3, 150.2, 135.8, 182.1, 132.6, 127.7, 141.9, 154.7, 103.3 ],
    } ]

};


var canvas13 = function(){
 var ctx = document.getElementById("canvas3").getContext("2d");
        myBar = new Chart(ctx, {
            type: 'horizontalBar',
            data: horizChartData,
            options: {
               responsive: true,
               maintainAspectRatio: false,
               title:{
                display: true,
                text:"Incidence"
              },
              scales: { 
                xAxes: [{
                  stacked: true
                }],
                yAxes: [{
                  stacked: true,
                  ticks: {
                   suggestedMax: 16,    // minimum will be 0, unless there is a lower value.
                  },
                  gridLines:{
                /*  color:"#3e3e3e",
                  zeroLineColor:"#FAFAFA" */
                }
                }]
              },  
              events: false,
              animation: {
                duration: 2000,
                onComplete: function() {
                    this.chart.controller.draw();
                    drawValue(this, 1);
                  },
                  onProgress: function(state) {
                    var animation = state.animationObject;
                    drawValue(this, animation.currentStep / animation.numSteps);
                  }
              }
            }
  });

  var myBar = null;
  // Font color for values above the bar
  var FontColor = '255,255,255';
  // How close to the top edge bar can be before the value is put inside it
  var topThreshold = 10;

  var modifyCtx = function(ctx) {
    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    return ctx;
  };

  var fadeIn = function(ctx, obj, x, y, black, step) {
    var ctx = modifyCtx(ctx);
    var alpha = 0;
    ctx.fillStyle = 'rgba(' + FontColor + ',' + step + ')';
    ctx.fillText(obj, x, y);
  };

  var drawValue = function(context, step) {
    var ctx = context.chart.ctx;

    context.data.datasets.forEach(function (dataset) {
      for (var i = 0; i < dataset.data.length; i++) {
        var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
        var textY = model.y + 0;
        var textX = model.x - 30;
        fadeIn(ctx, dataset.data[i], textX, textY, model.y > topThreshold, step);
      }
    });
  };


};









/////////////////
// Horizontal Bar Graph //
/////////////////

var horizData = {
    labels: ["Lung","Liver","Colorectal","Stomach","Breast" ],
    datasets: [{
      label: "Cases in 100,000s",
      backgroundColor: "#262261",
      data: [16.90, 7.88, 7.74, 7.54, 5.71 ]
    }]
};

var canvas14 = function(){
    var ctx = document.getElementById("canvas14").getContext("2d");
    myBar = new Chart(ctx, {
        type: 'horizontalBar',
        data: horizData,
        options: {
          responsive:true,
          scales: { 
            xAxes: [{
              position: "top",
              gridLines:{
             /*  color:"#3e3e3e",
               zeroLineColor:"#3e3e3e" */
             }
            }],
            yAxes: [{
              ticks: {
               suggestedMax: 25,    // minimum will be 0, unless there is a lower value.
              },
              gridLines:{
            /*  color:"#3e3e3e",
              zeroLineColor:"#FAFAFA" */
            }
            }]
          },  
           events: false,
           tooltips: {
              enabled: false
            },
            hover: {
              animationDuration: 0
            },
            animation: {
              duration: 3000,
              onComplete: function() {
                this.chart.controller.draw();
                drawValue(this, 1);
                var chartInstance = this.chart;
                var ctx = chartInstance.ctx;
                ctx.textAlign = "left";
                ctx.font = "9px";
                ctx.fillStyle = "#fff";

                Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
                  var meta = chartInstance.controller.getDatasetMeta(i);
                  Chart.helpers.each(meta.data.forEach(function (bar, index) {
                    data = dataset.data[index];
                        ctx.fillText(data, bar._model.x-35, bar._model.y-7);
                  }),this)
                }),this);
              },
              onProgress: function(state) {
                var animation = state.animationObject;
                drawValue(this, animation.currentStep / animation.numSteps);
              }
            }
        }
  });

  var myBar = null;

  Chart.defaults.global.defaultFontColor = "#000";
  // Font color for values inside the bar
  var insideFontColor = '55,55,55';
  // Font color for values above the bar
  var outsideFontColor = '200,207,200';
  // How close to the top edge bar can be before the value is put inside it
  var topThreshold = 20;

  var modifyCtx = function(ctx) {
    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
    ctx.textAlign = 'left';
    ctx.textBaseline = 'hanging';
    return ctx;
  };

  var fadeIn = function(ctx, obj, x, y, black, step) {
    var ctx = modifyCtx(ctx);
    var alpha = 0;
    ctx.fillStyle = black ? 'rgba(' + outsideFontColor + ',' + step + ')' : 'rgba(' + insideFontColor + ',' + step + ')';
    ctx.fillText(obj, x, y);
  };

  var drawValue = function(context, step) {
    var ctx = context.chart.ctx;
  };

};



var pie14 = function(){ 

  var dataset = [24.31, 1.10, 6.02, 7.79, 12.7, 48.08];

  var labels = ['Europe 24.3%', 'Africa 1.10%', 'Latin America 7.79%', 'Oceania 1.1%', 'North America 12.7%', 'Asia 48.1%'];

  // let colors = ['#8dd3c7', '#ffffb3', '#bebada', '#fb8072', '#80b1d3', '#fdb462', '#b3de69', '#fccde5', '#d9d9d9', '#bc80bd'];
  // let colors = ['#67001f', '#b2182b', '#d6604d', '#f4a582', '#fddbc7', '#e0e0e0', '#bababa', '#878787', '#4d4d4d', '#1a1a1a'];
  var colors = ["#0078b4", "#4039ad", "#2ecc71", "#333", "#fa1405", "#2a2577"];

  var width = document.querySelector("#pieChart14").offsetWidth,
      height = document.querySelector("#pieChart14").offsetHeight,
      minOfWH = Math.min(width, height) / 2,
      initialAnimDelay = 300,
      arcAnimDelay = 150,
      arcAnimDur = 3000,
      secDur = 500,
      secIndividualdelay = 160;

  var radius;

  // calculate minimum of width and height to set chart radius
  if (minOfWH > 150) {
    radius = 150;
  } else {
    radius = minOfWH;
  }

  // append svg
  var svg = d3.select("#pieChart14").append("svg").attr({
    width: width,
    height: height,
    class: "pieChart"
  }).append("g");

  svg.attr({
    transform: 'translate(' + width / 2 + ', ' + height / 2 + ')'
  });

  // for drawing slices
  var arc = d3.svg.arc().outerRadius(radius * 0.7).innerRadius(radius * 0.45);

  // for labels and polylines
  var outerArc = d3.svg.arc().innerRadius(radius * 0.85).outerRadius(radius * 0.85);

  // d3 color generator
  // let c10 = d3.scale.category10();

  var pie = d3.layout.pie().value(function (d) {
    return d;
  }).sort(null);

  var draw = function draw() {
    svg.append("g").attr("class", "lines");
    svg.append("g").attr("class", "slices");
    svg.append("g").attr("class", "labels");

    // define slice
    var slice = svg.select(".slices").datum(dataset).selectAll("path").data(pie);
    slice.enter().append("path").attr({
      fill: function fill(d, i) {
        return colors[i];
      },
      d: arc,
      "stroke-width": "12px"
    }).attr("transform", function (d, i) {
      return "rotate(-180, 0, 0)";
    }).style("opacity", 0).transition().delay(function (d, i) {
      return i * arcAnimDelay + initialAnimDelay;
    }).duration(arcAnimDur).ease("elastic").style("opacity", 1).attr("transform", "rotate(0,0,0)");

    slice.transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).attr("stroke-width", "3px");

    var midAngle = function midAngle(d) {
      return d.startAngle + (d.endAngle - d.startAngle) / 2;
    };

    var text = svg.select(".labels").selectAll("text").data(pie(dataset));

    text.enter().append("text").attr("dy", "0.3em").style("opacity", 0).style("fill", function (d, i) {
      return colors[i];
    }).text(function (d, i) {
      return labels[i];
    }).attr("transform", function (d) {
      // calculate outerArc centroid for 'this' slice
      var pos = outerArc.centroid(d);
      // define left and right alignment of text labels
      pos[0] = radius * (midAngle(d) < Math.PI ? 1 : -1);
      return 'translate(' + pos + ')';
    }).style("text-anchor", function (d) {
      return midAngle(d) < Math.PI ? "start" : "end";
    }).transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).style("opacity", 1);

    var polyline = svg.select(".lines").selectAll("polyline").data(pie(dataset));

    polyline.enter().append("polyline").style("opacity", 0.5).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), arc.centroid(d), arc.centroid(d)];
    }).transition().duration(secDur).delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), outerArc.centroid(d), pos];
    });
  };

  draw();

  var button = document.querySelector("button");

  var replay = function replay() {
    d3.selectAll(".slices").transition().ease("back").duration(500).delay(0).style("opacity", 0).attr("transform", "translate(0, 250)").remove();
    d3.selectAll(".lines").transition().ease("back").duration(500).delay(100).style("opacity", 0).attr("transform", "translate(0, 250)").remove();
    d3.selectAll(".labels").transition().ease("back").duration(500).delay(200).style("opacity", 0).attr("transform", "translate(0, 250)").remove();

    setTimeout(draw, 800);
  };
};


/////////////////
// 2nd D3 Pie Chart //
/////////////////

var pie15 = function(){

  var dataset = [7.2, 7.8, 4.4, 3.8, 1.1, 12.7, 16.8, 21.8, 24.4 ];

  var labels = ['India 7.21%', 'Latin America/Caribbean 7.8%', 'Sub-Sahara Africa 4.4%', 'Middle East & North Africa 3.8%', 'Oceania 1.1%', 'North America 12.7%', 'East & Central Asia 16.8%', 'China 21.8%', 'Europe 24.4%', ];

  // var colors = ['#67001f', '#b2182b', '#d6604d', '#f4a582', '#fddbc7', '#e0e0e0', '#bababa', '#878787', '#4d4d4d'];
  var colors = ["#0078b4", "#f2bc03", "#2ecc71", "#999", "#ae0707", "#2a2577", '#f88419', '#fa1405', '#4039ad'];

  var width = document.querySelector("#pieChart15").offsetWidth,
      height = document.querySelector("#pieChart15").offsetHeight,
      minOfWH = Math.min(width, height) / 2,
      initialAnimDelay = 400,
      arcAnimDelay = 10,
      arcAnimDur = 2800,
      secDur = 1000,
      secIndividualdelay = 160;

  var radius;

  // calculate minimum of width and height to set chart radius
  if (minOfWH > 125) {
    radius = 125;
  } else {
    radius = minOfWH;
  }

  // append svg
  var svg = d3.select("#pieChart15").append("svg").attr({
    width: width,
    height: height,
    class: "pieChart"
  }).append("g");

  svg.attr({
    transform: 'translate(' + width / 2 + ', ' + height / 2 + ')'
  });

  // for drawing slices
  var arc = d3.svg.arc().outerRadius(radius * 0.7).innerRadius(radius * 0.45);

  // for labels and polylines
  var outerArc = d3.svg.arc().innerRadius(radius * 0.85).outerRadius(radius * 0.85);

  // d3 color generator
  // let c10 = d3.scale.category10();

  var pie = d3.layout.pie().value(function (d) {
    return d;
  }).sort(null);

  var draw = function draw() {
    svg.append("g").attr("class", "lines");
    svg.append("g").attr("class", "slices");
    svg.append("g").attr("class", "labels");

    // define slice
    var slice = svg.select(".slices").datum(dataset).selectAll("path").data(pie);
    slice.enter().append("path").attr({
      fill: function fill(d, i) {
        return colors[i];
      },
      d: arc,
      "stroke-width": "10px"
    }).attr("transform", function (d, i) {
      return "rotate(-180, 0, 0)";
    }).style("opacity", 0).transition().delay(function (d, i) {
      return i * arcAnimDelay + initialAnimDelay;
    }).duration(arcAnimDur).ease("elastic").style("opacity", 1).attr("transform", "rotate(0,0,0)");

    slice.transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).attr("stroke-width", "2px");

    var midAngle = function midAngle(d) {
      return d.startAngle + (d.endAngle - d.startAngle) / 2;
    };

    var text = svg.select(".labels").selectAll("text").data(pie(dataset));

    text.enter().append("text").attr("dy", "0.3em").style("opacity", 0).style("fill", function (d, i) {
      return colors[i];
    }).text(function (d, i) {
      return labels[i];
    }).attr("transform", function (d) {
      // calculate outerArc centroid for 'this' slice
      var pos = outerArc.centroid(d);
      // define left and right alignment of text labels
      pos[0] = radius * (midAngle(d) < Math.PI ? 1 : -1);
      return 'translate(' + pos + ')';
    }).style("text-anchor", function (d) {
      return midAngle(d) < Math.PI ? "start" : "end";
    }).transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).style("opacity", 1);

    var polyline = svg.select(".lines").selectAll("polyline").data(pie(dataset));

    polyline.enter().append("polyline").style("opacity", 0.5).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), arc.centroid(d), arc.centroid(d)];
    }).transition().duration(secDur).delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), outerArc.centroid(d), pos];
    });
  };

  draw();

  var button = document.querySelector("button");

  var replay = function replay() {
    d3.selectAll(".slices").transition().ease("back").duration(500).delay(0).style("opacity", 0).attr("transform", "translate(0, 250)").remove();
    d3.selectAll(".lines").transition().ease("back").duration(500).delay(100).style("opacity", 0).attr("transform", "translate(0, 250)").remove();
    d3.selectAll(".labels").transition().ease("back").duration(500).delay(200).style("opacity", 0).attr("transform", "translate(0, 250)").remove();

    setTimeout(draw, 800);
  };
};





/////////////////
// 3rd D3 Pie Chart
/////////////////

var pie15two = function() {

  var dataset = [ 8.3, 7.4, 5.5, 4.1, 0.8, 17.3, 16.8, 21.4, 26.9 ];

  var labels = [ 'India 8.3%', 'Latin America/Caribbean 7.4%', 'Sub-Sahara Africa 5.5%', 'Middle East & North Africa 4.1%', 'Oceania 0.8%', 'North America 8.4%', 'East & Central Asia 17.3%', 'China 21.4%',  'Europe 24.4%',];

  // var colors = ['#8dd3c7', '#ffffb3', '#bebada', '#fb8072', '#80b1d3', '#fdb462', '#b3de69', '#fccde5', '#d9d9d9'];
  // var colors = ['#67001f', '#b2182b', '#d6604d', '#f4a582', '#fddbc7', '#e0e0e0', '#bababa', '#878787', '#4d4d4d'];
   var colors = ["#0078b4", "#f2bc03", "#2ecc71", "#999", "#ae0707", "#2a2577", '#f88419', '#fa1405', '#4039ad'];

  var width = document.querySelector("#pieChart15two").offsetWidth,
      height = document.querySelector("#pieChart15two").offsetHeight,
      minOfWH = Math.min(width, height) / 2,
      initialAnimDelay = 400,
      arcAnimDelay = 10,
      arcAnimDur = 2800,
      secDur = 1000,
      secIndividualdelay = 160;

  var radius;

  // calculate minimum of width and height to set chart radius
  if (minOfWH > 125) {
    radius = 125;
  } else {
    radius = minOfWH;
  }

  // append svg
  var svg = d3.select("#pieChart15two").append("svg").attr({
    width: width,
    height: height,
    class: "pieChart"
  }).append("g");

  svg.attr({
    transform: 'translate(' + width / 2 + ', ' + height / 2 + ')'
  });

  // for drawing slices
  var arc = d3.svg.arc().outerRadius(radius * 0.7).innerRadius(radius * 0.45);

  // for labels and polylines
  var outerArc = d3.svg.arc().innerRadius(radius * 0.85).outerRadius(radius * 0.85);

  // d3 color generator
  // let c10 = d3.scale.category10();

  var pie = d3.layout.pie().value(function (d) {
    return d;
  }).sort(null);

  var draw = function draw() {
    svg.append("g").attr("class", "lines");
    svg.append("g").attr("class", "slices");
    svg.append("g").attr("class", "labels");

    // define slice
    var slice = svg.select(".slices").datum(dataset).selectAll("path").data(pie);
    slice.enter().append("path").attr({
      fill: function fill(d, i) {
        return colors[i];
      },
      d: arc,
      "stroke-width": "10px"
    }).attr("transform", function (d, i) {
      return "rotate(-180, 0, 0)";
    }).style("opacity", 0).transition().delay(function (d, i) {
      return i * arcAnimDelay + initialAnimDelay;
    }).duration(arcAnimDur).ease("elastic").style("opacity", 1).attr("transform", "rotate(0,0,0)");

    slice.transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).attr("stroke-width", "2px");

    var midAngle = function midAngle(d) {
      return d.startAngle + (d.endAngle - d.startAngle) / 2;
    };

    var text = svg.select(".labels").selectAll("text").data(pie(dataset));

    text.enter().append("text").attr("dy", "0.35em").style("opacity", 0).style("fill", function (d, i) {
      return colors[i];
    }).text(function (d, i) {
      return labels[i];
    }).attr("transform", function (d) {
      // calculate outerArc centroid for 'this' slice
      var pos = outerArc.centroid(d);
      // define left and right alignment of text labels
      pos[0] = radius * (midAngle(d) < Math.PI ? 1 : -1);
      return 'translate(' + pos + ')';
    }).style("text-anchor", function (d) {
      return midAngle(d) < Math.PI ? "start" : "end";
    }).transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).style("opacity", 1);

    var polyline = svg.select(".lines").selectAll("polyline").data(pie(dataset));

    polyline.enter().append("polyline").style("opacity", 0.5).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), arc.centroid(d), arc.centroid(d)];
    }).transition().duration(secDur).delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), outerArc.centroid(d), pos];
    });
  };

  draw();

};




/////////////////
// 4th D3 Pie Chart
/////////////////

var pie16 = function() {

  var dataset = [ 30.5, 11.5, 70.4, 30, 22 ];

  var labels = [ 'China 306.5%', 'India 101.5%', 'Japan 70.4%', 'Indonesia 30.0%', 'Rep. of Korea 22.0%'];

  // var colors = ['#8dd3c7', '#ffffb3', '#bebada', '#fb8072', '#80b1d3', '#fdb462', '#b3de69', '#fccde5', '#d9d9d9'];
  // var colors = ['#67001f', '#b2182b', '#d6604d', '#f4a582', '#fddbc7', '#e0e0e0', '#bababa', '#878787', '#4d4d4d'];
   var colors = ["#0078b4", "#f2bc03", "#2ecc71", "#ae0707", "#2a2577", '#fa1405'];

  var width = document.querySelector("#pieChart16").offsetWidth,
      height = document.querySelector("#pieChart16").offsetHeight,
      minOfWH = Math.min(width, height) / 2,
      initialAnimDelay = 300,
      arcAnimDelay = 150,
      arcAnimDur = 3000,
      secDur = 1000,
      secIndividualdelay = 150;

  var radius;

  // calculate minimum of width and height to set chart radius
  if (minOfWH > 175) {
    radius = 175;
  } else {
    radius = minOfWH;
  }

  // append svg
  var svg = d3.select("#pieChart16").append("svg").attr({
    width: width,
    height: height,
    class: "pieChart"
  }).append("g");

  svg.attr({
    transform: 'translate(' + width / 2 + ', ' + height / 2 + ')'
  });

  // for drawing slices
  var arc = d3.svg.arc().outerRadius(radius * 0.7).innerRadius(radius * 0.45);

  // for labels and polylines
  var outerArc = d3.svg.arc().innerRadius(radius * 0.85).outerRadius(radius * 0.85);

  // d3 color generator
  // let c10 = d3.scale.category10();

  var pie = d3.layout.pie().value(function (d) {
    return d;
  }).sort(null);

  var draw = function draw() {
    svg.append("g").attr("class", "lines");
    svg.append("g").attr("class", "slices");
    svg.append("g").attr("class", "labels");

    // define slice
    var slice = svg.select(".slices").datum(dataset).selectAll("path").data(pie);
    slice.enter().append("path").attr({
      fill: function fill(d, i) {
        return colors[i];
      },
      d: arc,
      "stroke-width": "20px"
    }).attr("transform", function (d, i) {
      return "rotate(-180, 0, 0)";
    }).style("opacity", 0).transition().delay(function (d, i) {
      return i * arcAnimDelay + initialAnimDelay;
    }).duration(arcAnimDur).ease("elastic").style("opacity", 1).attr("transform", "rotate(0,0,0)");

    slice.transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).attr("stroke-width", "2px");

    var midAngle = function midAngle(d) {
      return d.startAngle + (d.endAngle - d.startAngle) / 2;
    };

    var text = svg.select(".labels").selectAll("text").data(pie(dataset));

    text.enter().append("text").attr("dy", "0.35em").style("opacity", 0).style("fill", function (d, i) {
      return colors[i];
    }).text(function (d, i) {
      return labels[i];
    }).attr("transform", function (d) {
      // calculate outerArc centroid for 'this' slice
      var pos = outerArc.centroid(d);
      // define left and right alignment of text labels
      pos[0] = radius * (midAngle(d) < Math.PI ? 1 : -1);
      return 'translate(' + pos + ')';
    }).style("text-anchor", function (d) {
      return midAngle(d) < Math.PI ? "start" : "end";
    }).transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).style("opacity", 1);

    var polyline = svg.select(".lines").selectAll("polyline").data(pie(dataset));

    polyline.enter().append("polyline").style("opacity", 0.5).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), arc.centroid(d), arc.centroid(d)];
    }).transition().duration(secDur).delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), outerArc.centroid(d), pos];
    });
  };

  draw();

};







/////////////////
// 4th D3 Pie Chart
/////////////////

var pie17 = function() {

  var dataset = [ 19, 9, 6, 4, 3, 3, 9, 5, 4, 32];

  var labels = [ 'Lung 19%', 'Stomach 9%', 'Breast 6%', 'Pancreas 4%', 'Cervix Uteri 3%', 'Liver 9%', 'Colerectum 9%', 'Oesophagus 5%', 'Prostate 4%', 'Other 32%'];

  // var colors = ['#8dd3c7', '#ffffb3', '#bebada', '#fb8072', '#80b1d3', '#fdb462', '#b3de69', '#fccde5', '#d9d9d9'];
  // var colors = ['#67001f', '#b2182b', '#d6604d', '#f4a582', '#fddbc7', '#e0e0e0', '#bababa', '#878787', '#4d4d4d'];
  var colors = ['#fa1405', "#0078b4", "#4039ad", "#f2bc03", "#2ecc71", "#ae0707", "#2a2577",  '#878787', '#bababa', '#e0e0e0',];

  var width = document.querySelector("#pieChart17").offsetWidth,
      height = document.querySelector("#pieChart17").offsetHeight,
      minOfWH = Math.min(width, height) / 2,
      initialAnimDelay = 300,
      arcAnimDelay = 150,
      arcAnimDur = 3000,
      secDur = 1000,
      secIndividualdelay = 150;

  var radius;

  // calculate minimum of width and height to set chart radius
  if (minOfWH > 165) {
    radius = 165;
  } else {
    radius = minOfWH;
  }

  // append svg
  var svg = d3.select("#pieChart17").append("svg").attr({
    width: width,
    height: height,
    class: "pieChart"
  }).append("g");

  svg.attr({
    transform: 'translate(' + width / 2 + ', ' + height / 2 + ')'
  });

  // for drawing slices
  var arc = d3.svg.arc().outerRadius(radius * 0.7).innerRadius(radius * 0.45);

  // for labels and polylines
  var outerArc = d3.svg.arc().innerRadius(radius * 0.85).outerRadius(radius * 0.85);

  // d3 color generator
  // let c10 = d3.scale.category10();

  var pie = d3.layout.pie().value(function (d) {
    return d;
  }).sort(null);

  var draw = function draw() {
    svg.append("g").attr("class", "lines");
    svg.append("g").attr("class", "slices");
    svg.append("g").attr("class", "labels");

    // define slice
    var slice = svg.select(".slices").datum(dataset).selectAll("path").data(pie);
    slice.enter().append("path").attr({
      fill: function fill(d, i) {
        return colors[i];
      },
      d: arc,
      "stroke-width": "10px"
    }).attr("transform", function (d, i) {
      return "rotate(-180, 0, 0)";
    }).style("opacity", 0).transition().delay(function (d, i) {
      return i * arcAnimDelay + initialAnimDelay;
    }).duration(arcAnimDur).ease("elastic").style("opacity", 1).attr("transform", "rotate(0,0,0)");

    slice.transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).attr("stroke-width", "2px");

    var midAngle = function midAngle(d) {
      return d.startAngle + (d.endAngle - d.startAngle) / 2;
    };

    var text = svg.select(".labels").selectAll("text").data(pie(dataset));

    text.enter().append("text").attr("dy", "0.35em").style("opacity", 0).style("fill", function (d, i) {
      return colors[i];
    }).text(function (d, i) {
      return labels[i];
    }).attr("transform", function (d) {
      // calculate outerArc centroid for 'this' slice
      var pos = outerArc.centroid(d);
      // define left and right alignment of text labels
      pos[0] = radius * (midAngle(d) < Math.PI ? 1 : -1);
      return 'translate(' + pos + ')';
    }).style("text-anchor", function (d) {
      return midAngle(d) < Math.PI ? "start" : "end";
    }).transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).style("opacity", 1);

    var polyline = svg.select(".lines").selectAll("polyline").data(pie(dataset));

    polyline.enter().append("polyline").style("opacity", 0.5).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), arc.centroid(d), arc.centroid(d)];
    }).transition().duration(secDur).delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), outerArc.centroid(d), pos];
    });
  };

  draw();

};






/////////////////
// 5th D3 Pie Chart
/////////////////

var pie20 = function() {

  var dataset = [ 23.5, 1.96, 4.60, 0.24, 35.83,  0.63, 28.97, 4.25];

  var labels = [ 'Founders 23.5%', ' Key Employees/Trust 1.96%', 'Erasmic Venture Fund Ltd. 4.60%', 'Individual Investors 0.24%', 'Norwest Venture Partners 35.83%','SVB India 0.63%', 'IDG Venture India 28.97%','ESOP Pool 4.25%' ];

  // var colors = ['#8dd3c7', '#ffffb3', '#bebada', '#fb8072', '#80b1d3', '#fdb462', '#b3de69', '#fccde5', '#d9d9d9'];
  // var colors = ['#67001f', '#b2182b', '#d6604d', '#f4a582', '#fddbc7', '#e0e0e0', '#bababa', '#878787', '#4d4d4d'];
  var colors = ['#fa1405', "#0078b4", "#4039ad", "#f2bc03", "#2ecc71", "#ae0707", "#2a2577",  '#80b1d3',];

  var width = document.querySelector("#pieChart20").offsetWidth,
      height = document.querySelector("#pieChart20").offsetHeight,
      minOfWH = Math.min(width, height) / 2,
      initialAnimDelay = 300,
      arcAnimDelay = 150,
      arcAnimDur = 3000,
      secDur = 1000,
      secIndividualdelay = 150;

  var radius;

  // calculate minimum of width and height to set chart radius
  if (minOfWH > 175) {
    radius = 175;
  } else {
    radius = minOfWH;
  }

  // append svg
  var svg = d3.select("#pieChart20").append("svg").attr({
    width: width,
    height: height,
    class: "pieChart"
  }).append("g");

  svg.attr({
    transform: 'translate(' + width / 2 + ', ' + height / 2 + ')'
  });

  // for drawing slices
  var arc = d3.svg.arc().outerRadius(radius * 0.7).innerRadius(radius * 0.45);

  // for labels and polylines
  var outerArc = d3.svg.arc().innerRadius(radius * 0.85).outerRadius(radius * 0.85);

  // d3 color generator
  // let c10 = d3.scale.category10();

  var pie = d3.layout.pie().value(function (d) {
    return d;
  }).sort(null);

  var draw = function draw() {
    svg.append("g").attr("class", "lines");
    svg.append("g").attr("class", "slices");
    svg.append("g").attr("class", "labels");

    // define slice
    var slice = svg.select(".slices").datum(dataset).selectAll("path").data(pie);
    slice.enter().append("path").attr({
      fill: function fill(d, i) {
        return colors[i];
      },
      d: arc,
      "stroke-width": "40px"
    }).attr("transform", function (d, i) {
      return "rotate(-180, 0, 0)";
    }).style("opacity", 0).transition().delay(function (d, i) {
      return i * arcAnimDelay + initialAnimDelay;
    }).duration(arcAnimDur).ease("elastic").style("opacity", 1).attr("transform", "rotate(0,0,0)");

    slice.transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).attr("stroke-width", "2px");

    var midAngle = function midAngle(d) {
      return d.startAngle + (d.endAngle - d.startAngle) / 2;
    };

    var text = svg.select(".labels").selectAll("text").data(pie(dataset));

    text.enter().append("text").attr("dy", "0.35em").style("opacity", 0).style("fill", function (d, i) {
      return colors[i];
    }).text(function (d, i) {
      return labels[i];
    }).attr("transform", function (d) {
      // calculate outerArc centroid for 'this' slice
      var pos = outerArc.centroid(d);
      // define left and right alignment of text labels
      pos[0] = radius * (midAngle(d) < Math.PI ? 1 : -1);
      return 'translate(' + pos + ')';
    }).style("text-anchor", function (d) {
      return midAngle(d) < Math.PI ? "start" : "end";
    }).transition().delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).duration(secDur).style("opacity", 1);

    var polyline = svg.select(".lines").selectAll("polyline").data(pie(dataset));

    polyline.enter().append("polyline").style("opacity", 0.5).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), arc.centroid(d), arc.centroid(d)];
    }).transition().duration(secDur).delay(function (d, i) {
      return arcAnimDur + i * secIndividualdelay;
    }).attr("points", function (d) {
      var pos = outerArc.centroid(d);
      pos[0] = radius * 0.95 * (midAngle(d) < Math.PI ? 1 : -1);
      return [arc.centroid(d), outerArc.centroid(d), pos];
    });
  };

  draw();

};










