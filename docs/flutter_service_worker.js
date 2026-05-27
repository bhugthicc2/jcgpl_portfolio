'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "617d0f0585e15f6d9cbe927033e853f2",
"assets/AssetManifest.bin.json": "f8aba9a71caa256b61417bc36260281b",
"assets/assets/cv/Jesie_Gapol_CV.pdf": "18b5fd7745376aa4dc73eb20bc329dca",
"assets/assets/images/profile.png": "ee51625094782c5a5589ccc200108433",
"assets/assets/images/projects/cvms.png": "5112381c446d020bb66bcb2f15b2e5fd",
"assets/assets/images/projects/cvms1.png": "6cf7c31d842926cd262ae889c29ec4d3",
"assets/assets/images/projects/cvms2.png": "4b0036a942b91c454c1454fdca94fa34",
"assets/assets/images/projects/cvms3.png": "d5e858672aa55de8f254d49017b74207",
"assets/assets/images/projects/cvms4.png": "978144bc24ec0168e0c41f5010582766",
"assets/assets/images/projects/design1.png": "6b4f406829c32ca92209f556aba0dcd8",
"assets/assets/images/projects/design2.png": "2fca0ff9a958faa936dbcdf2b7ddf416",
"assets/assets/images/projects/design3.png": "902b30bae191d8c10f52d739deae186a",
"assets/assets/images/projects/gapz_graphix.png": "c0b8ea761faa80c2fed09e1e7e9f5225",
"assets/assets/images/projects/gapz_graphix1.png": "c6dcb180b1395039aa4738b1220228c6",
"assets/assets/images/projects/gapz_graphix2.png": "008a4fa6b887b190b23334cfa76625a5",
"assets/assets/images/projects/gapz_graphix3.png": "46eb3d1be6a061cddc9352169b23b0ce",
"assets/assets/images/projects/gapz_graphix4.png": "0ff0c0f3680e768d3c59ada942e70610",
"assets/assets/images/projects/visitors_log.png": "80da2deb25628fa0b35873a6e5689444",
"assets/assets/images/projects/visitors_log1.png": "8d1be64d0e8ad0dbe7e07b077f437f47",
"assets/assets/images/projects/visitors_log2.png": "a785c3fe32c7e4e063fe9c4fb79218d3",
"assets/assets/images/projects/visitors_log3.png": "18815b84b34f3521d7a4dc7951c35dd2",
"assets/assets/images/projects/visitors_log4.png": "160feaaf57f13913b1ad41bdff0b10cb",
"assets/assets/images/projects/visitors_log5.png": "1133ec97a1c4e1ecbac6cf950137dda7",
"assets/assets/logos/cayasan_es.png": "db518a62bf882612100106b39912e2ce",
"assets/assets/logos/cogon_nhs.png": "edb300c4951dea7b32cd7c24c711b28d",
"assets/assets/logos/jrmsu.png": "44f92e0adabc46d129016d149a84d914",
"assets/assets/svg/logo.svg": "b901c9b6ad25f993e54d06ba86aa4b17",
"assets/FontManifest.json": "72f64804ce76b68c5f517435aea7d18d",
"assets/fonts/MaterialIcons-Regular.otf": "0e7f5c27057a852cb13156ac745f8bfb",
"assets/NOTICES": "d7f44aa9f1f3f1c54429f51c87397d64",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/simple_icons/fonts/SimpleIcons.ttf": "90580190a5349ea2d3a73ccca4c41e4a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "0d9efd66268a107f87aafa54a15b089a",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "3f1d7d322d34ad3ea178a0ddbecf3c88",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "0e959e5d06eeea2ef3cb9fa2a5db8042",
"/": "0e959e5d06eeea2ef3cb9fa2a5db8042",
"main.dart.js": "ecaec0a963181bcaec0def323a0706f1",
"manifest.json": "d01970c7ac811d151ac625065730a465",
"version.json": "7f95b4023ea752d87bf446d4c1b9ddce"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
