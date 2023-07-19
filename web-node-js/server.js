const os = require('os');
const http = require('http');

const port = 3000;
const hostname = os.hostname();
const server = http.createServer((req, res) => {
    res.setHeader("Content-Type", "text/html");
    switch (req.url) {
        case "/":
            res.writeHead(200);
            res.end(
                `<html>
                <head>
                <title>Main Page</title>
                    <style>

                    body { 
                      background-color: #282c34;
                      min-height: 100vh;
                      display: flex;
                      flex-direction: column;
                      align-items: center;
                      justify-content: center;
                      font-size: calc(10px + 2vmin);
                      color: white;
                    }
                    </style>
                    </head>
                    <body>
                        <h1>Hello from ${hostname}!</h1>
                    </body>
                </html>`);
            break
        case "/healthcheck":
            const origin = req.headers.host
            console.log(origin)
            const message = "Webserver:" + " " +  hostname + " " + "Load Balancer: " + origin;
            res.writeHead(200);
            res.end(message);
            break
    }
   
});
server.listen(port, () => {
    console.log(`Server running at http://127.0.0.1:${port}/`);
  });
console.log(`Hostname: ${hostname}`);
console.log(`Hello, World from ${hostname}!`);