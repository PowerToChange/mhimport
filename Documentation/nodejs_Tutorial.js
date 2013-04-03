
/**
 * @tutorial Tutorial_node.js
 * @parent index 2
 * @hide
 * ### node.js?
 *
 * * An overview of node.js
 *
 * 
 * @image ../../Documentation/node-logo.png 245 66
 */

//required to separate comment blocks for documentjs, please do not remove
var __filler;
/**
 * @tutorial Introduction
 * @parent Tutorial_node.js
 * 
 * ### What is node.js?
 *
 * * An event driven, asynchronous I/O software system.
 * * Supports the development of highly scalable web applications.
 * * Based on the V8 Javascript engine.
 * * Written in 2009 by Ryan Dahl, an employee of Joyent.
 * * The runtime environment is built into webOS which runs on the HP Touchpad
 *
 * 
 * @video http://www.youtube-nocookie.com/embed/jo_B4LTHi3I?rel=0&start=23 560 315
 */

//required to separate comment blocks for documentjs, please do not remove
var __filler;
/**
 * @tutorial Installation
 * @parent Tutorial_node.js
 * 
 * ### Installing node.js
 *
 * * Download the appropriate installer from the link above (or compile it yourself)
 *
 * 
 * @download http://nodejs.org/#download'>http://nodejs.org/#download
 */

//required to separate comment blocks for documentjs, please do not remove
var __filler;
/**
 * @tutorial Hello.World
 * @parent Tutorial_node.js
 * 
 * ### Creating a Hello World Web Server in node.js
 *
 * In this example, we'll create a simple web server which returns &quot;Hello World&quot; upon receiving a HTTP connection;
 * 
 * * Enter the following into a new text file;
 *
 * @codestart
 * var http = require('http'); 
 *    http.createServer(function (req, res) {
 *    res.writeHead(200, {'Content-Type': 'text/plain'}); 
 *    res.end('Hello World\n'); 
 * }).listen(1337, "127.0.0.1");
 * console.log('Server running at http://127.0.0.1:1337/');
 * @codeend
 *
 * * Save the file as &quot;helloworld.js&quot;
 * * Run &quot;node helloworld.js&quot; from your command line.
 * * Connect to &quot;http://localhost:1337&quot; on your browser to see the results.
 * 
 * ### Some Important Points
 * 
 * * node uses javascript terminology and syntax on the server side
 * * When a connection occurs, the callback function inside http.createServer is run. When the function terminates, node doesn't lock a thread or sleep while waiting for the next HTTP connection to occur
 */