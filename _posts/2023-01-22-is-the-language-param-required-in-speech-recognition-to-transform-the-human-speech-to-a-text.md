---
layout: post
title: Is the language param required in speech recognition to transform the human speech to a text?
description: "A friend told me that language is not required to transform the human speech to a text"
category: speech-to-text
tags: [machine-learning]
comments: true
---

<img src="https://user-images.githubusercontent.com/3322836/213949407-6c0a0ed0-69cf-43bc-91d8-95186bc46f16.png" width=500>

Talking with my friend about machine learning, he told me that to transform some human speech into text it is not required to know the language. So in this post I realized some test to validate that

## Goal

Having a single world in a **Latin** language, I need to get the text or string. This process is called transcription for humans or speech to text for geeks

## Transcription Services

There is a lot of these services on internet. They are widely used for tv programs , interviews, conferences, etc. Basically if you pay something, you could send a video or sound and then a human will transcribe it. How I know that a human is used? Because many years ago when I didn't have a penny (university epoch) I was looking for a job on internet and I found these kind of services:

<img src="https://user-images.githubusercontent.com/3322836/213950079-d52b94c6-3698-4344-84f6-9b77b0ea2da2.png" width=500>

Requirements is to have a perfect redaction with any error , microsoft word seniority, etc

## Speech to text 

<img src="https://user-images.githubusercontent.com/3322836/213950358-0c4a02c5-5f10-4853-9a76-4048463301fb.png" width=500>

As I am a developer, transcription service based on humans don't makes sense. 

Speech to text is a speech recognition software that enables the recognition and translation of spoken language into text through computational linguistics. It is also known as speech recognition or computer speech recognition. Specific applications, tools, and devices can transcribe audio streams in real-time to display text and act on it.

## AWS Speech to text

https://aws.amazon.com/transcribe/

<img src="https://user-images.githubusercontent.com/3322836/213950551-497598a8-02dc-42f5-a6b0-e3dee989c832.png" width=500>

## Google Speech to text

https://cloud.google.com/speech-to-text

<img src="https://user-images.githubusercontent.com/3322836/213950718-6165f6c6-7cf2-4fd1-a9b4-4ceb0d07cc0f.png" width=500>

## Offline Speech to text

As you will note, the previous services require internet because the transcription engine is in some remote and powerful server (aws, google, azure, etc)

Prior to that services, developers published a lot of algorithms and source code to do the same, Maybe the accuracy will not good but it is free.

## Speech recognition with Vosk and Python

There are several models but I tried Voks and worked. Check its official links

- https://alphacephei.com/vosk
- https://github.com/alphacep/vosk-api

Here is the code using **english** model to transcribe **latin** speech

These dependencies are required

```
pip3 install vosk
pip3 install jsonpath_ng
pip3 install pyaudio
```

```py
from vosk import Model, KaldiRecognizer
import pyaudio
from jsonpath_ng import jsonpath, parse
import json
import sys

model = Model(r"vosk-model-small-en-us-0.15")
recognizer = KaldiRecognizer(model, 16000)

mic = pyaudio.PyAudio()
stream = mic.open(format=pyaudio.paInt16, channels=1, rate=16000, input=True, frames_per_buffer=8192)
stream.start_stream()

jsonpath_expression = parse('$.text')

while True:
  data = stream.read(4096)
  
  if recognizer.AcceptWaveform(data):
      text = recognizer.Result()
      json_data = json.loads(text)
      match = jsonpath_expression.find(json_data)
      print(match[0].value)
```

I was surprised because it works at first attempt :0
Just run it and if no errors in the log (except ALSA warnings), just say something to your microphone and the transcription will be showed in the shell

## Results for <DEFENDERE> word 

I choose the word "DEFENDERE" in latin which means

<img src="https://user-images.githubusercontent.com/3322836/213952791-6bf6176e-3646-4cfa-b63c-159b86017669.png" width=500>

Here is the sound: 

https://voca.ro/16m4gog8RfJe

I tried 05 times and these are the results:

Using **ENGLISH** model

- the offended
- the thin dating
- the friend did it
- the finn did
- the offended

Using **ITALIAN** model because is "some" similar to **LATIN**

- difendere
- difendere
- difende
- difendere
- del fendi

To use a custom model, just download it from https://alphacephei.com/vosk/models, unzip it and set in the code

<img src="https://user-images.githubusercontent.com/3322836/213951787-ce62c664-2258-4244-a85c-6e0f9869715c.png" width=500>

More details here: https://stackoverflow.com/a/73304153/3957754

## Conclusion

As you could see or if you try the python code, if the language model is related to the source language used in the speech, the transcription will have a better accuracy compared with another languages