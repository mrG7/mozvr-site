---
title: Web VR Lands in Firefox Nightly
date: 2015-01-16
template: post.jade
project-profile: 
project-link: 
project-source: 
splash: post-splash.jpg
thumb: post-thumb.png
intro: Today we're adding core VR support directly to Firefox Nightly builds.  Previously, users and content creators had to download a separate build of Firefox, which usually lagged behind ongoing development. From now on, VR capabilities will be developed alongside other continuous Firefox improvements.
author: vladvukicevic
---

<p class="intro h2">We’ve been working on adding VR capabilities to the Web for some months now, with the goal of making VR a first class citizen on the Web.  Today, we’re taking another step towards this by adding core VR support directly to our Firefox Nightly builds.  Previously, users and content creators had to download a separate build of Firefox, which usually lagged behind ongoing development. From now on, VR capabilities will be developed alongside other continuous Firefox improvements.</p>

In order to experience Web VR content with an Oculus Rift with Firefox Nightly builds today, you’ll need:

* Recent Firefox Nightly build, downloaded from [nightly.mozilla.org](http://nightly.mozilla.org/)
* "WebVR Oculus Rift Enabler" addon

The addon simply provides the Oculus Rift SDK library so that Firefox can access it. In the future, this functionality may be bundled directly with Firefox, or provided by Oculus Runtime itself.  The source for the addon, as well as build instructions, can be found here.

While VR support will be enabled in our Nightly and Developer Edition (Alpha) builds, it will currently be automatically disabled in Beta and Release builds. We hope to ship VR to our users in the future, currrently we’re still making rapid improvements and changes to both VR and the necessary platform support pieces.

However, because there is ongoing development on Firefox in many directions, there is one issue to be aware of. Currently, WebVR in Firefox does not work with multiprocess browsing (e10s).  In order to view WebVR content, a non-e10s window must be used. 

<figure>
  <img src="mockup1.png" alt="Top: our Illustrator layout. Bottom: our layout mapped ontp a WebGL cylinder.">
  <figcaption>
    Creating non-e10s browser windows.
  </figcaption>
</figure>

You can create a new non-e10s window by going to the File menu and selecting “New Non-e10s Window”. (If instead that menu option says “New e10s Window”, then multiprocess browsing is disabled by default for you and you’re good to go.) We’re working on resolving this issue in the near future.




