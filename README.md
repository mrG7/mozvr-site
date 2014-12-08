
# MOZVR.com

Source for the mozvr.com site, built on the Wintersmith static site generator.

* Run `npm install` to install node module dependencies.
* Run `wintersmith preview` to generate a build of the site running on a local server.
* Run `wintersmith build` to generate a build of the site in the `/build` directory, ready to be uploaded to a server.
    - Note: to review build results from local, run a local server (eg http-server) from build directory after `wintersmith build` completes. Simply dragging build/index.html into the browser will not work, as relative patjs break (eg /css, /images, etc).
