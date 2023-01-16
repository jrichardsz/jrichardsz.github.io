---
layout: post
title: How to analyze real time video from desktop browsers or smartphone native clients into remote servers - part 1
description: "I will show you the result of my preliminary research about real-time video analysis"
category: video analysis
tags: [machine-learning]
comments: true
---

<img src="https://miro.medium.com/max/720/1*UkdYyG0uJt8pGogE_dvIyA.webp" width=500>

I will show you the result of my preliminary research about real-time video analysis that took half of my 2023 vacation XD

<img src="https://user-images.githubusercontent.com/3322836/212573392-e41d2ebb-c2a5-45ec-bd30-5531646073e0.png" width=400>

My initial question was: How can I detect some pattern in a real time video using some machine learning framework like Tensorflow?

<img src="https://user-images.githubusercontent.com/3322836/212572673-c308898b-ada8-48c5-a253-8efc2e784117.png" width=400>

Image source: https://www.briefcam.com/resources/blog/what-is-real-time-video-content-analysis/

Commonly in this kind of analysis, the algorithm or program has direct access to the hardware in which the video is being recording and these are the steps:

- Access to the camera hardware
- Get the image one by one
- Draw a box o each face if the image has faces
- Show in a desktop ui the new image in which faces are marked with a box

![image](https://user-images.githubusercontent.com/3322836/212573222-43b788b3-5bcb-43b3-a573-f249251c30b1.png)

Image source: https://tanay-choudhary.github.io/project/face-recognition

As you can see in the previous image, almost every sample in the internet with languages and tools like python and opencv, are made in a standalone desktop.

Since my real goal is to have smartphones as clients which will send real time video (camera) to a remote server (nodejs, python or java)

<img src="https://user-images.githubusercontent.com/3322836/212573816-b3119d03-57d0-4d54-8fdb-59dd469f6ca7.png" width=400>

I needed to read more :)

![image](https://user-images.githubusercontent.com/3322836/212574106-eb8e201a-4c84-48d2-b9fd-2f60f0bcfcfa.png)

## Main Topics

- Sockets
- Video streaming

## Video Streaming

Since the origin or client are remotes (smartphones) I was thinking that if the client send a video streaming to the server, **would be easy** to gain access to each frame (image) of the video in the server.

<img src="https://i.pinimg.com/736x/6f/e9/fd/6fe9fd60de93a0b3c4398559320aeb42.jpg" width=400>


## Streaming from web browser

I chose web and javascript because as you know, to code in android require more than a simple plain text editor.

After a lot of lectures, I discover:

- By default, firefox/chrome browsers are able to generate *.webm videos
- You have to use a combination of :[Media Capture and Streams API](https://developer.mozilla.org/en-US/docs/Web/API/Media_Capture_and_Streams_API] and [WebRTC](https://webrtc.org/) in order to access the camera and send video to a simple http or complex socket server


## Media Capture and Streams API

Is the basic an only method to gain access to the camera with javascript

```js
navigator.mediaDevices.getUserMedia({
    video: true,
    audio: true
  }).then((stream) => {
    addVideo(stream);
  }).catch(err => {
    alert(err.message)
  })
```

Check my demo

https://jrichardsz-snippets.w3spaces.com/camera-access-from-javascript.html

and the entire code

https://gist.github.com/jrichardsz/05eae330397bfb117d5f3cc60545d984#file-javascript-camera-sandbox-snippets-show-camera-in-html-html

## Javascript video stream

**navigator.mediaDevices.getUserMedia** returns an instance of [MediaStream](https://developer.mozilla.org/en-US/docs/Web/API/MediaStream). In that moment you have to choices:

1. Send video chunks to the server: Use the [MediaRecorder](https://developer.mozilla.org/en-US/docs/Web/API/MediaRecorder) to have access to each chunk of camera video in form of [Blob](https://developer.mozilla.org/en-US/docs/Web/API/Blob) and sent it to the server
2. Send images to server: Use workaround with canvas and setInterval to take an image of camera video each second and send the image to the server (several images)

## Send video chunks to the server

I was able to send a chunk video (blob) every 250 millis to the socket server with this code:

**browser client**

```js
const socket = io('/');
navigator.mediaDevices.getUserMedia({
  video:true,
  audio:true
}).then((stream)=>{
  console.log(stream)
  let mediaRecorder = new MediaRecorder(stream, {mimeType: 'video/webm'})
  mediaRecorder.start(250);
  mediaRecorder.ondataavailable = function(e) {
      socket.emit('video', {data: e.data, timeMillis: new Date().getTime()});
  }
}).catch(err=>{
    alert(err.message)
})
```

**nodejs server**

```js
const express = require('express');
const fs = require('fs')
const path = require('path')
const app = express()
const server = require('http').Server(app)
const io = require('socket.io')(server,{maxHttpBufferSize: 1e7})

io.on('connection', function (socket) {
  socket.on('video', async function (msg) {
      var date = new Date(msg.timeMillis);
      await fs.promises.writeFile(path.join(__dirname, "videos", `${date.toString()}.webm`), msg.data, "binary");         
  });
});

server.listen(3000)
```

The problem was that only the first chunk is playable. The rest has a kind of error, so can not be seen with any player :

<img src="https://user-images.githubusercontent.com/3322836/212576514-e22df18a-c8a6-4089-a312-9dbb2619777f.png" width=400>

This part was which consumed all my free vacation time. After a lot of lectures this is my discovery based on some high ranked stackoverflow users/answers:

> An incoming *.webm video stream (chunk) is not playable because only the first chunk has an special internal information called "initial data" and the rest of incoming chunks don't have. So you need to send the entire video from the browser client (array of chunks) and then the server (socket or simple http) will be able to persist it in the disk or whatever you need

> I will put here the github url with the code ready to check if somebody, someday could fix it :)

> If I obtain a response of my comment https://stackoverflow.com/a/56062582/3957754 I could restart the attempts

So, at this part, to process the real time video in the backend is not possible because is required to send the entire video :/

References:

- https://stackoverflow.com/questions/57341945/can-see-start-of-video-stream-but-nothing-else-node-js-mp4-html5-file-signa
- https://stackoverflow.com/questions/53229528/corrupt-blob-triggered-by-mediarecorder-requestdata
- https://stackoverflow.com/questions/27957493/how-to-generate-initialization-segment-of-webm-video-to-use-with-media-source-ap
- https://jsbin.com/domeyutuba/3/edit?html,output
- https://stackoverflow.com/questions/51096770/how-to-receive-continuous-chunk-of-video-as-a-blob-array-and-set-to-video-tag-dy
- https://stackoverflow.com/questions/56051872/unable-jump-into-stream-from-media-recorder-using-media-source-with-socket-io/56062582#56062582
- https://stackoverflow.com/questions/32336313/find-bytes-range-of-webm-video-for-specified-segment
- https://stackoverflow.com/questions/37786956/media-source-extensions-appendbuffer-of-webm-stream-in-random-order
- https://stackoverflow.com/questions/71104909/can-i-send-an-arbitrary-chunk-of-a-webm-starting-at-a-byte-offset-to-a-mediaso
- https://github.com/thenickdude/webm-writer-js/issues/22
- https://github.com/node-ebml/node-ebml/blob/master/src/ebml/decoder.js
- https://github.com/mafintosh/webm-cluster-stream/blob/master/index.js
- https://developer.mozilla.org/en-US/docs/Web/API/WebCodecs_API
- https://developer.chrome.com/articles/webcodecs/

## Send images to server

I don't like this approach because is not near to real time because an interval of capture is required.

Anyway, the algorithm is:

- load the camera video into a `<video>` tag
- add take screenshot button
- on screenshot button click, access to canvas, draw the video
- use the `canvas.toBlob` to get a blob
- do whatever you want with the image blob like show it in a `<img>` or send it to the socket

Check this sample in which I', able to take screenshots from a `<video>`

```
<!DOCTYPE html> 
<html> 
<body> 

<video width="400" controls>
  <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
  Your browser does not support HTML video.
</video>

<button type="button" id="screenshot-vid-recording">
Take screenshot
</button>
<br><br>
<script>
var screenshotButton = document.getElementById("screenshot-vid-recording");
screenshotButton.addEventListener("click", onCapture);
var canvas = document.createElement("canvas")

function onCapture() {
  var video = document.querySelector("video");
  console.log(new Date(), "capture", video.videoWidth, video.videoHeight)
  canvas.width = video.videoWidth;
  canvas.height = video.videoHeight;
  canvas
    .getContext("2d")
    .drawImage(video, 0, 0, video.videoWidth, video.videoHeight);

  canvas.toBlob(async (blob) => {
    {
      const a = document.createElement('a') // Create "a" element
      const url = URL.createObjectURL(blob) // Create an object URL from blob
     var img = new Image();
     img.src = url;
     document.body.appendChild(img);      
    };
  });
}

</script>

</body> 
</html>
```

To validate it, go to https://www.w3schools.com/html/tryit.asp?filename=tryhtml5_video and replace the code with mine. Press run, play the video and take a screen

[![enter image description here][1]][1]

Here another snippet to download the image https://gist.github.com/jrichardsz/05eae330397bfb117d5f3cc60545d984#file-image-or-frame-from-video-tag-html-javascript-download-image-html

  [1]: https://i.stack.imgur.com/i36al.png


## Socket to receive the image

This socket will receive the images and store them in a **frames** folder in your workspace

```js
const express = require('express');
const fs = require('fs')
const path = require('path')
const app = express()
const server = require('http').Server(app)
const io = require('socket.io')(server,{maxHttpBufferSize: 1e7})

io.on('connection', function (socket) {
  socket.on('image', async function (msg) {
      var date = new Date(msg.timeMillis);
      await fs.promises.writeFile(path.join(__dirname, "frames", `${date.toString()}.png`), msg.data, "binary");                
  });
});

server.listen(3000)
```

## Summary

If the client is a web browser (javascript) is not possible to receive individual blob chunks from the camera to be analyzed in the backend (socket). The only way is generate an image from the video at some interval and send them to the backend. 

> If I receive a comment, I wil put the github url here of my current approach, client and server code.

I will try on android, but since the **stream** concept is the same, I think the algorithm will be the same.

## Lectures

- https://stackoverflow.com/questions/57341945/can-see-start-of-video-stream-but-nothing-else-node-js-mp4-html5-file-signa
- https://stackoverflow.com/questions/53229528/corrupt-blob-triggered-by-mediarecorder-requestdata
- https://stackoverflow.com/questions/27957493/
- https://webrtc.github.io/samples/
- https://webcamtests.com/resolution
- https://superuser.com/questions/841235/

A lot of links

https://gist.github.com/jrichardsz/280859130250dff4f995e8fb214b2dc9