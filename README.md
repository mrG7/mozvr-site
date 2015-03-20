# MozVR.com

Source for the [MozVR.com](http://mozvr.com/) site, built using the [Wintersmith](http://wintersmith.io/) static site generator.


## Installation

To install the [Node](https://nodejs.org/) dependencies:

    npm install


## Development

To generate a build of the site running on a local server:

    gulp preview

To generate a build of the site in the `build/` directory, ready to be uploaded to a server:

    gulp build

> **Note:** To review the build output, run a local server (e.g., [`http-server`](https://www.npmjs.com/package/http-server)) from the `build/` directory after `wintersmith build` completes. Simply loading `build/index.html` in the browser will not work, as relative paths break (e.g., `/css/`, `/images/`, etc.).
