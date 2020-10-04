## Dart Cloudflare Blog Thing

DCBT is a simple blog engine similar to Jekyll running on Cloudflare Workers, made in Dart. This was mainly made to experiment with Dart on Cloudflare Workers, which is extremely annoying at times because there's no documentation or other people using Dart on them from what I could find.

The purpose of DCBT is to take in requests, and combine both HTML and Markdown files on GitHub repositories to output a templated blog. There will probably be some limitations to this in the end, however it should function.

Limitations found on Cloudflare Workers with Dart:

- It is impossible to use any HTTP libraries, as when transpiling to JS it must use an `eval` somewhere as all related libraries give errors
- You cannot use Function.apply() I believe for the same reason
- You need to wrap JS fetch events for requests which is hard to expand on from scratch. Some documentation on this or examples would be nice (This repo provides a great starting point)

