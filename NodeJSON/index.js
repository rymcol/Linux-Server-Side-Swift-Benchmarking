// Startpoint

// use cluster module, gain = 5000+ req/s

var numCPUs = 3;
var cluster = require('cluster');
if (cluster.isMaster) {
  // Fork workers.
  for (var i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
  cluster.on('exit', function(worker, code, signal) {
    console.log('worker ' + worker.pid + ' died');
  });
} else {
  require('./app/index');
}
